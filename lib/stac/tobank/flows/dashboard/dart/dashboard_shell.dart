import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac/tobank/flows/cartable/dart/cartable_intro.dart'
    as cartable_intro_dart;
import 'package:tobank_sdui/stac/tobank/flows/profile/dart/profile_intro.dart'
    as profile_intro_dart;
import 'package:tobank_sdui/stac/tobank/flows/transaction/dart/transaction_intro.dart'
    as transaction_intro_dart;
import 'package:tobank_sdui/stac/tobank/flows/home_page/dart/home_page.dart'
    as home_page_dart;

@StacScreen(screenName: 'dashboard_shell')
StacWidget dashboardRealShell() {
  return StacDefaultBottomNavigationController(
    length: 4,
    initialIndex: 3,
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      body: StacBottomNavigationView(
        children: [
          profile_intro_dart.profileRealIntro(),
          cartable_intro_dart.cartableRealIntro(),
          transaction_intro_dart.transactionRealIntro(),
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
              label: '\u067e\u0631\u0648\u0641\u0627\u06cc\u0644',
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
              label: '\u06a9\u0627\u0631\u062a\u0627\u0628\u0644',
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
              label: '\u062a\u0631\u0627\u06a9\u0646\u0634\u200c\u0647\u0627',
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
              label: '\u062e\u0627\u0646\u0647',
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
