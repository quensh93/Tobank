import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/stac/tobank/flows/gift_card_real/dart/widgets/gift_card_real_app_bar.dart';

@StacScreen(screenName: 'gift_card_real_select_design')
StacWidget giftCardRealSelectDesign() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildGiftCardRealAppBar(title: 'کارت هدیه'),
    body: StacSingleChildScrollView(
      padding: StacEdgeInsets.only(left: 16, right: 16, top: 22, bottom: 20),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacText(
            data: 'دسته‌بندی کارت هدیه را انتخاب کنید',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 18),
          _buildCategoryRow(
            left: _buildCategoryTile(
              title: 'تبریک نوروز',
              imageUrl: _internetImageFor('gift-category-nowruz'),
              topColors: ['#1C4A95', '#5A39A5'],
              plans: _categoryPlansNowruz(),
            ),
            right: _buildCategoryTile(
              title: 'ماه‌های تولد',
              imageUrl: _internetImageFor('gift-category-birth-months'),
              topColors: ['#2BA76E', '#2E7CC7'],
              plans: _categoryPlansBirthMonths(),
            ),
          ),
          StacSizedBox(height: 8),
          _buildCategoryRow(
            left: _buildCategoryTile(
              title: 'اعیاد مذهبی، ملی، فرهنگی',
              imageUrl: _internetImageFor('gift-category-national-events'),
              topColors: ['#3866B4', '#E8A82B'],
              plans: _categoryPlansNationalEvents(),
            ),
            right: _buildCategoryTile(
              title: 'تبریک ازدواج',
              imageUrl: _internetImageFor('gift-category-wedding'),
              topColors: ['#C48A3C', '#8E4A7A'],
              plans: _categoryPlansWedding(),
            ),
          ),
          StacSizedBox(height: 8),
          _buildCategoryRow(
            left: _buildCategoryTile(
              title: 'کارت هدیه موشی ۲',
              imageUrl: _internetImageFor('gift-category-mouse'),
              topColors: ['#DB4CB5', '#48BDD7'],
              plans: _categoryPlansMouse(),
            ),
            right: _buildCategoryTile(
              title: 'فصل‌های تولد',
              imageUrl: _internetImageFor('gift-category-seasons'),
              topColors: ['#2E8D53', '#D08D2E'],
              plans: _categoryPlansSeasons(),
            ),
          ),
          StacSizedBox(height: 8),
          _buildCategoryRow(
            left: _buildCategoryTile(
              title: 'روزهای خاص',
              imageUrl: _internetImageFor('gift-category-special-days'),
              topColors: ['#7E8A94', '#3A4C5C'],
              plans: _categoryPlansSpecialDays(),
            ),
            right: _buildCategoryTile(
              title: 'مکان‌های تاریخی',
              imageUrl: _internetImageFor('gift-category-historical-places'),
              topColors: ['#8E4D66', '#A98941'],
              plans: _categoryPlansHistoricalPlaces(),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildCategoryRow({
  required StacWidget left,
  required StacWidget right,
}) {
  return StacRow(
    children: [
      StacExpanded(child: left),
      StacSizedBox(width: 8),
      StacExpanded(child: right),
    ],
  );
}

StacWidget _buildCategoryTile({
  required String title,
  required String imageUrl,
  required List<String> topColors,
  required List<Map<String, dynamic>> plans,
}) {
  final plansWithImages = _withInternetPlanImages(plans);
  return StacGestureDetector(
    onTap: StacShowGiftCardPlanSelectorBottomSheetAction(
      categoryTitle: title,
      plans: plansWithImages,
      onPlanSelectedAction: StacNavigateAction(
        routeName: 'gift_card_real_message',
        navigationStyle: NavigationStyle.push,
      ),
    ),
    child: StacContainer(
      height: 190,
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surface}}',
        borderRadius: StacBorderRadius.all(12),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacContainer(
            height: 102,
            clipBehavior: StacClip.hardEdge,
            decoration: StacBoxDecoration(
              borderRadius: StacBorderRadius.only(
                topLeft: 12,
                topRight: 12,
                bottomLeft: 0,
                bottomRight: 0,
              ),
              gradient: StacLinearGradient(
                begin: StacAlignment.centerLeft,
                end: StacAlignment.centerRight,
                colors: topColors,
              ),
            ),
            child: StacStack(
              children: [
                StacPositioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: StacImage(
                    src: imageUrl,
                    imageType: StacImageType.network,
                    fit: StacBoxFit.cover,
                  ),
                ),
                StacPositioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: StacContainer(
                    height: 30,
                    padding: StacEdgeInsets.symmetric(horizontal: 8),
                    color: '#F7FAFD',
                    child: StacRow(
                      textDirection: StacTextDirection.rtl,
                      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                      crossAxisAlignment: StacCrossAxisAlignment.center,
                      children: [
                        StacImage(
                          src: 'assets/icons/shetab.svg',
                          imageType: StacImageType.asset,
                          width: 66,
                          height: 20,
                          fit: StacBoxFit.contain,
                        ),
                        StacImage(
                          src: 'assets/icons/gardeshgary.svg',
                          imageType: StacImageType.asset,
                          width: 64,
                          height: 18,
                          fit: StacBoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          StacExpanded(
            child: StacCenter(
              child: StacPadding(
                padding: StacEdgeInsets.symmetric(horizontal: 8),
                child: StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.center,
                  maxLines: 2,
                  overflow: StacTextOverflow.ellipsis,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

List<Map<String, dynamic>> _withInternetPlanImages(
  List<Map<String, dynamic>> plans,
) {
  return plans.map((plan) {
    final id = (plan['id'] as String?) ?? '';
    if ((plan['imageUrl'] as String?)?.isNotEmpty == true) {
      return plan;
    }
    return <String, dynamic>{
      ...plan,
      'imageUrl': _internetImageFor('gift-plan-$id'),
    };
  }).toList();
}

String _internetImageFor(String seed) {
  final safeSeed = Uri.encodeComponent(seed);
  return 'https://picsum.photos/seed/$safeSeed/1200/560';
}

List<Map<String, dynamic>> _categoryPlansBirthMonths() {
  return const [
    {
      'id': 'birth-month-farvardin',
      'title': 'فروردین',
      'primaryColor': '#BBE86A',
      'secondaryColor': '#79D070',
      'accentColor': '#5CBFA2',
    },
    {
      'id': 'birth-month-ordibehesht',
      'title': 'اردیبهشت',
      'primaryColor': '#B2E27D',
      'secondaryColor': '#85CF78',
      'accentColor': '#44B39C',
    },
    {
      'id': 'birth-month-khordad',
      'title': 'خرداد',
      'primaryColor': '#B5E67D',
      'secondaryColor': '#78D07A',
      'accentColor': '#53B7A7',
    },
    {
      'id': 'birth-month-tir',
      'title': 'تیر',
      'primaryColor': '#BEE56C',
      'secondaryColor': '#87CE77',
      'accentColor': '#43AB9D',
    },
    {
      'id': 'birth-month-mordad',
      'title': 'مرداد',
      'primaryColor': '#CAE178',
      'secondaryColor': '#89CB73',
      'accentColor': '#41A69A',
    },
    {
      'id': 'birth-month-shahrivar',
      'title': 'شهریور',
      'primaryColor': '#BAE981',
      'secondaryColor': '#72CC77',
      'accentColor': '#45A79E',
    },
  ];
}

List<Map<String, dynamic>> _categoryPlansNowruz() {
  return const [
    {
      'id': 'nowruz-1',
      'title': 'بهار سبز',
      'primaryColor': '#3A6BC4',
      'secondaryColor': '#4E78C8',
      'accentColor': '#6A4CBC',
    },
    {
      'id': 'nowruz-2',
      'title': 'تبریک نوروز',
      'primaryColor': '#334FA1',
      'secondaryColor': '#515DBD',
      'accentColor': '#7147AF',
    },
    {
      'id': 'nowruz-3',
      'title': 'هفت‌سین',
      'primaryColor': '#235D9C',
      'secondaryColor': '#426FBB',
      'accentColor': '#6D50B4',
    },
    {
      'id': 'nowruz-4',
      'title': 'سال نو مبارک',
      'primaryColor': '#2D5B9F',
      'secondaryColor': '#4C66B3',
      'accentColor': '#6B58B2',
    },
    {
      'id': 'nowruz-5',
      'title': 'نوروزی',
      'primaryColor': '#2E59AA',
      'secondaryColor': '#4B68B7',
      'accentColor': '#744CB4',
    },
    {
      'id': 'nowruz-6',
      'title': 'بهاریه',
      'primaryColor': '#3B62AA',
      'secondaryColor': '#5A6EC0',
      'accentColor': '#7B56BB',
    },
  ];
}

List<Map<String, dynamic>> _categoryPlansNationalEvents() {
  return const [
    {
      'id': 'national-1',
      'title': 'عید فطر',
      'primaryColor': '#3B73B8',
      'secondaryColor': '#5D8EC2',
      'accentColor': '#D8A63F',
    },
    {
      'id': 'national-2',
      'title': 'روز معلم',
      'primaryColor': '#4478B7',
      'secondaryColor': '#6696CB',
      'accentColor': '#E1B54E',
    },
    {
      'id': 'national-3',
      'title': 'روز پدر',
      'primaryColor': '#4572B5',
      'secondaryColor': '#5B8DC4',
      'accentColor': '#DCA64A',
    },
    {
      'id': 'national-4',
      'title': 'روز مادر',
      'primaryColor': '#3A67A8',
      'secondaryColor': '#6392C4',
      'accentColor': '#D9A04B',
    },
    {
      'id': 'national-5',
      'title': 'روز دانشجو',
      'primaryColor': '#3F6CAF',
      'secondaryColor': '#6695C8',
      'accentColor': '#E2A931',
    },
    {
      'id': 'national-6',
      'title': 'جشن ملی',
      'primaryColor': '#3F6FAF',
      'secondaryColor': '#6791C1',
      'accentColor': '#D6A841',
    },
  ];
}

List<Map<String, dynamic>> _categoryPlansWedding() {
  return const [
    {
      'id': 'wedding-1',
      'title': 'تبریک ازدواج',
      'primaryColor': '#D09D52',
      'secondaryColor': '#AE7C77',
      'accentColor': '#86578A',
    },
    {
      'id': 'wedding-2',
      'title': 'سالگرد',
      'primaryColor': '#C79A66',
      'secondaryColor': '#A77A7E',
      'accentColor': '#8A538A',
    },
    {
      'id': 'wedding-3',
      'title': 'عشق ماندگار',
      'primaryColor': '#C49358',
      'secondaryColor': '#A4707A',
      'accentColor': '#7A4F81',
    },
    {
      'id': 'wedding-4',
      'title': 'هدیه زوج',
      'primaryColor': '#D39A5A',
      'secondaryColor': '#B07883',
      'accentColor': '#8D5185',
    },
    {
      'id': 'wedding-5',
      'title': 'خانه بخت',
      'primaryColor': '#CB9B60',
      'secondaryColor': '#A87E79',
      'accentColor': '#855888',
    },
    {
      'id': 'wedding-6',
      'title': 'پیمان عاشقی',
      'primaryColor': '#C69863',
      'secondaryColor': '#A57573',
      'accentColor': '#875C88',
    },
  ];
}

List<Map<String, dynamic>> _categoryPlansMouse() {
  return const [
    {
      'id': 'mouse2-1',
      'title': 'موشی صورتی',
      'primaryColor': '#DD67BE',
      'secondaryColor': '#C54BB4',
      'accentColor': '#53B8D7',
    },
    {
      'id': 'mouse2-2',
      'title': 'موشی آبی',
      'primaryColor': '#CC5EC1',
      'secondaryColor': '#B94BC6',
      'accentColor': '#48B2D4',
    },
    {
      'id': 'mouse2-3',
      'title': 'موشی رنگی',
      'primaryColor': '#DB67B3',
      'secondaryColor': '#B457C7',
      'accentColor': '#4AC0CD',
    },
    {
      'id': 'mouse2-4',
      'title': 'هدیه کودک',
      'primaryColor': '#D652B7',
      'secondaryColor': '#C45FC2',
      'accentColor': '#52B7DB',
    },
    {
      'id': 'mouse2-5',
      'title': 'شاد و رنگی',
      'primaryColor': '#D85ABF',
      'secondaryColor': '#BF56BE',
      'accentColor': '#5ABFD5',
    },
    {
      'id': 'mouse2-6',
      'title': 'عروسکی',
      'primaryColor': '#D367BA',
      'secondaryColor': '#BD58C5',
      'accentColor': '#59B6CF',
    },
  ];
}

List<Map<String, dynamic>> _categoryPlansSeasons() {
  return const [
    {
      'id': 'season-1',
      'title': 'بهار',
      'primaryColor': '#2C8F53',
      'secondaryColor': '#5DAA57',
      'accentColor': '#D39B3B',
    },
    {
      'id': 'season-2',
      'title': 'تابستان',
      'primaryColor': '#4E9A4D',
      'secondaryColor': '#80AF4B',
      'accentColor': '#DE9B2C',
    },
    {
      'id': 'season-3',
      'title': 'پاییز',
      'primaryColor': '#5E8E4A',
      'secondaryColor': '#A08A46',
      'accentColor': '#CF7C31',
    },
    {
      'id': 'season-4',
      'title': 'زمستان',
      'primaryColor': '#3E7E69',
      'secondaryColor': '#4D9CA6',
      'accentColor': '#91A9D9',
    },
    {
      'id': 'season-5',
      'title': 'تولد بهاری',
      'primaryColor': '#348F62',
      'secondaryColor': '#63B969',
      'accentColor': '#D2A44D',
    },
    {
      'id': 'season-6',
      'title': 'تولد زمستانی',
      'primaryColor': '#407697',
      'secondaryColor': '#5A93B8',
      'accentColor': '#9BB3D5',
    },
  ];
}

List<Map<String, dynamic>> _categoryPlansSpecialDays() {
  return const [
    {
      'id': 'special-day-1',
      'title': 'روز مادر',
      'primaryColor': '#8494A0',
      'secondaryColor': '#6C7E8D',
      'accentColor': '#42556A',
    },
    {
      'id': 'special-day-2',
      'title': 'روز پدر',
      'primaryColor': '#768A9A',
      'secondaryColor': '#617483',
      'accentColor': '#364A5E',
    },
    {
      'id': 'special-day-3',
      'title': 'روز معلم',
      'primaryColor': '#7C93A1',
      'secondaryColor': '#647A8A',
      'accentColor': '#3E5668',
    },
    {
      'id': 'special-day-4',
      'title': 'تشکر',
      'primaryColor': '#8897A2',
      'secondaryColor': '#6B7A88',
      'accentColor': '#45576A',
    },
    {
      'id': 'special-day-5',
      'title': 'تقدیر',
      'primaryColor': '#798A96',
      'secondaryColor': '#5F7381',
      'accentColor': '#394D61',
    },
    {
      'id': 'special-day-6',
      'title': 'روز خاص',
      'primaryColor': '#7F8C99',
      'secondaryColor': '#607484',
      'accentColor': '#3D4F61',
    },
  ];
}

List<Map<String, dynamic>> _categoryPlansHistoricalPlaces() {
  return const [
    {
      'id': 'history-1',
      'title': 'بافت تاریخی',
      'primaryColor': '#98536C',
      'secondaryColor': '#A27553',
      'accentColor': '#B99945',
    },
    {
      'id': 'history-2',
      'title': 'طاق ایرانی',
      'primaryColor': '#92566A',
      'secondaryColor': '#9C7A53',
      'accentColor': '#AA8F49',
    },
    {
      'id': 'history-3',
      'title': 'کاشی‌کاری',
      'primaryColor': '#8B4D67',
      'secondaryColor': '#9C724F',
      'accentColor': '#B48943',
    },
    {
      'id': 'history-4',
      'title': 'موزه',
      'primaryColor': '#9A5A73',
      'secondaryColor': '#A07D56',
      'accentColor': '#B9944F',
    },
    {
      'id': 'history-5',
      'title': 'میراث کهن',
      'primaryColor': '#8C4E63',
      'secondaryColor': '#9A7651',
      'accentColor': '#AE8F4B',
    },
    {
      'id': 'history-6',
      'title': 'معماری ایرانی',
      'primaryColor': '#8E5772',
      'secondaryColor': '#A27651',
      'accentColor': '#B48D42',
    },
  ];
}
