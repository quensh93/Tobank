import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/authentication/authentication_extension/authentication_status_flow_methods.dart';
import '../../../../controller/authentication/authentication_extension/certificate_generation_flow_methods.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/authentication/authentication_register_controller.dart';
import '../../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import 'views/address_page.dart';
import 'views/birth_certificate_first_page.dart';
import 'views/birth_certificate_second_page.dart';
import 'views/certificate_generator_page.dart';
import 'views/final_page.dart';
import 'views/national_card_back_page.dart';
import 'views/national_card_front_page.dart';
import 'views/preregister_page.dart';
import 'views/signature_page.dart';
import 'views/take_personal_photo_video_page.dart';
import 'views/verify_otp_page.dart';

class AuthenticationRegisterScreen extends StatelessWidget {
  const AuthenticationRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AuthenticationRegisterController>(
        init: AuthenticationRegisterController(),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPressed,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: CustomAppBar(
                  titleString: locale.authentication_title,
                  context: context,
                ),
                body: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                          child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          LoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.getEkycStatusRequest();
                            },
                          ),
                          const PreRegisterPage(),
                          const VerifyOtpPage(),
                          const NationalCardFrontPage(),
                          const NationalCardBackPage(),
                          const TakePersonalPhotoVideoPage(),
                          const BirthCertificateFirstPage(),
                          const BirthCertificateSecondPage(),
                          const AddressPage(),
                          const SignaturePage(),
                          const CertificateGeneratorPage(),
                          LoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.getCertificateRequest();
                            },
                          ),
                          const FinalPage(),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
