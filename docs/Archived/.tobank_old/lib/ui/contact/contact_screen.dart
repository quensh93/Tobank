import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/contact/contact_controller.dart';
import '../../model/contact_match/custom_contact.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';
import '../common/custom_app_bar.dart';
import '../common/text_field_clear_icon_widget.dart';
import 'contact_item_widget.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key, this.returnDataFunction});

  final Function(CustomContact contact)? returnDataFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ContactController>(
        init: ContactController(),
        builder: (controller) {
          controller.returnDataFunction = returnDataFunction;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString:locale.contact,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: SizedBox(
                              height: 48.0,
                              child: TextField(
                                onChanged: (value) {
                                  controller.searchContacts();
                                },
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                                textInputAction: TextInputAction.search,
                                onSubmitted: (term) {
                                  controller.searchContacts();
                                },
                                controller: controller.nameController,
                                decoration: InputDecoration(
                                  filled: false,
                                  hintText: locale.search_with_phone_number,
                                  hintStyle: ThemeUtil.hintStyle,
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
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: SvgIcon(
                                      SvgIcons.search,
                                    ),
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
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Expanded(
                            child: controller.contactsWithPhone != null
                                ? ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    itemCount: controller.contactsWithPhone?.length ?? 0,
                                    itemBuilder: (BuildContext context, int index) {
                                      final CustomContact? contact = controller.contactsWithPhone?.elementAt(index);
                                      return ContactItemWidget(
                                        contact: contact!,
                                        returnDataFunction: (customContact) {
                                          controller.selectContact(customContact);
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        thickness: 1,
                                      );
                                    },
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
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
