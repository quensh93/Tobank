import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:universal_html/html.dart' as html;

import '../../../../../controller/main/main_controller.dart';
import '../../../../../model/transaction/response/transaction_data_response.dart';
import '../../../../../service/core/api_exception.dart';
import '../../../../../service/core/api_result_model.dart';
import '../../../../../service/transaction_services.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/digit_to_word.dart';
import '../../../../../util/snack_bar_util.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../util/web_only_utils/token_util.dart';
import '../../../../core/entities/charge_deposit_data.dart';
import '../../../../core/entities/enums.dart';
import '../../../../core/entities/increase_balance_params.dart';
import '../../../../core/entities/receipt_data.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/theme/main_theme.dart';
import '../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../../../core/widgets/buttons/main_button.dart';
import '../../../loan_payment/presentation/pages/loan_payment_receipt_main_page.dart';
import '../bloc/get_increase_balance_bloc/get_increase_balance_bloc.dart';
import '../pages/select_payment_list_main_page.dart';

class ChargeDepositDetailBottomSheet extends StatefulWidget {
  final ChargeDepositData chargeDepositData;

  const ChargeDepositDetailBottomSheet({
    required this.chargeDepositData,
    super.key,
  });

  @override
  State<ChargeDepositDetailBottomSheet> createState() =>
      _ChargeDepositDetailBottomSheetState();
}

