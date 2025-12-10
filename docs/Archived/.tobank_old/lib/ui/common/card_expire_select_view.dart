import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/card/expire_data.dart';
import '../../util/data_constants.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';

class CardExpireSelectWidget extends StatefulWidget {
  const CardExpireSelectWidget({
    required this.expireData,
    required this.returnData,
    super.key,
  });

  final ExpireData expireData;
  final Function(ExpireData expireData) returnData;

  @override
  CardExpireSelectWidgetState createState() => CardExpireSelectWidgetState();
}

class CardExpireSelectWidgetState extends State<CardExpireSelectWidget> {
  String? _selectedMonth;
  String? _selectedYear;

  @override
  void initState() {
    super.initState();
    if (widget.expireData.expireMonth != null && widget.expireData.expireYear != null) {
      _selectedMonth = widget.expireData.expireMonth;
      if (widget.expireData.expireYear == '99') {
        _selectedYear = '13${widget.expireData.expireYear!}';
      } else {
        _selectedYear = '14${widget.expireData.expireYear!}';
      }
    }
  }

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 36,
                    height: 4,
                    decoration:
                        BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              locale.select_exprire_date,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              locale.month,
                              style: ThemeUtil.titleStyle,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Text(
                              locale.year,
                              style: ThemeUtil.titleStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GridView(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12.0,
                              crossAxisSpacing: 12.0,
                            ),
                            children: List<Widget>.generate(DataConstants.monthNumber.length, (index) {
                              return MonthItemWidget(
                                month: DataConstants.monthNumber[index],
                                selectedMonth: _selectedMonth,
                                returnData: (selectedMonth) {
                                  setState(() {
                                    _selectedMonth = selectedMonth;
                                  });
                                },
                              );
                            }),
                          ),
                        ),
                        Expanded(
                          child: GridView(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12.0,
                              crossAxisSpacing: 12.0,
                            ),
                            children: List<Widget>.generate(DataConstants.yearNumbers().length, (index) {
                              return YearItemWidget(
                                year: DataConstants.yearNumbers()[index],
                                selectedYear: _selectedYear,
                                returnData: (selectedYear) {
                                  setState(() {
                                    _selectedYear = selectedYear;
                                  });
                                },
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ContinueButtonWidget(
                      callback: () {
                        _validate();
                      },
                      isLoading: false,
                      buttonTitle:locale.confirmation,
                      isEnabled: isSelectedValid(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validate() {
    if (_selectedMonth != null && _selectedYear != null && _selectedYear!.length == 4 && _selectedMonth!.length == 2) {
      final ExpireData expireData = ExpireData();
      expireData.expireMonth = _selectedMonth;
      expireData.expireYear = _selectedYear![2] + _selectedYear![3];
      widget.returnData(expireData);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  bool isSelectedValid() {
    return (_selectedMonth != null &&
        _selectedYear != null &&
        _selectedYear!.length == 4 &&
        _selectedMonth!.length == 2);
  }
}

class MonthItemWidget extends StatelessWidget {
  const MonthItemWidget({
    this.month,
    this.selectedMonth,
    this.returnData,
    super.key,
  });

  final String? month;
  final String? selectedMonth;
  final Function(String? month)? returnData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: selectedMonth == month ? context.theme.colorScheme.secondary.withOpacity(0.15) : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(
              color: selectedMonth == month ? context.theme.colorScheme.secondary : context.theme.dividerColor,
              width: 2.0)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            returnData!(month);
          },
          child: Center(
            child: Text(
              month ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ThemeUtil.textTitleColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class YearItemWidget extends StatelessWidget {
  const YearItemWidget({
    this.year,
    this.selectedYear,
    this.returnData,
    super.key,
  });

  final String? year;
  final String? selectedYear;
  final Function(String? year)? returnData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selectedYear == year ? context.theme.colorScheme.secondary.withOpacity(0.15) : Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(
            color: selectedYear == year ? context.theme.colorScheme.secondary : context.theme.dividerColor, width: 2.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            returnData!(year);
          },
          child: Center(
            child: Text(
              year ?? '',
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
