import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/contact/contact_match_controller.dart';
import '../../model/contact_match/custom_match_contact.dart';
import '../common/custom_app_bar.dart';
import '../common/loading_page.dart';
import '../common/text_field_clear_icon_widget.dart';
import 'view/contact_match_page.dart';

class ContactMatchScreen extends StatelessWidget {
  const ContactMatchScreen({required this.returnDataFunction, super.key});

  final Function(CustomMatchContact contact) returnDataFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ContactMatchController>(
        init: ContactMatchController(),
        builder: (controller) {
          controller.returnDataFunction = returnDataFunction;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.tobank_contacts,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: TextField(
                              onChanged: (value) {
                                controller.searchContacts();
                              },
                              controller: controller.nameController,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                              textInputAction: TextInputAction.search,
                              onSubmitted: (term) {
                                controller.searchContacts();
                              },
                              decoration: InputDecoration(
                                filled: false,
                                hintText: locale.search_with_phone_number,
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 16.0,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                ),
                                suffixIcon: TextFieldClearIconWidget(
                                  isVisible: controller.nameController.text.isNotEmpty,
                                  clearFunction: () {
                                    controller.nameController.clear();
                                    controller.update();
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
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
                                    controller.getMatchContactsRequest();
                                  },
                                ),
                                const ContactMatchPage(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
