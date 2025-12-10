import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/update_address/update_address_controller.dart';
import '../../../model/address/response/address_inquiry_response_data.dart';
import '../../../model/common/normalized_address.dart';
import '../common/custom_app_bar.dart';
import 'view/update_address_info_page.dart';

class UpdateAddressScreen extends StatelessWidget {
  const UpdateAddressScreen(
      {required this.addressInquiryResponseData, required this.postalCode, required this.normalizedAddress, super.key});

  final String postalCode;
  final AddressInquiryResponseData addressInquiryResponseData;
  final NormalizedAddress normalizedAddress;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<UpdateAddressController>(
      init: UpdateAddressController(
        addressInquiryResponseData: addressInquiryResponseData,
        normalizedAddress: normalizedAddress,
        postalCode: postalCode,
      ),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.edit_address,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          UpdateAddressInfoPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
