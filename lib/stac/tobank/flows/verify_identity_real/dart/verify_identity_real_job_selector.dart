import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

const List<String> _jobTitles = [
  'پزشک',
  'بازرگانی',
  'بازنشسته',
  'تولیدی',
  'خدماتی',
  'ساختمانی',
  'فرهنگی',
  'کارمند دولت',
  'مراکز تفریحی، ورزشی، موزه، دینی و...',
  'وکالت',
  'خانه دار',
  'مستمری بگیر',
  'دانشجو',
  'بیکار',
  'دارای بیمه بیکاری',
  'اشخاص خارجی فاقد مجوز فعالیت معتبر',
  'سایر فعالان گردشگری(صنایع دستی، راهنمایان تور،و...',
];

@StacScreen(screenName: 'verify_identity_real_job_selector')
StacWidget verifyIdentityRealJobSelector() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: StacAppBar(
      title: buildPromissoryAppBar(
        title: '{{appStrings.menu.items.verifyIdentity}}',
      ).title,
      centerTitle: true,
      leading: buildPromissoryAppBar(
        title: '{{appStrings.menu.items.verifyIdentity}}',
      ).leading,
    ),
    body: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacSizedBox(height: 18),
        StacExpanded(
          child: StacContainer(
            decoration: StacBoxDecoration(
              color: '#FFFFFF',
              borderRadius: StacBorderRadius.only(

              ),
            ),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacSizedBox(height: 10),
                // StacCenter(
                //   child: StacContainer(
                //     width: 48,
                //     height: 5,
                //     decoration: StacBoxDecoration(
                //       color: '#D1D5DB',
                //       borderRadius: StacBorderRadius.all(999),
                //     ),
                //   ),
                // ),
                StacSizedBox(height: 18),
                StacPadding(
                  padding: StacEdgeInsets.symmetric(horizontal: 16),
                  child: StacText(
                    data: 'حوزه فعالیت خود را انتخاب کنید',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '#2F3545',
                    ),
                  ),
                ),
                StacSizedBox(height: 16),
                // StacPadding(
                //   padding: StacEdgeInsets.symmetric(horizontal: 16),
                //   child: StacContainer(
                //     height: 48,
                //     padding: StacEdgeInsets.symmetric(horizontal: 14),
                //     decoration: StacBoxDecoration(
                //       color: '#FFFFFF',
                //       borderRadius: StacBorderRadius.all(10),
                //       border: StacBorder.all(
                //         color: '#D7DCE5',
                //         width: 1,
                //       ),
                //     ),
                //     child: StacRow(
                //       textDirection: StacTextDirection.rtl,
                //       children: [
                //         StacImage(
                //           src: 'assets/icons/ic_search.svg',
                //           imageType: StacImageType.asset,
                //           width: 18,
                //           height: 18,
                //           color: '#6B7280',
                //         ),
                //         StacSizedBox(width: 10),
                //         StacExpanded(
                //           child: StacText(
                //             data: 'جست‌وجو در لیست مشاغل...',
                //             textDirection: StacTextDirection.rtl,
                //             textAlign: StacTextAlign.right,
                //             style: StacCustomTextStyle(
                //               fontSize: 14,
                //               fontWeight: StacFontWeight.w500,
                //               color: '#8A94A6',
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // StacSizedBox(height: 14),
                StacExpanded(
                  child: StacSingleChildScrollView(
                    child: StacColumn(
                      crossAxisAlignment: StacCrossAxisAlignment.stretch,
                      children: _jobTitles
                          .map((title) => _buildJobListItem(title))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildJobListItem(String title) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'verifyIdentitySelectedJobTitle', 'value': title},
            {'key': 'verifyIdentityHasSelectedJob', 'value': true},
          ],
        ),
        const StacNavigateAction(navigationStyle: NavigationStyle.pop),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: StacBoxDecoration(
        border: StacBorder(
          bottom: StacBorderSide(
            color: '#E5E7EB',
            width: 1,
          ),
        ),
      ),
      child: StacText(
        data: title,
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w600,
          color: '#2F3545',
        ),
      ),
    ),
  );
}
