import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../core/entities/installment_details_params.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../../../../core/widgets/buttons/main_button.dart';
import '../../../../../core/widgets/buttons/main_text_field.dart';
import '../../../../../core/widgets/dialogs/dialog_handler.dart';
import '../../bloc/installment_details_bloc/installment_details_bloc.dart';
import '../../pages/loan_payment_others_detail_main_page.dart';

class LoanPaymentOthersMainPageScaffoldWidget extends StatefulWidget {
  const LoanPaymentOthersMainPageScaffoldWidget({super.key});

  @override
  State<LoanPaymentOthersMainPageScaffoldWidget> createState() =>
      _LoanPaymentOthersMainPageScaffoldWidgetState();
}

class _LoanPaymentOthersMainPageScaffoldWidgetState extends State<LoanPaymentOthersMainPageScaffoldWidget> {
  final TextEditingController installmentNumberController1 = TextEditingController();
  final TextEditingController installmentNumberController2 = TextEditingController();
  final TextEditingController installmentNumberController3 = TextEditingController();
  final TextEditingController installmentNumberController4 = TextEditingController();
  final TextEditingController nationalCodeController = TextEditingController();
  final InstallmentDetailsBloc _installmentDetailsBloc = getIt<InstallmentDetailsBloc>();

  void getLoanData() {
    _installmentDetailsBloc.add(InstallmentDetailsEvent.getInstallmentDetails(InstallmentDetailsParams(
      fileNumber: getInstallmentNumber(),
      installmentType: 'others',
      nationalCode: nationalCodeController.text,
    )));
  }

  bool isDisable() {
    if (installmentNumberController1.text != '' &&
        installmentNumberController2.text != '' &&
        installmentNumberController3.text != '' &&
        installmentNumberController4.text != '' &&
        nationalCodeController.text != '') {
      return false;
    } else {
      return true;
    }
  }

  String getInstallmentNumber() {
    return '${installmentNumberController1.text}-${installmentNumberController2.text}-${installmentNumberController3.text}-${installmentNumberController4.text}';
  }

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: MainTheme.of(context).onSurfaceVariant),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.facility_number,
                textAlign: TextAlign.right,
                style: MainTheme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: MainTextField(
                      onChanged: () {
                        setState(() {});
                      },
                      hasSeparator: false,
                      hintText: '',
                      textController: installmentNumberController4,
                    ),
                  ),
                  Container(
                    width: 9,
                    padding: const EdgeInsets.all(3),
                    child: Divider(
                      color: MainTheme.of(context).onSurfaceVariant,
                      thickness: 1,
                      height: 1,
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: MainTextField(
                      onChanged: () {
                        setState(() {});
                      },
                      hasSeparator: false,
                      hintText: '',
                      textController: installmentNumberController3,
                    ),
                  ),
                  Container(
                    width: 9,
                    padding: const EdgeInsets.all(3),
                    child: Divider(
                      color: MainTheme.of(context).onSurfaceVariant,
                      thickness: 1,
                      height: 1,
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: MainTextField(
                      onChanged: () {
                        setState(() {});
                      },
                      hasSeparator: false,
                      hintText: '',
                      textController: installmentNumberController2,
                    ),
                  ),
                  Container(
                    width: 9,
                    padding: const EdgeInsets.all(3),
                    child: Divider(
                      color: MainTheme.of(context).onSurfaceVariant,
                      thickness: 1,
                      height: 1,
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: MainTextField(
                      onChanged: () {
                        setState(() {});
                      },
                      hasSeparator: false,
                      hintText: '',
                      textController: installmentNumberController1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                locale.facility_owner_national_code,
                textAlign: TextAlign.right,
                style: MainTheme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              MainTextField(
                onChanged: () {
                  setState(() {});
                },
                hasSeparator: false,
                hintText: '',
                textController: nationalCodeController,
              ),
              const SizedBox(height: 32),
              MainButton(
                onTap: () {
                  getLoanData();
                },
                disable: isDisable(),
                widget: BlocProvider(
                  create: (BuildContext context) => _installmentDetailsBloc,
                  child: BlocConsumer<InstallmentDetailsBloc, InstallmentDetailsState>(
                    listener: (context, state) {
                      state.maybeMap(
                          loading: (_) {},
                          orElse: () {},
                          loadFailure: (e) {
                            DialogHandler.showDialogMessage(
                              buildContext: context,
                              message: locale.requested_information_not_found,
                              positiveMessage: locale.confirmation,
                              positiveFunction: () async {
                                Get.back();
                                // Get.back();
                              },
                            );
                          },
                          loadSuccess: (state) {

                            if (state.installmentDetailsResponse.isEmpty) {
                              DialogHandler.showDialogMessage(
                                buildContext: context,
                                message: locale.requested_information_not_found,
                                positiveMessage: locale.confirmation,
                                positiveFunction: () async {
                                  Get.back();
                                  // Get.back();
                                },
                              );
                            } else {

                              if(state.installmentDetailsResponse.first.fileStatus =='LOAN_SETTLED'){
                                DialogHandler.showDialogMessage(
                                  buildContext: context,
                                  message: locale.loan_setteled_message,
                                  positiveMessage: locale.confirmation,
                                  positiveFunction: () async {
                                    Get.back();
                                    // Get.back();
                                  },
                                );
                              }else{   Get.to(() => LoanPaymentOthersDetailMainPage(
                                detailsData: state.installmentDetailsResponse.first,
                                nationalCode: nationalCodeController.text,
                              ));}

                            }
                          });
                    },
                    builder: (context, state) {
                      return state.maybeMap(
                        loadSuccess: (_) {
                          return Text(
                            locale.continue_label,
                            textAlign: TextAlign.center,
                            style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                              color: MainTheme.of(context).white,
                            ),
                          );
                        },
                        loadFailure: (_) {
                          return Text(
                            locale.continue_label,
                            textAlign: TextAlign.center,
                            style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                              color: MainTheme.of(context).staticWhite,
                            ),
                          );
                        },
                        orElse: () {
                          return Text(
                            locale.continue_label,
                            textAlign: TextAlign.center,
                            style: MainTheme.of(context).textTheme.titleMedium.copyWith(
                              color: MainTheme.of(context).white,
                            ),
                          );
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
