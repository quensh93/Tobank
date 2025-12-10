import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../ui/common/custom_error.dart';
import '../../../../../../ui/common/custom_loading.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../../core/entities/installment_list_data_entity.dart';
import '../../../../../core/entities/installment_list_params.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../bloc/installment_list_bloc/installment_list_bloc.dart';
import 'loan_payment_list_item_widget.dart';

class LoanPaymentListMainPageScaffoldWidget extends StatefulWidget {
  const LoanPaymentListMainPageScaffoldWidget({
    super.key,
  });

  @override
  State<LoanPaymentListMainPageScaffoldWidget> createState() => _LoanPaymentListMainPageScaffoldWidgetState();
}

class _LoanPaymentListMainPageScaffoldWidgetState extends State<LoanPaymentListMainPageScaffoldWidget> {
  final InstallmentListBloc _installmentListBloc = getIt<InstallmentListBloc>();
  late List<InstallmentListDataEntity> loanPaymentList = [];

  @override
  void initState() {
    getListData();
    super.initState();
  }

  void getListData() {
    _installmentListBloc.add(const InstallmentListEvent.getInstallmentList(InstallmentListParams(
      installmentType: 'myself',
      nationalCode: '',
      fileNumber: '',
    )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _installmentListBloc,
      child: BlocConsumer<InstallmentListBloc, InstallmentListState>(
        listener: (context, state) {
          state.maybeMap(
              loading: (_) {},
              orElse: () {},
              loadFailure: (e) async {
                // await Future.delayed(const Duration(seconds: 5)).then((_){
                //   getListData();
                // });
                // loanPaymentList.add(InstallmentListDataEntity(
                //   deliveryDate: '1403/12/06',
                //   fileNumber: '110-1003-1652047-1',
                //   firstUnpaidInstallmentNumber: '7',
                //   loan: 'قرض الحسنه ازدواج - توبانک',
                //   nextPayDate: 5,
                //   unpaidInstallmentNumber: 114,
                // ));
                // loanPaymentList.add(InstallmentListDataEntity(
                //   deliveryDate: '1393/11/05',
                //   fileNumber: '110-3000-147685-1',
                //   firstUnpaidInstallmentNumber: '1',
                //   loan: 'مرابحه',
                //   nextPayDate: 9,
                //   unpaidInstallmentNumber: 0,
                // ));
              },
              loadSuccess: (state) async {
                loanPaymentList = state.installmentListResponse;
                //  await Future.delayed(const Duration(seconds: 5)).then((_){
                //    getListData();
                // });
              });
        },
        builder: (context, state) {

//locale
          final locale = AppLocalizations.of(context)!;
          return state.maybeMap(
            loadSuccess: (_) {
              if (loanPaymentList.isNotEmpty) {
                return ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                  itemBuilder: (BuildContext context, int index) {
                    return LoanPaymentListItemWidget(
                      installmentData: loanPaymentList[index],
                    );
                  },
                  itemCount: loanPaymentList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                );
              } else {
                return noListItem(context);
              }
            },
            loadFailure: (state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomError(
                  message: locale.problem_in_server,
                  retryFunction: () {
                    getListData();
                  },
                  backFunction: () {
                    Get.back();
                  },
                ),
              );
              // return Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(16.0),
              //       child: CustomError(
              //         message: 'در سرور مشکلی رخ داده است',
              //         retryFunction: () {
              //           getListData();
              //         },
              //         backFunction: () {
              //           Get.back();
              //         },
              //       ),
              //     ),
              //     const SizedBox(height: 10),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         InkWell(
              //           onTap: () {
              //             DialogHandler.showDialogMessage(
              //               buildContext: context,
              //               message: 'شارژ حساب',
              //               description: 'آیا از شارژ حساب خود اطمینان دارید؟',
              //               positiveMessage: 'بله',
              //               negativeMessage: 'خیر',
              //               iconPath: SvgIcons.dialogAlert,
              //               positiveFunction: () async {
              //                 Get.back();
              //               },
              //               negativeFunction: () {
              //                 Get.back();
              //               },
              //             );
              //           },
              //           child: Container(
              //             height: 30,
              //             width: 100,
              //             color: Colors.red.withAlpha(40),
              //             child: const Center(
              //               child: Text('dialog 1'),
              //             ),
              //           ),
              //         ),
              //         InkWell(
              //           onTap: () {
              //             DialogHandler.showDialogMessage(
              //               buildContext: context,
              //               message: 'مسدودی حساب',
              //               description:
              //                   'امکان پرداخت از هیچ ‌یک از حساب‌های شما وجود ندارد. لطفاً وضعیت حساب‌های خود را بررسی کنید',
              //               positiveMessage: 'متوجه شدم',
              //               iconPath: SvgIcons.dialogAlert,
              //               positiveFunction: () async {
              //                 Get.back();
              //               },
              //               negativeFunction: () {
              //                 Get.back();
              //               },
              //             );
              //           },
              //           child: Container(
              //             height: 30,
              //             width: 100,
              //             color: Colors.red.withAlpha(40),
              //             child: const Center(
              //               child: Text('dialog 2'),
              //             ),
              //           ),
              //         ),
              //         InkWell(
              //           onTap: () {
              //             DialogHandler.showDialogMessage(
              //               buildContext: context,
              //               message: 'تسهیلات مورد نظر تسویه گردیده است',
              //               positiveMessage: 'تایید',
              //               positiveFunction: () async {
              //                 Get.back();
              //               },
              //               negativeFunction: () {
              //                 Get.back();
              //               },
              //             );
              //           },
              //           child: Container(
              //             height: 30,
              //             width: 100,
              //             color: Colors.red.withAlpha(40),
              //             child: const Center(
              //               child: Text('dialog 3'),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     const SizedBox(height: 10),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         InkWell(
              //           onTap: () {
              //             Get.to(() => const LoanPaymentReceiptMainPage(
              //                   receiptType: ReceiptType.success,
              //                   destinationType: DestinationType.deposit,
              //                 ));
              //           },
              //           child: Container(
              //             height: 30,
              //             width: 100,
              //             color: Colors.red.withAlpha(40),
              //             child: const Center(
              //               child: Text('result success'),
              //             ),
              //           ),
              //         ),
              //         InkWell(
              //           onTap: () {
              //             Get.to(() => const LoanPaymentReceiptMainPage(
              //                   receiptType: ReceiptType.fail,
              //                   destinationType: DestinationType.deposit,
              //                 ));
              //           },
              //           child: Container(
              //             height: 30,
              //             width: 100,
              //             color: Colors.red.withAlpha(40),
              //             child: const Center(
              //               child: Text('result fail'),
              //             ),
              //           ),
              //         ),
              //         InkWell(
              //           onTap: () {
              //             Get.to(() => const LoanPaymentReceiptMainPage(
              //                   receiptType: ReceiptType.unknown,
              //                   destinationType: DestinationType.deposit,
              //                 ));
              //           },
              //           child: Container(
              //             height: 30,
              //             width: 100,
              //             color: Colors.red.withAlpha(40),
              //             child: const Center(
              //               child: Text('result unknown'),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // );
            },
            orElse: () {
              return noListItem(context);
            },
            loading: (_) {
              return const Center(child: CustomLoading());
            },
          );
        },
      ),
    );
  }
}

Widget noListItem(BuildContext context) {
  //locale
  final locale = AppLocalizations.of(Get.context!)!;
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SvgIcon(
          SvgIcons.loanListNoItem,
          size: 243.0,
        ),
        const SizedBox(width: 8),
        Text(
          locale.you_have_no_active_loan,
          textAlign: TextAlign.center,
          style:MainTheme.of(context).textTheme.titleMedium
        ),
      ],
    ),
  );
}
