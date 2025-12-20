import 'package:stac_core/stac_core.dart';
import 'package:stac_core/actions/network_request/stac_network_request.dart';

/// Tobank Profile Screen - User profile and information
/// 
/// This screen displays user profile information including:
/// - User name
/// - Mobile number
/// - Customer number
/// - Email
/// 
/// Uses data binding to load all data from mock API.
/// Uses Persian text from app_fa.arb.
/// Uses STAC theme colors which automatically adapt to light/dark mode.
/// 
/// Reference: `.tobank_old/lib/ui/dashboard_screen/page/account_page.dart`
@StacScreen(screenName: 'tobank_profile')
StacWidget tobankProfile() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacDynamicView(
        request: StacNetworkRequest(
          url: 'https://api.tobank.com/profile-data',
          method: Method.get,
        ),
        targetPath: 'data',
        template: StacText(
          data: '{{appBarTitle}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        loaderWidget: StacText(
          data: '{{appStrings.profile.title}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        errorWidget: StacText(
          data: '{{appStrings.profile.title}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      centerTitle: true,
    ),
    body: StacDynamicView(
      request: StacNetworkRequest(
        url: 'https://api.tobank.com/profile-data',
        method: Method.get,
      ),
      targetPath: 'data',
      loaderWidget: StacCenter(
        child: StacCircularProgressIndicator(),
      ),
      errorWidget: StacCenter(
        child: StacText(
          data: '{{appStrings.profile.errorLoading}}',
          style: StacCustomTextStyle(
            color: '{{appColors.current.error.color}}',
          ),
        ),
      ),
      template: StacSingleChildScrollView(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            // Name Card
            StacCard(
              child: StacPadding(
                padding: StacEdgeInsets.all(24),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.start,
                  children: [
                    StacText(
                      data: '{{nameLabel}}',
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w400,
                        color: '{{appColors.current.text.subtitle}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacText(
                      data: '{{userName}}',
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.bold,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            StacSizedBox(height: 16),
            
            // Mobile Number Card
            StacCard(
              child: StacPadding(
                padding: StacEdgeInsets.all(24),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.start,
                  children: [
                    StacText(
                      data: '{{mobileLabel}}',
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w400,
                        color: '{{appColors.current.text.subtitle}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacText(
                      data: '{{mobileNumber}}',
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.bold,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            StacSizedBox(height: 16),
            
            // Customer Number Card
            StacCard(
              child: StacPadding(
                padding: StacEdgeInsets.all(24),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.start,
                  children: [
                    StacText(
                      data: '{{customerNumberLabel}}',
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w400,
                        color: '{{appColors.current.text.subtitle}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacText(
                      data: '{{customerNumber}}',
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.bold,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            StacSizedBox(height: 16),
            
            // Email Card
            StacCard(
              child: StacPadding(
                padding: StacEdgeInsets.all(24),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.start,
                  children: [
                    StacText(
                      data: '{{emailLabel}}',
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w400,
                        color: '{{appColors.current.text.subtitle}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacText(
                      data: '{{email}}',
                      style: StacCustomTextStyle(
                        fontSize: 18,
                        fontWeight: StacFontWeight.bold,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            StacSizedBox(height: 24),
            
            // Edit Profile Button
            StacElevatedButton(
              onPressed: StacNavigateAction(
                assetPath: 'stac/.build/tobank_edit_profile.json',
                navigationStyle: NavigationStyle.push,
              ),
              style: StacButtonStyle(
                backgroundColor: 'primary',
                padding: StacEdgeInsets.symmetric(vertical: 16),
              ),
              child: StacText(
                data: '{{editProfileButtonText}}',
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.bold,
                  color: 'onPrimary',
                ),
              ),
            ),
            
            StacSizedBox(height: 16),
            
            // Settings Button
            StacOutlinedButton(
              onPressed: StacNavigateAction(
                assetPath: 'stac/.build/tobank_settings.json',
                navigationStyle: NavigationStyle.push,
              ),
              style: StacButtonStyle(
                padding: StacEdgeInsets.symmetric(vertical: 16),
              ),
              child: StacText(
                data: '{{settingsButtonText}}',
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.bold,
                  color: '{{appColors.current.primary.color}}',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
