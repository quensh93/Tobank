import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../model/profile/response/avatar_list_response_data.dart';
import '../../../util/app_util.dart';
import '../../../widget/svg/svg_icon.dart';

class AvatarItemWidget extends StatelessWidget {
  const AvatarItemWidget({
    required this.avatarData,
    required this.returnDataFunction,
    required this.reloadFunction,
    super.key,
    this.selectedId,
  });

  final AvatarData avatarData;
  final int? selectedId;
  final Function(AvatarData avatarData) returnDataFunction;
  final Function reloadFunction;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(40.0),
        onTap: () {
          returnDataFunction(avatarData);
        },
        child: FastCachedImage(
          filterQuality: FilterQuality.high,
          url: AppUtil.baseUrlStatic() + avatarData.avatar!,
          loadingBuilder: (context, progress) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          errorBuilder: (context, url, error) {
            return InkWell(
              onTap: () {
                reloadFunction();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: SvgIcon(
                    SvgIcons.imageLoadError,
                    size: 32,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
