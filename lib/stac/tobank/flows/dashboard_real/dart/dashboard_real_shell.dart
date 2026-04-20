import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac/tobank/flows/cartable_real/dart/cartable_real_intro.dart'
    as cartable_real_intro_dart;
import 'package:tobank_sdui/stac/tobank/flows/profile_real/dart/profile_real_intro.dart'
    as profile_real_intro_dart;
import 'package:tobank_sdui/stac/tobank/flows/transaction_real/dart/transaction_real_intro.dart'
    as transaction_real_intro_dart;
import 'package:tobank_sdui/stac/tobank/home_page/dart/home_page.dart'
    as home_page_dart;

@StacScreen(screenName: 'dashboard_real_shell')
StacWidget dashboardRealShell() {
  return StacDefaultBottomNavigationController(
    length: 4,
    initialIndex: 3,
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      body: StacBottomNavigationView(
        children: [
          profile_real_intro_dart.profileRealIntro(),
          cartable_real_intro_dart.cartableRealIntro(),
          transaction_real_intro_dart.transactionRealIntro(),
          home_page_dart.tobankHomePageDart(),
        ],
      ),
      bottomNavigationBar: StacContainer(
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surfaceContainerLowest}}',
          border: StacBorder(
            top: StacBorderSide(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
        ),
        child: StacBottomNavigationBar(
          barType: StacBottomNavigationBarType.fixed,
          backgroundColor:
              '{{appColors.current.background.surfaceContainerLowest}}',
          selectedItemColor: '{{appColors.current.text.title}}',
          unselectedItemColor: '{{appColors.current.text.subtitle}}',
          iconSize: 24,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: false,
          items: [
            StacBottomNavigationBarItem(
              label: 'پروفایل',
              icon: StacImage(
                src: 'assets/icons/ic_profile_main.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.title}}',
              ),
              activeIcon: StacImage(
                src: 'assets/icons/ic_profile_main_selected.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacBottomNavigationBarItem(
              label: 'کارتابل',
              icon: StacImage(
                src: 'assets/icons/ic_cardboard.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.title}}',
              ),
              activeIcon: StacImage(
                src: 'assets/icons/ic_cardboard_selected.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacBottomNavigationBarItem(
              label: 'تراکنش‌ها',
              icon: StacImage(
                src: 'assets/icons/ic_transaction_main.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.title}}',
              ),
              activeIcon: StacImage(
                src: 'assets/icons/ic_transaction_main_selected.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacBottomNavigationBarItem(
              label: 'خانه',
              icon: StacImage(
                src: 'assets/icons/ic_home_main.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.title}}',
              ),
              activeIcon: StacImage(
                src: 'assets/icons/ic_home_main_selected.svg',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
