import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';

import '../../model/common/menu_data_model.dart';
import '../../util/app_util.dart';
import '../../widget/svg/svg_icon.dart';

class BannerView extends StatelessWidget {
  const BannerView({
    required this.bannerData,
    required this.handleBannerClick,
    super.key,
  });

  final BannerData? bannerData;
  final Function(BannerItem) handleBannerClick;

  @override
  Widget build(BuildContext context) {
    if (bannerData == null || bannerData!.bannerItemList!.isEmpty) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              constraints: BoxConstraints(minHeight: bannerData!.minHeight),
              child: ImageSlideshow(
                indicatorColor: Colors.blue,
                indicatorBackgroundColor: Colors.white,
                indicatorRadius: 4,
                isLoop: bannerData!.isLoop,
                autoPlayInterval: bannerData!.interval,
                children: bannerData!.bannerItemList!
                    .map((bannerItem) => ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            onTap: () {
                              handleBannerClick(bannerItem);
                            },
                            child: FastCachedImage(
                              url: AppUtil.baseUrlStatic() + bannerItem.imageUrl!,
                              loadingBuilder: (context, progress) => Container(
                                constraints: BoxConstraints(minHeight: bannerData!.minHeight),
                                child: Center(
                                  child: CircularProgressIndicator(
                                      value: progress.progressPercentage.value,
                                      valueColor: AlwaysStoppedAnimation<Color>(context.theme.colorScheme.secondary)),
                                ),
                              ),
                              errorBuilder: (context, url, error) {
                                return Container(
                                  constraints: BoxConstraints(minHeight: bannerData!.minHeight),
                                  child: const Center(
                                    child: SvgIcon(
                                      SvgIcons.imageLoadError,
                                      size: 48,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      );
    }
  }
}
