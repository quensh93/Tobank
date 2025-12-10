import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/bank_branch_list_data.dart';
import '../../util/app_util.dart';

class MapSearchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<BankBranchListData> allBankBranchListData = [];
  List<BankBranchListData> bankBranchListData = [];

  MapSearchController({required this.bankBranchListData, required this.allBankBranchListData});

  /// Filters the list of bank branches based on the search query.
  void search() {
    if (allBankBranchListData.isNotEmpty) {
      bankBranchListData = allBankBranchListData
          .where((item) => (item
              .toJson()
              .toString()
              .toLowerCase()
              .contains(AppUtil.getEnglishNumbers(searchController.text.toLowerCase()))))
          .toList();
      update();
    }
  }

  void returnData(BankBranchListData bankBranchListData) {
    Get.back(result: bankBranchListData);
  }
}
