import 'package:flutter/material.dart';

import '../../../../../ui/common/custom_app_bar.dart';
import '../../../../core/entities/enums.dart';
import 'sim_list_page.dart';

class SimListMainPage extends StatelessWidget {
  final ChargeAndPackageType chargeAndPackageType;
  const SimListMainPage({
    required this.chargeAndPackageType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          titleString: chargeAndPackageType.getString(context),
          context: context,
        ),
        body: SafeArea(
            child: SimListPage(
          type: chargeAndPackageType,
        )),
      ),
    );
  }
}
