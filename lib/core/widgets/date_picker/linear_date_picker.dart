import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'number_picker.dart';

class LinearDatePicker extends StatefulWidget {
  final bool showDay;
  final Function(String date) onDateSelected;

  final String startDate;
  final String endDate;
  final String? initialDate;

  final String fontFamily;

  final Color? textColor;
  final Color? selectedColor;
  final Color? unselectedColor;

  final String yearText;
  final String monthText;
  final String dayText;

  final bool showLabels;
  final double columnWidth;
  final bool isJalaali;
  final bool showMonthName;

  const LinearDatePicker({
    required this.onDateSelected,
    super.key,
    this.startDate = '',
    this.endDate = '',
    this.initialDate,
    this.showDay = true,
    this.fontFamily = '',
    this.textColor,
    this.selectedColor,
    this.unselectedColor,
    this.yearText = 'سال',
    this.monthText = 'ماه',
    this.dayText = 'روز',
    this.showLabels = true,
    this.columnWidth = 55.0,
    this.isJalaali = false,
    this.showMonthName = false,
  });

  @override
  LinearDatePickerState createState() => LinearDatePickerState();
}

class LinearDatePickerState extends State<LinearDatePicker> {
  int? _selectedYear;
  int? _selectedMonth;
  late int _selectedDay;

  int? minYear;
  int? maxYear;

  int minMonth = 01;
  int maxMonth = 12;

  int minDay = 01;
  int maxDay = 31;

