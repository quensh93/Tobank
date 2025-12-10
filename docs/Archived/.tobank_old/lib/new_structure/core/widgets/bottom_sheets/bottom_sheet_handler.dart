import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showMainBottomSheet({required BuildContext context,required Widget bottomSheetWidget}){
  showModalBottomSheet(
    elevation: 0,
    context: context,
    isScrollControlled: true,
    backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
    constraints: BoxConstraints(maxHeight: Get.height * 8 / 10),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    builder: (context) => Padding(
      padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: bottomSheetWidget,
    ),
  );
}