class _ChargeDepositDetailBottomSheetState
    extends State<ChargeDepositDetailBottomSheet> {
  final GetIncreaseBalanceBloc _installmentPaymentPlanBloc =
      getIt<GetIncreaseBalanceBloc>();

  int transactionId = 0;

  bool checkPayment = false;
  bool isLoading = false;

  Future<void> sendPaymentRequest() async {
    final String token = await _generateToken();
    _installmentPaymentPlanBloc.add(
        GetIncreaseBalanceEvent.getGetIncreaseBalance(IncreaseBalanceParams(
      service: widget.chargeDepositData.paymentData.paymentType
          .getServiceByPaymentListType(context),
      amount: widget.chargeDepositData.amount,
      depositNumber: widget.chargeDepositData.depositNumber,
      token: token,
    )));
  }

  final MainController mainController = Get.find();
  final appLinks = AppLinks();
  StreamSubscription? _sub;

  Future<void> showWebView(String baseUrl, int transactionId) async {
    StreamSubscription? _sub;

    try {
      //2) generate token
      final String token = await _generateToken();

      // 3) Append token to URL
      final String separator = baseUrl.contains('?') ? '&' : '?';
      final String fullUrl = '$baseUrl${separator}token=$token';

      // 4) If Web: redirect in SAME tab
      if (kIsWeb) {
        html.window.location.href = fullUrl;
        return;
      }

      // 5) Otherwise (Mobile): listen for deep-link callback
      _sub = appLinks.uriLinkStream.listen(
        (Uri? link) {
          if (link != null) {
            // when the gateway redirects back, check status
            checkPaymentStatus(transactionId);
            _sub?.cancel();
          }
        },
        onError: (Object err) {
          AppUtil.printResponse('DeepLink error: $err');
        },
      );

      // 6) update UI & launch browser
      final mainController = Get.find<MainController>();
      mainController.getToPayment = true;
      mainController.update();

      AppUtil.launchInBrowser(url: fullUrl);
    } catch (e, st) {
      AppUtil.printResponse('Error in showWebView: $e$st');
      SnackBarUtil.showSnackBar(
        title: 'Error',
        message: 'Unable to open payment page. Please try again.',
      );
    }
  }

  Future<String> _generateToken() async {
    await TokenUtil.clearStoredToken();

    final Map<String, dynamic> tokenData =
        await TokenUtil.generateShortLivedToken();
    final String? token = tokenData['token'] as String?;
    if (token == null || token.isEmpty) {
      throw Exception('Failed to generate payment token');
    }

    return token;
  }

  void checkPaymentStatus(int transactionId) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    setState(() {
      isLoading = true;
    });
    TransactionServices.getTransactionByIdRequest(
      id: transactionId,
    ).then(
      (result) {
        setState(() {
          isLoading = false;
        });
        switch (result) {
          case Success(value: (final TransactionDataResponse response, int _)):
            if (response.data == null) {
              Get.back();
              SnackBarUtil.showSnackBar(
                title: locale.error_has_occurred,
                message: locale.error_in_server,
              );
            } else {
              if (response.data!.trStatus == 'success') {
                Get.back();
                showMainBottomSheet(
                  context: context,
                  bottomSheetWidget: SelectPaymentListMainPage(
                    paymentData: widget.chargeDepositData.paymentData,
                  ),
                );
              } else if (response.data!.trStatus == 'error') {
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                Get.to(() => LoanPaymentReceiptMainPage(
                      receiptData: ReceiptData(
                        receiptType: ReceiptType.fail,
                        destinationType: DestinationType.deposit,
                        paymentData: widget.chargeDepositData.paymentData,
                        trackingNumber: response.data!.hashId ?? '',
                        depositNumber: widget.chargeDepositData.depositNumber,
                        amount: (response.data!.trAmount ?? 0),
                      ),
                      // installmentResponseData: InstallmentPaymentPlanEntity(
                      //     depositNumber: widget.installmentParams!.depositNumber,
                      //     amount: response.data!.trAmount ?? 0,
                      //     fileNumber: widget.installmentParams!.fileNumber,
                      //     trackingNumber: response.data!.hashId ?? '',
                      //     chargeAndPackageType: widget.chargeType),
                    ));
              } else {
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                Get.to(() => LoanPaymentReceiptMainPage(
                      receiptData: ReceiptData(
                        receiptType: ReceiptType.unknown,
                        destinationType: DestinationType.deposit,
                        paymentData: widget.chargeDepositData.paymentData,
                        trackingNumber: response.data!.hashId ?? '',
                        depositNumber: widget.chargeDepositData.depositNumber,
                        amount: (response.data!.trAmount ?? 0),
                      ),
                    ));
              }
            }

          case Failure(exception: final ApiException apiException):
            Get.back();
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: MainTheme.of(context).onSurfaceVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              locale.charge_account,
              style: ThemeUtil.titleStyle,
            ),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: MainTheme.of(context).onSurface,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: MainTheme.of(context).onSurfaceVariant),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          intl.NumberFormat('#,###')
                              .format(widget.chargeDepositData.amount)
                              .toString()
                              .replaceAll(',', '.'),
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: Text(
                        locale.rial,
                        textAlign: TextAlign.center,
                        style: MainTheme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  DigitToWord.toWord(
                          widget.chargeDepositData.amount
                              .toInt()
                              .toString()
                              .substring(
                                  0,
                                  widget.chargeDepositData.amount
                                          .toInt()
                                          .toString()
                                          .length -
                                      1),
                          StrType.numWord,
                          isMoney: true)
                      .replaceAll('  ', ' '),
                  style: MainTheme.of(context)
                      .textTheme
                      .bodyMedium
                      .copyWith(color: MainTheme.of(context).surfaceContainer),
                ),
              ],
            ),
            const SizedBox(height: 32),
            MainButton(
              widget: BlocProvider(
                create: (BuildContext context) => _installmentPaymentPlanBloc,
                child: BlocConsumer<GetIncreaseBalanceBloc,
                    GetIncreaseBalanceState>(
                  listener: (context, state) {
                    //locale
                    final locale = AppLocalizations.of(context)!;
                    state.maybeMap(
                        loading: (_) {},
                        orElse: () {},
                        loadFailure: (e) {
                          Get.back();
                          SnackBarUtil.showSnackBar(
                            title: locale.error_has_occurred,
                            message: locale.error_in_server,
                          );
                        },
                        loadSuccess: (state) {
                          transactionId = state
                              .getIncreaseBalanceResponse.first.transactionId;
                          checkPayment = true;
                          showWebView(
                            state.getIncreaseBalanceResponse.first.url,
                            state
                                .getIncreaseBalanceResponse.first.transactionId,
                          );
                        });
                  },
                  builder: (context, state) {
                    return state.maybeMap(
                      loadSuccess: (_) {
                        if (isLoading) {
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
                        } else {
                          return Text(
                            locale.check_payment,
                            textAlign: TextAlign.center,
                            style: MainTheme.of(context)
                                .textTheme
                                .titleMedium
                                .copyWith(
                                  color: MainTheme.of(context).staticWhite,
                                ),
                          );
                        }
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
                if (checkPayment) {
                  checkPaymentStatus(transactionId);
                } else {
                  sendPaymentRequest();
                }
              },
              disable: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonWidget() {
    final locale = AppLocalizations.of(Get.context!)!;
    return Text(
      locale.charge_account,
      textAlign: TextAlign.center,
      style: MainTheme.of(context).textTheme.titleMedium.copyWith(
            color: MainTheme.of(context).staticWhite,
          ),
    );
  }
}