  @override
  void initState() {
    super.initState();
    if (widget.isJalaali) {
      minYear = Jalali.now().year - 100;
      maxYear = Jalali.now().year;
    } else {
      minYear = Gregorian.now().year - 100;
      maxYear = Gregorian.now().year;
    }
    if (widget.initialDate != null && widget.initialDate!.isNotEmpty) {
      final List<String> initList = widget.initialDate!.split('/');
      if (initList.length >= 3) {
        _selectedYear = int.parse(initList[0]);
        _selectedMonth = int.parse(initList[1]);
        if (widget.showDay) {
          _selectedDay = int.parse(initList[2]);
        } else {
          _selectedDay = widget.isJalaali ? Jalali.now().day : Jalali.now().day;
        }
      }
    } else {
      if (widget.isJalaali) {
        _selectedYear = Jalali.now().year;
        _selectedMonth = Jalali.now().month;
        _selectedDay = Jalali.now().day;
      } else {
        _selectedYear = Gregorian.now().year;
        _selectedMonth = Gregorian.now().month;
        _selectedDay = Gregorian.now().day;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      // Ensure values are initialized
      if (_selectedYear == null) {
        _selectedYear = widget.isJalaali ? Jalali.now().year : Gregorian.now().year;
      }
      if (_selectedMonth == null) {
        _selectedMonth = widget.isJalaali ? Jalali.now().month : Gregorian.now().month;
      }
      
      maxDay = _getMonthLength(_selectedYear, _selectedMonth);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: widget.showLabels,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: widget.columnWidth,
                  child: Text(
                    widget.yearText,
                    style: TextStyle(
                      fontFamily: widget.fontFamily,
                      color: widget.textColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                  width: widget.columnWidth,
                  child: Text(
                    widget.monthText,
                    style: TextStyle(
                      fontFamily: widget.fontFamily,
                      color: widget.textColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  )),
              Visibility(
                visible: widget.showDay,
                child: SizedBox(
                    width: widget.columnWidth,
                    child: Text(
                      widget.dayText,
                      style: TextStyle(
                        fontFamily: widget.fontFamily,
                        color: widget.textColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumberPicker.integer(
                listViewWidth: widget.columnWidth,
                initialValue: _selectedYear ?? (widget.isJalaali ? Jalali.now().year : Gregorian.now().year),
                minValue: _getMinimumYear() ?? (widget.isJalaali ? Jalali.now().year - 100 : Gregorian.now().year - 100),
                maxValue: _getMaximumYear(),
                fontFamily: widget.fontFamily,
                selectedColor: widget.selectedColor,
                unselectedColor: widget.unselectedColor,
                onChanged: (value) {
                  String selectedMonth = _selectedMonth.toString();
                  if (_selectedMonth! < 10) {
                    selectedMonth = '0$_selectedMonth';
                  }
                  String selectedDay = _selectedDay.toString();
                  if (_selectedDay < 10) {
                    selectedDay = '0$_selectedDay';
                  }
                  setState(() {
                    _selectedYear = value as int?;
                    if (widget.showDay) {
                      widget.onDateSelected('$_selectedYear/$selectedMonth/$selectedDay');
                    } else {
                      widget.onDateSelected('$_selectedYear/$selectedMonth');
                    }
                  });
                }),
            NumberPicker.integer(
                listViewWidth: widget.columnWidth,
                initialValue: _selectedMonth ?? (widget.isJalaali ? Jalali.now().month : Gregorian.now().month),
                minValue: _getMinimumMonth(),
                maxValue: _getMaximumMonth(),
                fontFamily: widget.fontFamily,
                selectedColor: widget.selectedColor,
                unselectedColor: widget.unselectedColor,
                isShowMonthName: widget.showMonthName,
                isJalali: widget.isJalaali,
                enabled: true,
                onChanged: (value) {
                  String selectedMonth = _selectedMonth.toString();
                  if (_selectedMonth! < 10) {
                    selectedMonth = '0$_selectedMonth';
                  }
                  String selectedDay = _selectedDay.toString();
                  if (_selectedDay < 10) {
                    selectedDay = '0$_selectedDay';
                  }
                  setState(() {
                    _selectedMonth = value as int?;
                    if (widget.showDay) {
                      widget.onDateSelected('$_selectedYear/$selectedMonth/$selectedDay');
                    } else {
                      widget.onDateSelected('$_selectedYear/$selectedMonth');
                    }
                  });
                }),
            Visibility(
              visible: widget.showDay,
              child: NumberPicker.integer(
                  listViewWidth: widget.columnWidth,
                  initialValue: _selectedDay,
                  minValue: _getMinimumDay(),
                  maxValue: _getMaximumDay(),
                  fontFamily: widget.fontFamily,
                  selectedColor: widget.selectedColor,
                  unselectedColor: widget.unselectedColor,
                  onChanged: (value) {
                    String selectedMonth = _selectedMonth.toString();
                    if (_selectedMonth! < 10) {
                      selectedMonth = '0$_selectedMonth';
                    }
                    String selectedDay = _selectedDay.toString();
                    if (_selectedDay < 10) {
                      selectedDay = '0$_selectedDay';
                    }
                    setState(() {
                      _selectedDay = value as int;
                      if (widget.showDay) {
                        widget.onDateSelected('$_selectedYear/$selectedMonth/$selectedDay');
                      } else {
                        widget.onDateSelected('$_selectedYear/$selectedMonth');
                      }
                    });
                  }),
            )
          ],
        ),
      ],
    );
    } catch (e, stackTrace) {
      // Log error and return error widget
      debugPrint('Error building LinearDatePicker: $e');
      debugPrint('Stack trace: $stackTrace');
      return Container(
        padding: const EdgeInsets.all(16),
        child: Text('Error in date picker: $e'),
      );
    }
  }

  int _getMonthLength(int? selectedYear, int? selectedMonth) {
    if (widget.isJalaali) {
      if (selectedMonth! <= 6) {
        return 31;
      }
      if (selectedMonth > 6 && selectedMonth < 12) {
        return 30;
      }
      if (Jalali(selectedYear!).isLeapYear()) {
        return 30;
      } else {
        return 29;
      }
    } else {
      DateTime firstOfNextMonth;
      if (selectedMonth == 12) {
        firstOfNextMonth = DateTime(selectedYear! + 1, 1, 1, 12); //year, selectedMonth, day, hour
      } else {
        firstOfNextMonth = DateTime(selectedYear!, selectedMonth! + 1, 1, 12);
      }
      final int numberOfDaysInMonth = firstOfNextMonth.subtract(const Duration(days: 1)).day;
      //.subtract(Duration) returns a DateTime, .day gets the integer for the day of that DateTime
      return numberOfDaysInMonth;
    }
  }

  int _getMinimumMonth() {
    if (widget.startDate.isNotEmpty) {
      final startList = widget.startDate.split('/');
      final int startMonth = int.parse(startList[1]);

      if (_selectedYear == _getMinimumYear()) {
        return startMonth;
      }
    }

    return minMonth;
  }

  int _getMaximumMonth() {
    if (widget.endDate.isNotEmpty) {
      final endList = widget.endDate.split('/');
      final int endMonth = int.parse(endList[1]);
      if (_selectedYear == _getMaximumYear()) {
        return endMonth;
      }
    }
    return maxMonth;
  }

  int? _getMinimumYear() {
    if (widget.startDate.isNotEmpty) {
      final startList = widget.startDate.split('/');
      return int.parse(startList[0]);
    }
    return minYear;
  }

  int _getMaximumYear() {
    if (widget.endDate.isNotEmpty) {
      final endList = widget.endDate.split('/');
      return int.parse(endList[0]);
    }
    return maxYear ?? 0;
  }

  int _getMinimumDay() {
    if (widget.startDate.isNotEmpty && widget.showDay) {
      final startList = widget.startDate.split('/');
      final int startDay = int.parse(startList[2]);

      if (_selectedYear == _getMinimumYear() && _selectedMonth == _getMinimumMonth()) {
        return startDay;
      }
    }

    return minDay;
  }

  int _getMaximumDay() {
    if (widget.endDate.isNotEmpty && widget.showDay) {
      final endList = widget.endDate.split('/');
      final int endDay = int.parse(endList[2]);
      if (_selectedYear == _getMaximumYear() && _selectedMonth == _getMinimumMonth()) {
        return endDay;
      }
    }
    return _getMonthLength(_selectedYear, _selectedMonth);
  }
}

