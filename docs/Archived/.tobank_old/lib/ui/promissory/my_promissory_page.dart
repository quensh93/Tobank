import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/promissory/promissory_controller.dart';
import '../../../util/data_constants.dart';
import 'promissory_item.dart';

class MyPromissoryPage extends StatelessWidget {
  const MyPromissoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromissoryController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: DataConstants.getMyPromissoryItemList().length,
                itemBuilder: (BuildContext context, int index) {
                  return PromissoryItemWidget(
                    promissoryItemData: DataConstants.getMyPromissoryItemList()[index],
                    returnDataFunction: (promissoryItemData) {
                      controller.handleItemClick(promissoryItemData);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16.0,
                  );
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
            ],
          ),
        ),
      );
    });
  }
}
