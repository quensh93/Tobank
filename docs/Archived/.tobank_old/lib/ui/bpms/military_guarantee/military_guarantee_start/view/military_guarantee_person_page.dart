import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controller/bpms/military_guarantee/military_guarantee_start_controller.dart';
import '../../../../../../util/data_constants.dart';
import '../military_guarantee_person_type_item.dart';

class MilitaryGuaranteePersonPage extends StatelessWidget {
  const MilitaryGuaranteePersonPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MilitaryGuaranteeStartController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DataConstants.getMilitaryGuaranteePersonTypeList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return MilitaryGuaranteePersonTypeItem(
                      militaryGuaranteePersonTypeItemData: DataConstants.getMilitaryGuaranteePersonTypeList()[index],
                      returnDataFunction: (militaryGuaranteePersonTypeItemData) {
                        controller.handleServiceItemClick(militaryGuaranteePersonTypeItemData);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16.0,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
