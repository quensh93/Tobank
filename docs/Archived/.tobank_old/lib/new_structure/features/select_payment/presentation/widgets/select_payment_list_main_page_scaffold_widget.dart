import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../../ui/common/custom_error.dart';
import '../../../../../../ui/common/custom_loading.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../../controller/main/main_controller.dart';
import '../../../../../util/app_util.dart';
import '../../../../core/entities/charge_and_package_payment_plan_params.dart';
import '../../../../core/entities/charge_deposit_data.dart';
import '../../../../core/entities/deposits_list_entity.dart';
import '../../../../core/entities/deposits_list_params.dart';
import '../../../../core/entities/enums.dart';
import '../../../../core/entities/installment_payment_plan_params.dart';
import '../../../../core/entities/payment_data.dart';
import '../../../../core/entities/receipt_data.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/theme/main_theme.dart';
import '../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../../../core/widgets/buttons/main_button.dart';
import '../../../../core/widgets/dialogs/dialog_handler.dart';
import '../../../loan_payment/presentation/pages/loan_payment_receipt_main_page.dart';
import '../bloc/charge_and_package_payment_plan_bloc/charge_and_package_payment_plan_bloc.dart';
import '../bloc/installment_Settlement_payment_plan_bloc/installment_settlement_payment_plan_bloc.dart';
import '../bloc/installment_payment_plan_bloc/installment_payment_plan_bloc.dart';
import '../bloc/select_payment_list_bloc/select_payment_list_bloc.dart';
import 'charge_deposit_detail_bottom_sheet.dart';
import 'select_payment_list_widget.dart';
import 'wallet_payment_widget.dart';

class SelectPaymentListMainPageScaffoldWidget extends StatefulWidget {
  final PaymentData<dynamic> paymentData;

  const SelectPaymentListMainPageScaffoldWidget({
    required this.paymentData,
    // this.nationalCode,
    super.key,
  });

  @override
  State<SelectPaymentListMainPageScaffoldWidget> createState() =>
      _SelectPaymentListMainPageScaffoldWidgetState();
}

class _SelectPaymentListMainPageScaffoldWidgetState extends State<SelectPaymentListMainPageScaffoldWidget> {
  final SelectPaymentListBloc _selectPaymentListBloc = getIt<SelectPaymentListBloc>();
  late List<DepositsListEntity> selectPaymentList = [];
  MainController mainController = Get.find();

  int selectedIndex = -1;
  bool isFromWallet = false;
  int walletAmount = 0;

  final InstallmentPaymentPlanBloc _installmentPaymentPlanBloc = getIt<InstallmentPaymentPlanBloc>();
  final InstallmentSettlementPaymentPlanBloc _installmentSettlementPaymentPlanBloc =
      getIt<InstallmentSettlementPaymentPlanBloc>();
  final ChargeAndPackagePaymentPlanBloc _chargeAndPackagePaymentPlanBloc =
      getIt<ChargeAndPackagePaymentPlanBloc>();

  void sendInstallmentPaymentRequest() {
    if (widget.paymentData.getInstallmentPaymentData().paymentType == PaymentType.loanSettlement) {
      _installmentSettlementPaymentPlanBloc.add(
          InstallmentSettlementPaymentPlanEvent.getInstallmentSettlementPaymentPlan(
              InstallmentPaymentPlanParams(
        paymentType: widget.paymentData.getInstallmentPaymentData().paymentType,
        fileNumber: widget.paymentData.getInstallmentPaymentData().fileNumber,
        // installmentType: widget.paymentData.paymentType == PaymentListType.othersLoanPayment ? 'others' : 'myself',
        // nationalCode: widget.nationalCode ?? mainController.authInfoData!.nationalCode!,
        amount: widget.paymentData.getInstallmentPaymentData().amount,
        depositNumber: selectPaymentList[selectedIndex].depositNumber,
      )));
    } else {
      _installmentPaymentPlanBloc
          .add(InstallmentPaymentPlanEvent.getInstallmentPaymentPlan(InstallmentPaymentPlanParams(
        paymentType: widget.paymentData.getInstallmentPaymentData().paymentType,
        fileNumber: widget.paymentData.getInstallmentPaymentData().fileNumber,
        // installmentType: widget.paymentData.paymentType == PaymentListType.othersLoanPayment ? 'others' : 'myself',
        // nationalCode: widget.nationalCode ?? mainController.authInfoData!.nationalCode!,
        amount: widget.paymentData.getInstallmentPaymentData().amount,
        depositNumber: selectPaymentList[selectedIndex].depositNumber,
      )));
    }
  }

