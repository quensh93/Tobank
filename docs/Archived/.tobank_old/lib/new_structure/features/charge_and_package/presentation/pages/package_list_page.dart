import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../ui/common/custom_app_bar.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../../core/entities/charge_and_package_list_data_entity.dart';
import '../../../../core/entities/charge_and_package_payment_plan_params.dart';
import '../../../../core/entities/enums.dart';
import '../../../../core/entities/payment_data.dart';
import '../../../../core/theme/box_decorations.dart';
import '../../../../core/theme/main_theme.dart';
import '../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../../select_payment/presentation/pages/select_payment_list_main_page.dart';

final locale = AppLocalizations.of(Get.context!)!;

class PackageListPage extends StatefulWidget {
  final ChargeAndPackageListDataEntity chargeAndPackages;
  final String phone;

  const PackageListPage({
    required this.chargeAndPackages,
    required this.phone,
    super.key,
  });

  @override
  State<PackageListPage> createState() => _AddSimPageState();
}

class _AddSimPageState extends State<PackageListPage> {
  List<ChargeContent> _tempItems = [];

  @override
  void initState() {
    _setFilterUpdate();
    super.initState();
  }

  PackageType _filterType = PackageType.DAILY;

  void _setFilterUpdate() {
    if (_filterType != PackageType.OTHERS) {
      _tempItems =
          widget.chargeAndPackages.findAllResponse!.content!.where((e) => e.type == _filterType).toList();
    } else {
      _tempItems = widget.chargeAndPackages.findAllResponse!.content!
          .where((e) =>
              e.type != PackageType.DAILY && e.type != PackageType.WEEKLY && e.type != PackageType.MONTHLY)
          .toList();
    }
    setState(() {
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          titleString: locale.internet,
          context: context,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimeFilterHeaders(
                  onSelected: (TimeFilterModel timeFilter) {
                    _filterType = timeFilter.type;
                    _setFilterUpdate();
                  },
                ),
                //sim list
                Expanded(
                    child: _tempItems.isEmpty
                        ? _noListItem()
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            itemCount: _tempItems.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return getPackageListView(item: _tempItems[index]);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10);
                            },
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getPackageListView({required ChargeContent item}) {
    final formatter = intl.NumberFormat('#,###');
    return InkWell(
      onTap: () {
        showMainBottomSheet(
            context: context,
            bottomSheetWidget: SelectPaymentListMainPage(
              paymentData: PaymentData(
                title: widget.phone.toString(),
                data: ChargeAndPackagePaymentPlanParams(
                  taxPercent: widget.chargeAndPackages.taxPercent ?? 0,
                  minimumAmount: widget.chargeAndPackages.minimumAmount ?? 0,
                  maximumAmount: widget.chargeAndPackages.maximumAmount ?? 0,
                  operatorType: item.operator,
                  chargeAndPackageType: ChargeAndPackageType.INTERNET,
                  amount: item.amounts!.first.amountWithTax!,
                  depositNumber: '',
                  serviceType: ChargeAndPackageType.INTERNET,
                  mobile: widget.phone,
                  productCode: item.code!,
                  // productType: item.type!,
                  productType: ChargeAndPackageTagType.NORMAL,
                  wallet: false,
                ),
                paymentType: PaymentListType.package,
              ),
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const SvgIcon(
              SvgIcons.icPackage,
              size: 30,
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Text(
              '${item.name!} + ${locale.tax}',
              style: MainTheme.of(context).textTheme.bodyLarge,
              softWrap: true,
            )),
            const SizedBox(width: 8),
            Text(
              formatter.format(item.amounts!.first.amountWithTax),
              style: MainTheme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 8),
            SvgIcon(
              SvgIcons.arrowLeftNew,
              colorFilter:ColorFilter.mode( MainTheme.of(context).black , BlendMode.srcIn) ,
              size: 26,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _noListItem() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SvgIcon(
            SvgIcons.icPackageEmptyList,
          ),
          Text(locale.no_package_found, style: MainTheme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}

class TimeFilterModel {
  final PackageType type;
  final String title;

  TimeFilterModel({required this.type, required this.title});
}

class TimeFilterHeaders extends StatefulWidget {
  final Function(TimeFilterModel) onSelected;

  TimeFilterHeaders({required this.onSelected});

  @override
  _TimeFilterHeadersState createState() => _TimeFilterHeadersState();
}

class _TimeFilterHeadersState extends State<TimeFilterHeaders> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          getFilterList().length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onSelected(getFilterList()[index]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: _selectedIndex == index
                  ? BoxDecorations.secondaryContainerFillSecondaryBorder
                  : BoxDecorations.onSurfaceBorder,
              child: Text(
                getFilterList()[index].title,
                style: MainTheme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<TimeFilterModel> getFilterList() {
    final List<TimeFilterModel> filters = [
      TimeFilterModel(type: PackageType.DAILY, title: PackageType.DAILY.getString(context)),
      TimeFilterModel(type: PackageType.WEEKLY, title: locale.weekly),
      TimeFilterModel(type: PackageType.MONTHLY, title: locale.monthly),
      TimeFilterModel(type: PackageType.OTHERS, title: locale.others_),
    ];
    return filters;
  }
}
