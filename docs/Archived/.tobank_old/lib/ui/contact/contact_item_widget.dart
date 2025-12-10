import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/contact_match/custom_contact.dart';
import '../../util/theme/theme_util.dart';

class ContactItemWidget extends StatelessWidget {
  const ContactItemWidget({
    required this.contact,
    required this.returnDataFunction,
    super.key,
  });

  final CustomContact contact;
  final Function(CustomContact contact) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 48.0,
          width: 48.0,
          child: Card(
            elevation: 1,
            shadowColor: Colors.transparent,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
            ),
            child: Center(
              child: Text(
                contact.displayName != null ? contact.displayName![0] : '',
                style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 18.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            onTap: () {
              returnDataFunction(contact);
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  contact.displayName ?? '',
                  style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  contact.phones!.toList()[0] ?? '',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