  void sendChargeAndPackagePaymentRequest() {
    _chargeAndPackagePaymentPlanBloc.add(
        ChargeAndPackagePaymentPlanEvent.getChargeAndPackagePaymentPlan(ChargeAndPackagePaymentPlanParams(
      maximumAmount: widget.paymentData.getChargeAndPackagePaymentData().maximumAmount,
      minimumAmount: widget.paymentData.getChargeAndPackagePaymentData().minimumAmount,
      taxPercent: widget.paymentData.getChargeAndPackagePaymentData().taxPercent,
      chargeAndPackageType: widget.paymentData.getChargeAndPackagePaymentData().chargeAndPackageType,
      operatorType: widget.paymentData.getChargeAndPackagePaymentData().operatorType,
      wallet: isFromWallet,
      productCode: widget.paymentData.getChargeAndPackagePaymentData().productCode,
      productType: widget.paymentData.getChargeAndPackagePaymentData().productType,
      mobile: widget.paymentData.getChargeAndPackagePaymentData().mobile,
      serviceType: widget.paymentData.getChargeAndPackagePaymentData().serviceType,
      depositNumber: isFromWallet ? '' : selectPaymentList[selectedIndex].depositNumber,
      amount: widget.paymentData.getChargeAndPackagePaymentData().amount,
    )));
  }

  @override
  void initState() {
    if (mainController.isCustomerHasFullAccess()) {
      getListData();
    }
    super.initState();
  }

