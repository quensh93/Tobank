import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../controller/main/main_controller.dart';
import '../../../../../../ui/common/custom_error.dart';
import '../../../../../../ui/common/custom_loading.dart';
import '../../../../../core/entities/installment_details_params.dart';
import '../../../../../core/entities/loan_details_entity.dart';
import '../../../../../core/injection/injection.dart';
import '../../bloc/installment_details_bloc/installment_details_bloc.dart';
import 'loan_payment_detail_history_section_widget.dart';
import 'loan_payment_detail_information_section_widget.dart';
import 'loan_payment_detail_pay_section_widget.dart';

class LoanPaymentDetailMainPageScaffoldWidget extends StatefulWidget {
  final String fileNumber;
  final Function getData;

  const LoanPaymentDetailMainPageScaffoldWidget({
    required this.fileNumber,
    required this.getData,
    super.key,
  });

  @override
  State<LoanPaymentDetailMainPageScaffoldWidget> createState() =>
      _LoanPaymentDetailMainPageScaffoldWidgetState();
}

class _LoanPaymentDetailMainPageScaffoldWidgetState
    extends State<LoanPaymentDetailMainPageScaffoldWidget> {
  final InstallmentDetailsBloc _installmentDetailsBloc =
      getIt<InstallmentDetailsBloc>();
  MainController mainController = Get.find();
  List<LoanDetailsEntity> detailData = [];

  @override
  void initState() {
    getListData();
    super.initState();
  }

  void getListData() {
    _installmentDetailsBloc.add(
        InstallmentDetailsEvent.getInstallmentDetails(InstallmentDetailsParams(
      fileNumber: widget.fileNumber,
      installmentType: 'myself',
      nationalCode: mainController.authInfoData!.nationalCode!,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _installmentDetailsBloc,
      child: BlocConsumer<InstallmentDetailsBloc, InstallmentDetailsState>(
        listener: (context, state) {
          state.maybeMap(
              loading: (_) {},
              orElse: () {},
              loadFailure: (e) {},
              loadSuccess: (state) {
                detailData = state.installmentDetailsResponse;
                widget.getData(detailData.first);
              });
        },
        builder: (context, state) {

//locale
          final locale = AppLocalizations.of(context)!;
          return state.maybeMap(
            loadSuccess: (_) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LoanPaymentDetailInformationSectionWidget(
                        detailData: detailData.first,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LoanPaymentDetailPaySectionWidget(
                        fileNumber: widget.fileNumber,
                        detailData: detailData.first,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                     LoanPaymentDetailHistorySectionWidget(
                      detailData: detailData.first,
                    ),
                  ],
                ),
              );
            },
            loadFailure: (_) {
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
            },
            orElse: () {
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
