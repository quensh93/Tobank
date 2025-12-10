import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'month_name_handler.dart';

/// Created by Marcin Szałek

///Define a text mapper to transform the text displayed by the picker
typedef TextMapper = String Function(String numberText);

///NumberPicker is a widget designed to pick a number between #minValue and #maxValue
class NumberPicker extends StatelessWidget {
  ///height of every list element for normal number picker
  ///width of every list element for horizontal number picker
  static const double kDefaultItemExtent = 50.0;

  ///width of list view for normal number picker
  ///height of list view for horizontal number picker
  static const double kDefaultListViewCrossAxisSize = 100.0;

  ///constructor for integer number picker
  NumberPicker.integer({
    required int initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    super.key,
    this.enabled = true,
    this.textMapper,
    this.itemExtent = kDefaultItemExtent,
    this.listViewWidth = kDefaultListViewCrossAxisSize,
    this.step = 1,
    this.scrollDirection = Axis.vertical,
    this.zeroPad = false,
    this.highlightSelectedValue = true,
    this.decoration,
    this.haptics = false,
    this.fontFamily = '',
    this.selectedColor,
    this.unselectedColor,
    this.isShowMonthName = false,
    this.isJalali = false,
  })  : assert(maxValue >= minValue),
        // assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedIntValue = (initialValue < minValue) ? minValue : ((initialValue > maxValue) ? maxValue : initialValue),
        selectedDecimalValue = -1,
        decimalPlaces = 0,
        intScrollController = ScrollController(
          initialScrollOffset: (((initialValue < minValue) ? minValue : ((initialValue > maxValue) ? maxValue : initialValue)) - minValue) ~/ step * itemExtent,
        ),
        decimalScrollController = null,
        listViewHeight = 3 * itemExtent,
        integerItemCount = (maxValue - minValue) ~/ step + 1 {
    // Don't call onChanged in constructor to avoid triggering rebuilds during initialization
    // onChanged(selectedIntValue);
  }

  ///called when selected value changes
  final ValueChanged<num> onChanged;

  ///min value user can pick
  final int minValue;

  ///max value user can pick
  final int maxValue;

  ///build the text of each item on the picker
  final bool enabled;

  ///build the text of each item on the picker
  final TextMapper? textMapper;

  ///inidcates how many decimal places to show
  /// e.g. 0=>[1,2,3...], 1=>[1.0, 1.1, 1.2...]  2=>[1.00, 1.01, 1.02...]
  final int decimalPlaces;

  ///height of every list element in pixels
  final double itemExtent;

  ///height of list view in pixels
  final double listViewHeight;

  ///width of list view in pixels
  final double? listViewWidth;

  ///ScrollController used for integer list
  final ScrollController intScrollController;

  ///ScrollController used for decimal list
  final ScrollController? decimalScrollController;

  ///Currently selected integer value
  final int selectedIntValue;

  ///Currently selected decimal value
  final int selectedDecimalValue;

  ///If currently selected value should be highlighted
  final bool highlightSelectedValue;

  ///Decoration to apply to central box where the selected value is placed
  final Decoration? decoration;

  ///Step between elements. Only for integer datePicker
  ///Examples:
  /// if step is 100 the following elements may be 100, 200, 300...
  /// if min=0, max=6, step=3, then items will be 0, 3 and 6
  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final int step;

  /// Direction of scrolling
  final Axis scrollDirection;

  ///Pads displayed integer values up to the length of maxValue
  final bool zeroPad;

  ///Amount of items
  final int integerItemCount;

  ///Whether to trigger haptic pulses or not
  final bool haptics;

  ///Set font family
  final String fontFamily;

  ///Set selected numbers font color
  final Color? selectedColor;

  ///Set unselected numbers font color
  final Color? unselectedColor;

  //Show month name instead of month int place in the year
  final bool? isShowMonthName;

  //isJalali for get the month right name
  final bool? isJalali;

  //
  //----------------------------- PUBLIC ------------------------------
  //

  /// Used to animate integer number picker to new selected value
  void animateInt(int valueToSelect) {
    final int diff = valueToSelect - minValue;
    final int index = diff ~/ step;
    animateIntToIndex(index);
  }

  /// Used to animate integer number picker to new selected index
  void animateIntToIndex(int index) {
    _animate(intScrollController, index * itemExtent);
  }

  /// Used to animate decimal part of double value to new selected value
  void animateDecimal(int decimalValue) {
    _animate(decimalScrollController!, decimalValue * itemExtent);
  }

  /// Used to animate decimal number picker to selected value
  void animateDecimalAndInteger(double valueToSelect) {
    animateInt(valueToSelect.floor());
    animateDecimal(((valueToSelect - valueToSelect.floorToDouble()) * math.pow(10, decimalPlaces)).round());
  }

  //
  //----------------------------- VIEWS -----------------------------
  //

