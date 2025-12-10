import 'package:flutter/material.dart';

import '../../../../model/bpms/bpms_ownership_data.dart';
import '../../../../util/theme/theme_util.dart';

class OwnershipItemWidget extends StatelessWidget {
  const OwnershipItemWidget({
    required this.ownershipData,
    required this.returnDataFunction,
    super.key,
    this.selectedOwnershipData,
  });

  final BPMSOwnershipData ownershipData;
  final BPMSOwnershipData? selectedOwnershipData;
  final Function(BPMSOwnershipData ownershipData) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        returnDataFunction(ownershipData);
      },
      child: Container(
        height: 48.0,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          onTap: () {
            returnDataFunction(ownershipData);
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  ownershipData.title,
                  style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 14.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
