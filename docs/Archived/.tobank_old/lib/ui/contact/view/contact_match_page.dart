import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/contact/contact_match_controller.dart';
import '../../../model/contact_match/custom_match_contact.dart';
import '../contact_match_item_widget.dart';

class ContactMatchPage extends StatelessWidget {
  const ContactMatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactMatchController>(
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                itemCount: controller.contactsWithPhone.length,
                itemBuilder: (BuildContext context, int index) {
                  final CustomMatchContact contact = controller.contactsWithPhone[index];
                  return ContactMatchItemWidget(
                    contact: contact,
                    returnDataFunction: (customMatchContact) {
                      controller.selectContact(customMatchContact);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