  ///main widget
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return _integerListView(themeData);
  }

  Widget _integerListView(ThemeData themeData) {
    TextStyle defaultStyle;
    TextStyle selectedStyle;
    defaultStyle = themeData.textTheme.bodyLarge!.copyWith(fontFamily: fontFamily, color: unselectedColor);
    selectedStyle = TextStyle(
      color: selectedColor ?? themeData.colorScheme.secondary,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w900,
      fontSize: 16.0,
    );

    final listItemCount = integerItemCount + 2;

    return Listener(
      onPointerUp: (ev) {
        ///used to detect that user stopped scrolling
        // Note: activity is private, so we use a different approach
        if (intScrollController.hasClients) {
          animateInt(selectedIntValue);
        }
      },
      child: NotificationListener(
        onNotification: _onIntegerNotification,
        child: SizedBox(
          height: listViewHeight,
          width: listViewWidth,
          child: Stack(
            children: <Widget>[
              ListView.builder(
                scrollDirection: scrollDirection,
                controller: intScrollController,
                itemExtent: itemExtent,
                physics: enabled ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
                itemCount: listItemCount,
                cacheExtent: _calculateCacheExtent(listItemCount),
                itemBuilder: (BuildContext context, int index) {
                  final int value = _intValueFromIndex(index);

                  //define special style for selected (middle) element
                  final TextStyle itemStyle =
                      value == selectedIntValue && highlightSelectedValue ? selectedStyle : defaultStyle;

                  final bool isExtra = index == 0 || index == listItemCount - 1;

                  return isExtra
                      ? Container() //empty first and last element
                      : Card(
                          elevation: value == selectedIntValue && highlightSelectedValue ? 2 : 0,
                          color: value == selectedIntValue && highlightSelectedValue
                              ? Theme.of(context).colorScheme.surface
                              : Colors.transparent,
                          margin: EdgeInsets.zero,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: value == selectedIntValue && highlightSelectedValue
                                  ? Theme.of(context).dividerColor
                                  : Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              getDisplayedValue(value),
                              style: itemStyle,
                            ),
                          ),
                        );
                },
              ),
              _NumberPickerSelectedItemDecoration(
                axis: scrollDirection,
                itemExtent: itemExtent,
                decoration: decoration,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDisplayedValue(int value) {
    if (isShowMonthName == true) {
      return value.getMonthName(isJalali == true);
    } else {
      final text = zeroPad ? value.toString().padLeft(maxValue.toString().length, '0') : value.toString();
      return textMapper != null ? textMapper!(text) : text;
    }
  }

  //
  // ----------------------------- LOGIC -----------------------------
  //

  int _intValueFromIndex(int index) {
    index--;
    index %= integerItemCount;
    return minValue + index * step;
  }

  bool _onIntegerNotification(Notification notification) {
    if (notification is ScrollNotification) {
      //calculate
      int intIndexOfMiddleElement = (notification.metrics.pixels / itemExtent).round();
      intIndexOfMiddleElement = intIndexOfMiddleElement.clamp(0, integerItemCount - 1);
      int intValueInTheMiddle = _intValueFromIndex(intIndexOfMiddleElement + 1);
      intValueInTheMiddle = _normalizeIntegerMiddleValue(intValueInTheMiddle);

      if (_userStoppedScrolling(notification, intScrollController)) {
        //center selected value
        animateIntToIndex(intIndexOfMiddleElement);
      }

      //update selection
      if (intValueInTheMiddle != selectedIntValue) {
        num newValue;
        if (decimalPlaces == 0) {
          //return integer value
          newValue = (intValueInTheMiddle);
        } else {
          if (intValueInTheMiddle == maxValue) {
            //if new value is maxValue, then return that value and ignore decimal
            newValue = (intValueInTheMiddle.toDouble());
            animateDecimal(0);
          } else {
            //return integer+decimal
            final double decimalPart = _toDecimal(selectedDecimalValue);
            newValue = ((intValueInTheMiddle + decimalPart).toDouble());
          }
        }
        if (haptics) {
          HapticFeedback.selectionClick();
        }
        onChanged(newValue);
      }
    }
    return true;
  }

  ///There was a bug, when if there was small integer range, e.g. from 1 to 5,
  ///When user scrolled to the top, whole listview got displayed.
  ///To prevent this we are calculating cacheExtent by our own so it gets smaller if number of items is smaller
  double _calculateCacheExtent(int itemCount) {
    double cacheExtent = 250.0; //default cache extent
    if ((itemCount - 2) * kDefaultItemExtent <= cacheExtent) {
      cacheExtent = ((itemCount - 3) * kDefaultItemExtent);
    }
    return cacheExtent;
  }

  ///When overscroll occurs on iOS,
  ///we can end up with value not in the range between [minValue] and [maxValue]
  ///To avoid going out of range, we change values out of range to border values.
  int _normalizeMiddleValue(int valueInTheMiddle, int min, int max) {
    return math.max(math.min(valueInTheMiddle, max), min);
  }

  int _normalizeIntegerMiddleValue(int integerValueInTheMiddle) {
    //make sure that max is a multiple of step
    final int max = (maxValue ~/ step) * step;
    return _normalizeMiddleValue(integerValueInTheMiddle, minValue, max);
  }

  ///indicates if user has stopped scrolling so we can center value in the middle
  bool _userStoppedScrolling(
    Notification notification,
    ScrollController scrollController,
  ) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.hasClients &&
        !scrollController.position.isScrollingNotifier.value;
  }

  ///converts integer indicator of decimal value to double
  ///e.g. decimalPlaces = 1, value = 4  >>> result = 0.4
  ///     decimalPlaces = 2, value = 12 >>> result = 0.12
  double _toDecimal(int decimalValueAsInteger) {
    return double.parse((decimalValueAsInteger * math.pow(10, -decimalPlaces)).toStringAsFixed(decimalPlaces));
  }

  ///scroll to selected value
  void _animate(ScrollController scrollController, double value) {
    scrollController.animateTo(
      value,
      duration: const Duration(seconds: 1),
      curve: const ElasticOutCurve(),
    );
  }
}

class _NumberPickerSelectedItemDecoration extends StatelessWidget {
  final Axis axis;
  final double itemExtent;
  final Decoration? decoration;

  const _NumberPickerSelectedItemDecoration({
    required this.axis,
    required this.itemExtent,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IgnorePointer(
        child: Container(
          width: isVertical ? double.infinity : itemExtent,
          height: isVertical ? itemExtent : double.infinity,
          decoration: decoration,
        ),
      ),
    );
  }

  bool get isVertical => axis == Axis.vertical;
}