  void getListData() {
    _selectPaymentListBloc.add(SelectPaymentListEvent.getSelectPaymentList(DepositsListParams(
      customerNumber: mainController.authInfoData!.customerNumber ?? '',
    )));
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        if (widget.paymentData.title != '')
          Text(
            widget.paymentData.title,
            textAlign: TextAlign.center,
            style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                  color: MainTheme.of(context).surfaceContainer,
                ),
          ),
        if (widget.paymentData.paymentType == PaymentListType.myselfLoan)
          Text(
            locale.amount_format(AppUtil.formatMoney(widget.paymentData.getInstallmentPaymentData().amount)),
            textAlign: TextAlign.center,
            style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                  color: MainTheme.of(context).surfaceContainer,
                ),
          ),
        if (widget.paymentData.paymentType == PaymentListType.charge ||
            widget.paymentData.paymentType == PaymentListType.package)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.paymentData.paymentType == PaymentListType.package
                      ? locale.package_amount_plus_tax
                      : locale.charge_amount_plus_tax,
                  textAlign: TextAlign.center,
                  style: MainTheme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  locale.amount_format(AppUtil.formatMoney(getCurrentAmount())),
                  textAlign: TextAlign.center,
                  style: MainTheme.of(context).textTheme.titleLarge.copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
        if (widget.paymentData.paymentType == PaymentListType.myselfLoan || (widget.paymentData.title != ''))
          const SizedBox(height: 30),
        if (widget.paymentData.paymentType == PaymentListType.charge ||
            widget.paymentData.paymentType == PaymentListType.package)
          WalletPaymentWidget(
            isFromWallet: isFromWallet,
            amount: widget.paymentData.getChargeAndPackagePaymentData().amount,
            onTap: (int amount) {
              setState(() {
                isFromWallet = true;
                selectedIndex = -1;
                walletAmount = amount;
              });
            },
          ),
        if (widget.paymentData.paymentType == PaymentListType.charge ||
            widget.paymentData.paymentType == PaymentListType.package)
          const SizedBox(height: 16),
        if (mainController.isCustomerHasFullAccess())
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: MainTheme.of(context).onSurfaceVariant),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              locale.accounts,
              textAlign: TextAlign.right,
              style: MainTheme.of(context).textTheme.titleMedium,
            ),
          ),
        const SizedBox(height: 16),
        if (mainController.isCustomerHasFullAccess())
          BlocProvider(
            create: (BuildContext context) => _selectPaymentListBloc,
            child: BlocConsumer<SelectPaymentListBloc, SelectPaymentListState>(
              listener: (context, state) {
                state.maybeMap(
                    loading: (_) {},
                    orElse: () {},
                    loadFailure: (e) {},
                    loadSuccess: (state) {
                      selectPaymentList = state.selectPaymentListResponse;
                    });
              },
              builder: (context, state) {
                return state.maybeMap(
                  loadSuccess: (_) {
                    if (selectPaymentList.isNotEmpty) {
                      return SelectPaymentListWidget(
                        amount: getCurrentAmount(),
                        selectedIndex: selectedIndex,
                        onTap: (int index) {
                          setState(() {
                            selectedIndex = index;
                            isFromWallet = false;
                          });
                        },
                        paymentList: selectPaymentList,
                      );
                    } else {
                      return noListItem(context);
                    }
                  },
                  loadFailure: (state) {
                    return Container(
                      height: 300,
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: CustomError(
                          message: locale.problem_in_server,
                          retryFunction: () {
                            getListData();
                          },
                          backFunction: () {
                            Get.back();
                          },
                        ),
                      ),
                    );
                  },
                  orElse: () {
                    return noListItem(context);
                  },
                  loading: (_) {
                    return const SizedBox(height: 300, child: Center(child: CustomLoading()));
                  },
                );
              },
            ),
          ),
        if (mainController.isCustomerHasFullAccess())
          const SizedBox(
            height: 20,
          ),
        MainButton(
          widget: (widget.paymentData.paymentType == PaymentListType.othersLoan ||
                  widget.paymentData.paymentType == PaymentListType.myselfLoan)
              ? (widget.paymentData.getInstallmentPaymentData().paymentType == PaymentType.loanSettlement)
                  ? BlocProvider(
                      create: (BuildContext context) => _installmentSettlementPaymentPlanBloc,
                      child: BlocConsumer<InstallmentSettlementPaymentPlanBloc,
                          InstallmentSettlementPaymentPlanState>(
                        listener: (context, state) {
                          state.maybeMap(
                              loading: (_) {},
                              orElse: () {},
                              loadFailure: (e) {
                                Get.back();
                                Get.back();
                                Get.back();
                                Get.back();
                                Get.to(() => LoanPaymentReceiptMainPage(
                                  receiptData: ReceiptData(
                                    receiptType: ReceiptType.unknown,
                                    destinationType: DestinationType.deposit,
                                    paymentData: widget.paymentData,
                                    depositNumber: '',
                                    trackingNumber: '',
                                    amount: 0,
                                  ),
                                ));
                              },
                              loadSuccess: (state) {
                                Get.back();
                                Get.back();
                                Get.back();
                                Get.back();
                                if (state.installmentPaymentPlanResponse.first.transactionSuccess){
                                  Get.to(() => LoanPaymentReceiptMainPage(
                                    receiptData: ReceiptData(
                                      isSettlement: state.installmentPaymentPlanResponse.first.isSettlement,
                                      receiptType: ReceiptType.success,
                                      destinationType: DestinationType.deposit,
                                      paymentData: widget.paymentData,
                                      depositNumber:
                                      state.installmentPaymentPlanResponse.first.depositNumber,
                                      trackingNumber:
                                      state.installmentPaymentPlanResponse.first.referenceNumber.toString(),
                                      amount: state.installmentPaymentPlanResponse.first.amount,
                                    ),
                                  ));
                                }else{
                                  Get.to(() => LoanPaymentReceiptMainPage(
                                    receiptData: ReceiptData(
                                      isSettlement: state.installmentPaymentPlanResponse.first.isSettlement,
                                      receiptType: ReceiptType.fail,
                                      destinationType: DestinationType.deposit,
                                      paymentData: widget.paymentData,
                                      depositNumber: selectPaymentList[selectedIndex].depositNumber,
                                      trackingNumber: state.installmentPaymentPlanResponse.first.referenceNumber.toString(),
                                      amount: widget.paymentData.getInstallmentPaymentData().amount,
                                    ),
                                  ));
                                }
                              });
                        },
                        builder: (context, state) {
                          return state.maybeMap(
                            loadSuccess: (_) {
                              return buttonWidget();
                            },
                            loadFailure: (_) {
                              return buttonWidget();
                            },
                            orElse: () {
                              return buttonWidget();
                            },
                            loading: (_) {
                              return SpinKitFadingCircle(
                                itemBuilder: (_, int index) {
                                  return const DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                                size: 24.0,
                              );
                            },
                          );
                        },
                      ),
                    )
                  : BlocProvider(
                      create: (BuildContext context) => _installmentPaymentPlanBloc,
                      child: BlocConsumer<InstallmentPaymentPlanBloc, InstallmentPaymentPlanState>(
                        listener: (context, state) {
                          state.maybeMap(
                              loading: (_) {},
                              orElse: () {},
                              loadFailure: (e) {
                                Get.back();
                                Get.back();
                                Get.back();
                                Get.back();
                                Get.to(() => LoanPaymentReceiptMainPage(
                                  receiptData: ReceiptData(
                                    receiptType: ReceiptType.unknown,
                                    destinationType: DestinationType.deposit,
                                    paymentData: widget.paymentData,
                                    depositNumber: '',
                                    trackingNumber: '',
                                    amount: 0,
                                  ),
                                ));
                              },
                              loadSuccess: (state) {
                                Get.back();
                                Get.back();
                                Get.back();
                                Get.back();
                                if (state.installmentPaymentPlanResponse.first.transactionSuccess){
                                  Get.to(() => LoanPaymentReceiptMainPage(
                                    receiptData: ReceiptData(
                                      isSettlement: state.installmentPaymentPlanResponse.first.isSettlement,
                                      receiptType: ReceiptType.success,
                                      destinationType: DestinationType.deposit,
                                      paymentData: widget.paymentData,
                                      depositNumber:
                                      state.installmentPaymentPlanResponse.first.depositNumber,
                                      trackingNumber:
                                      state.installmentPaymentPlanResponse.first.referenceNumber.toString(),
                                      amount: state.installmentPaymentPlanResponse.first.amount,
                                    ),
                                  ));
                                }else{
                                  Get.to(() => LoanPaymentReceiptMainPage(
                                    receiptData: ReceiptData(
                                      isSettlement: state.installmentPaymentPlanResponse.first.isSettlement,
                                      receiptType: ReceiptType.fail,
                                      destinationType: DestinationType.deposit,
                                      paymentData: widget.paymentData,
                                      depositNumber: selectPaymentList[selectedIndex].depositNumber,
                                      trackingNumber: state.installmentPaymentPlanResponse.first.referenceNumber.toString(),
                                      amount: widget.paymentData.getInstallmentPaymentData().amount,
                                    ),
                                  ));
                                }
                              }
                              );
                        },
                        builder: (context, state) {
                          return state.maybeMap(
                            loadSuccess: (_) {
                              return buttonWidget();
                            },
                            loadFailure: (_) {
                              return buttonWidget();
                            },
                            orElse: () {
                              return buttonWidget();
                            },
                            loading: (_) {
                              return SpinKitFadingCircle(
                                itemBuilder: (_, int index) {
                                  return const DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                                size: 24.0,
                              );
                            },
                          );
                        },
                      ),
                    )
              : BlocProvider(
                  create: (BuildContext context) => _chargeAndPackagePaymentPlanBloc,
                  child: BlocConsumer<ChargeAndPackagePaymentPlanBloc, ChargeAndPackagePaymentPlanState>(
                    listener: (context, state) {
                      state.maybeMap(
                          loading: (_) {},
                          orElse: () {},
                          loadFailure: (e) {
                            Get.back();
                            Get.back();
                            Get.back();
                            Get.back();
                            Get.to(() => LoanPaymentReceiptMainPage(
                                  receiptData: ReceiptData(
                                    receiptType: ReceiptType.unknown,
                                    destinationType:
                                        isFromWallet ? DestinationType.wallet : DestinationType.deposit,
                                    paymentData: widget.paymentData,
                                    depositNumber: '',
                                    trackingNumber: '',
                                    amount: 0,
                                  ),
                                ));
                          },
                          loadSuccess: (state) {
                            Get.back();
                            Get.back();
                            Get.back();
                            Get.back();
                            if (state.chargeAndPackagePaymentPlanResponse.first.chargeSuccess) {
                              Get.to(() => LoanPaymentReceiptMainPage(
                                    receiptData: ReceiptData(
                                      receiptType: ReceiptType.success,
                                      destinationType:
                                          isFromWallet ? DestinationType.wallet : DestinationType.deposit,
                                      paymentData: widget.paymentData,
                                      depositNumber:
                                          isFromWallet ? '' : selectPaymentList[selectedIndex].depositNumber,
                                      trackingNumber: state
                                          .chargeAndPackagePaymentPlanResponse.first.referenceNumber
                                          .toString(),
                                      amount: getCurrentAmount(),
                                    ),
                                  ));
                            } else {
                              Get.to(() => LoanPaymentReceiptMainPage(
                                    receiptData: ReceiptData(
                                      receiptType: ReceiptType.fail,
                                      destinationType:
                                          isFromWallet ? DestinationType.wallet : DestinationType.deposit,
                                      paymentData: widget.paymentData,
                                      depositNumber:
                                          isFromWallet ? '' : selectPaymentList[selectedIndex].depositNumber,
                                      trackingNumber: state
                                          .chargeAndPackagePaymentPlanResponse.first.referenceNumber
                                          .toString(),
                                      amount: getCurrentAmount(),
                                    ),
                                  ));
                            }
                          });
                    },
                    builder: (context, state) {
                      return state.maybeMap(
                        loadSuccess: (_) {
                          return buttonWidget();
                        },
                        loadFailure: (_) {
                          return buttonWidget();
                        },
                        orElse: () {
                          return buttonWidget();
                        },
                        loading: (_) {
                          return SpinKitFadingCircle(
                            itemBuilder: (_, int index) {
                              return const DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              );
                            },
                            size: 24.0,
                          );
                        },
                      );
                    },
                  ),
                ),
          onTap: () {
            if (getCurrentWithdrawAmount() >= getCurrentAmount()) {
              if (widget.paymentData.paymentType == PaymentListType.myselfLoan ||
                  widget.paymentData.paymentType == PaymentListType.othersLoan) {
                sendInstallmentPaymentRequest();
              } else {
                sendChargeAndPackagePaymentRequest();
              }
            } else {
              DialogHandler.showDialogMessage(
                buildContext: context,
                message: locale.charge_account,
                description: locale.top_up_balance_message( '${AppUtil.formatMoney(getCurrentAmount() - getCurrentWithdrawAmount())}'),
                positiveMessage: locale.yes,
                negativeMessage: locale.no,
                iconPath: SvgIcons.dialogAlert,
                positiveFunction: () {
                  Get.back();
                  Get.back();
                  showMainBottomSheet(
                    context: context,
                    bottomSheetWidget: ChargeDepositDetailBottomSheet(
                      chargeDepositData: ChargeDepositData(
                        amount: getCurrentAmount() - getCurrentWithdrawAmount(),
                        depositNumber: selectPaymentList[selectedIndex].depositNumber,
                        shouldPayAmount: getCurrentAmount(),
                        paymentData: widget.paymentData,
                      ),
                    ),
                  );
                },
                negativeFunction: () {
                  Get.back();
                },
              );
            }
          },
          disable: !(selectedIndex != -1 || isFromWallet),
        ),
      ],
    );
  }

  int getCurrentWithdrawAmount() {
    if (isFromWallet) {
      return walletAmount;
    } else {
      return int.parse(selectPaymentList[selectedIndex].currentWithdrawAmount);
    }
  }

  int getCurrentAmount() {
    return (widget.paymentData.paymentType == PaymentListType.myselfLoan ||
            widget.paymentData.paymentType == PaymentListType.othersLoan)
        ? widget.paymentData.getInstallmentPaymentData().amount
        : (widget.paymentData.getChargeAndPackagePaymentData().amount *
                (widget.paymentData.getChargeAndPackagePaymentData().productType ==
                        ChargeAndPackageTagType.OPTIONARY
                    ? (1 + widget.paymentData.getChargeAndPackagePaymentData().taxPercent)
                    : 1))
            .toInt();
  }

  Widget buttonWidget() {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    String buttonText = locale.confirm_and_pay;
    if (selectedIndex != -1) {
      if (getCurrentWithdrawAmount() >= getCurrentAmount()) {
        buttonText = locale.confirm_and_pay;
      } else {
        buttonText = locale.charge_account;
      }
    }

    return Text(
      buttonText,
      textAlign: TextAlign.center,
      style: MainTheme.of(context).textTheme.titleMedium.copyWith(
            color: MainTheme.of(context).staticWhite,
          ),
    );
  }
}

Widget noListItem(BuildContext context) {
  //locale
  final locale = AppLocalizations.of(Get.context!)!;
  return SizedBox(
    height: 300,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SvgIcon(
            SvgIcons.loanListNoItem,
            size: 120.0,
          ),
          const SizedBox(height: 30),
          Text(locale.you_dont_have_active_account,
              textAlign: TextAlign.center, style: MainTheme.of(context).textTheme.titleMedium),
        ],
      ),
    ),
  );
}
