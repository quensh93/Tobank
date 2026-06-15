import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'profile_destinations')
StacWidget profileRealDestinations() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'profileRealShowAddCardSheet', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        showBack: true,
        title: '???????',
      ),
      body: StacStack(
        children: [
          StacDefaultTabController(
            length: 3,
            initialIndex: 2,
            child: StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  _tabSwitcher(),
                  StacSizedBox(height: 16),
                  StacExpanded(
                    child: StacTabBarView(
                      children: [
                        StacSingleChildScrollView(child: _ibanTabList()),
                        StacSingleChildScrollView(child: _depositTabList()),
                        StacSingleChildScrollView(
                          child: StacColumn(
                            children: [
                              _cardTabList(),
                              StacSizedBox(height: 16),
                              _addDestinationButton(),
                              StacSizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          StacCustomVisibility(
            visible: '[[profileRealShowAddCardSheet]]',
            child: _addCardBottomSheetOverlay().toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _tabSwitcher() {
  return StacStack(
    children: [
      StacTabBar(
        enableFeedback: false,
        dividerColor: '#00000000',
        indicatorColor: '{{appColors.current.primary.color}}',
        indicatorWeight: 2,
        indicatorSize: StacTabBarIndicatorSize.tab,
        indicatorPadding: StacEdgeInsets.only(left: 48, top: 42, right: 48),
        labelStyle: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
        ),
        unselectedLabelStyle: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w500,
        ),
        labelColor: '{{appColors.current.text.title}}',
        unselectedLabelColor: '{{appColors.current.text.subtitle}}',
        tabs: const [
          StacTab(text: '???', height: 44),
          StacTab(text: '?????', height: 44),
          StacTab(text: '????', height: 44),
        ],
      ),
      StacPositioned(
        top: 10,
        bottom: 10,
        left: 0,
        right: 0,
        child: StacRow(
          children: [
            StacExpanded(child: StacSizedBox()),
            StacContainer(
              width: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
            StacExpanded(child: StacSizedBox()),
            StacContainer(
              width: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
            StacExpanded(child: StacSizedBox()),
          ],
        ),
      ),
    ],
  );
}

StacWidget _cardTabList() {
  return StacColumn(
    children: [
      _destinationCard(
        title: 'yuy',
        subtitle: '???? - ???? - ???? - ????',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '??????? - ???? ?????',
        subtitle: '???? - ???? - ???? - ????',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '????? ?????',
        subtitle: '???? - ???? - ???? - ????',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'blu',
        subtitle: '???? - ???? - ???? - ????',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: 'blu',
        subtitle: '???? - ???? - ???? - ????',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
    ],
  );
}

StacWidget _depositTabList() {
  return StacColumn(
    children: [
      _destinationCard(
        title: '???? ????????',
        subtitle: '???.????.???????.?',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '?????? ???????',
        subtitle: '???.????.???????.?',
        logoAsset: 'assets/icons/ic_success_new.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '???? ????????',
        subtitle: '???.???.???????.?',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '???? ?????? ???',
        subtitle: '???.????.???????.?',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
    ],
  );
}

StacWidget _ibanTabList() {
  return StacColumn(
    children: [
      _destinationCard(
        title: '???? ????????',
        subtitle: 'IR???????????????????????',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '?????? ??? ???',
        subtitle: 'IR?????????????????????????',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '???? ???? ????',
        subtitle: 'IR????????????????????????',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '??? ?????',
        subtitle: 'IR??????????????????????',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '???? ?????',
        subtitle: 'IR????????????????????????',
        logoAsset: 'assets/icons/ic_gardeshgari.svg',
      ),
      StacSizedBox(height: 16),
      _destinationCard(
        title: '???? ????????',
        subtitle: 'IR???????????????????????',
        logoAsset: 'assets/icons/ic_success_new.svg',
      ),
    ],
  );
}

StacWidget _destinationCard({
  required String title,
  required String subtitle,
  required String logoAsset,
}) {
  return StacGestureDetector(
    onTap: const StacShowResultAction(
      title: '????????',
      content: '?????? ???? ?? ???? ???? ??????.',
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surface}}',
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacImage(
            src: logoAsset,
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
          ),
          StacSizedBox(width: 10),
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacSizedBox(height: 8),
                StacText(
                  data: subtitle,
                  textDirection: StacTextDirection.ltr,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    fontSize: 17,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ),
          StacSizedBox(width: 8),
          StacContainer(
            width: 1,
            height: 16,
            color: '{{appColors.current.input.borderEnabled}}',
          ),
          StacSizedBox(width: 8),
          StacIcon(
            icon: 'more_vert',
            size: 20,
            color: '{{appColors.current.text.title}}',
          ),
        ],
      ),
    ),
  );
}

StacWidget _addDestinationButton() {
  return StacFilledButton(
    onPressed: const StacCustomSetValueAction(
      key: 'profileRealShowAddCardSheet',
      value: true,
    ),
    style: StacButtonStyle(
      elevation: 6,
      fixedSize: const StacSize(175, 56),
      padding: StacEdgeInsets.symmetric(horizontal: 12),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(16)),
      backgroundColor: '{{appColors.current.button.primary.backgroundColor}}',
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      mainAxisSize: StacMainAxisSize.min,
      textDirection: StacTextDirection.rtl,
      children: [
        StacContainer(
          width: 24,
          height: 24,
          decoration: StacBoxDecoration(
            borderRadius: StacBorderRadius.all(6),
            border: StacBorder.all(
              color: '{{appColors.current.button.primary.foregroundColor}}',
              width: 1,
            ),
          ),
          child: StacCenter(
            child: StacIcon(
              icon: 'add',
              size: 15,
              color: '{{appColors.current.button.primary.foregroundColor}}',
            ),
          ),
        ),
        StacSizedBox(width: 7),
        StacText(
          data: '?????? ???? ????',
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.button.primary.foregroundColor}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _addCardBottomSheetOverlay() {
  return StacStack(
    children: [
      StacGestureDetector(
        onTap: const StacCustomSetValueAction(
          key: 'profileRealShowAddCardSheet',
          value: false,
        ),
        child: StacContainer(width: 999999, height: 999999, color: '#9F000000'),
      ),
      StacAlign(
        alignment: StacAlignmentDirectional.bottomCenter,
        child: StacContainer(
          width: 999999,
          padding: StacEdgeInsets.only(
            left: 16,
            right: 16,
            top: 10,
            bottom: 16,
          ),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surface}}',
            borderRadius: StacBorderRadius.only(topLeft: 16, topRight: 16),
          ),
          child: StacColumn(
            mainAxisSize: StacMainAxisSize.min,
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacCenter(
                child: StacContainer(
                  width: 44,
                  height: 5,
                  decoration: StacBoxDecoration(
                    color: '#668790A3',
                    borderRadius: StacBorderRadius.all(999),
                  ),
                ),
              ),
              StacSizedBox(height: 24),
              StacRow(
                textDirection: StacTextDirection.rtl,
                children: [
                  StacExpanded(
                    child: StacText(
                      data: '?????? ???? ????',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ),
                  StacSizedBox(width: 12),
                  StacOutlinedButton(
                    onPressed: const StacShowResultAction(
                      title: '???? ????',
                      content: '??? ??? ?? ???? ???? ??????.',
                    ),
                    style: StacButtonStyle(
                      minimumSize: const StacSize(125, 50),
                      side: StacBorderSide(
                        color: '{{appColors.current.text.title}}',
                        width: 1,
                      ),
                      shape: StacRoundedRectangleBorder(
                        borderRadius: StacBorderRadius.all(10),
                      ),
                    ),
                    child: StacRow(
                      mainAxisSize: StacMainAxisSize.min,
                      textDirection: StacTextDirection.rtl,
                      children: [
                        StacImage(
                          src: 'assets/icons/ic_scanner.svg',
                          imageType: StacImageType.asset,
                          width: 23,
                          height: 23,
                          color: '{{appColors.current.text.title}}',
                        ),
                        StacSizedBox(width: 6),
                        StacText(
                          data: '???? ????',
                          style: StacCustomTextStyle(
                            fontSize: 14,
                            fontWeight: StacFontWeight.w600,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              StacSizedBox(height: 16),
              StacText(
                data: '????? ????',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 8),
              StacTextFormField(
                id: 'profileRealDestinationCardNumber',
                textDirection: StacTextDirection.ltr,
                textAlign: StacTextAlign.right,
                keyboardType: StacTextInputType.number,
                decoration: StacInputDecoration(
                  hintText: '?? ????? ???? ????? ???? ??????',
                  hintStyle: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.hint}}',
                  ),
                  filled: false,
                  contentPadding: StacEdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 19,
                  ),
                ),
              ),
              StacSizedBox(height: 16),
              StacText(
                data: '????? ????',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 8),
              StacTextFormField(
                id: 'profileRealDestinationCardTitle',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                keyboardType: StacTextInputType.text,
                decoration: StacInputDecoration(
                  hintText: '????? ???? ?? ???? ????',
                  hintStyle: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.hint}}',
                  ),
                  filled: false,
                  contentPadding: StacEdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 19,
                  ),
                ),
              ),
              StacSizedBox(height: 24),
              StacFilledButton(
                onPressed: const StacSequenceAction(
                  actions: [
                    StacCustomSetValueAction(
                      key: 'profileRealShowAddCardSheet',
                      value: false,
                    ),
                    StacShowResultAction(
                      title: '???',
                      content: '???? ???? ?? ?????? ??? ??.',
                    ),
                  ],
                ),
                style: StacButtonStyle(
                  fixedSize: const StacSize(999999, 52),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(10),
                  ),
                  backgroundColor:
                      '{{appColors.current.button.primary.backgroundColor}}',
                ),
                child: StacText(
                  data: '???',
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color:
                        '{{appColors.current.button.primary.foregroundColor}}',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

