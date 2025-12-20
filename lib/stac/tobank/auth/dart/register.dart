import 'package:stac_core/stac_core.dart';
import 'package:stac_core/actions/network_request/stac_network_request.dart';

/// Tobank Register Screen - User Registration
/// 
/// This screen provides a registration form with name, email, password, and confirm password fields.
/// Uses data binding to load all text strings from mock API.
/// 
/// Uses STAC theme colors which automatically adapt to light/dark mode.
@StacScreen(screenName: 'tobank_register')
StacWidget tobankRegister() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.register.title}}',
        style: StacCustomTextStyle(
          fontSize: 20,
          fontWeight: StacFontWeight.bold,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      centerTitle: true,
    ),
    body: StacDynamicView(
      request: StacNetworkRequest(
        url: 'https://api.tobank.com/register-labels',
        method: Method.get,
      ),
      targetPath: 'data',
      loaderWidget: StacCenter(
        child: StacCircularProgressIndicator(),
      ),
      errorWidget: StacCenter(
        child: StacText(
          data: '{{appStrings.register.errorLoading}}',
          style: StacCustomTextStyle(
            color: '{{appColors.current.error.color}}',
          ),
        ),
      ),
      template: StacSingleChildScrollView(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: StacForm(
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            mainAxisAlignment: StacMainAxisAlignment.start,
            children: [
              StacSizedBox(height: 16),
              
              // Title
              StacText(
                data: '{{title}}',
                style: StacCustomTextStyle(
                  fontSize: 24,
                  fontWeight: StacFontWeight.bold,
                  color: '{{appColors.current.text.title}}',
                ),
                textAlign: StacTextAlign.center,
              ),
              
              StacSizedBox(height: 8),
              
              // Subtitle
              StacText(
                data: '{{subtitle}}',
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w400,
                  color: '{{appColors.current.text.subtitle}}',
                ),
                textAlign: StacTextAlign.center,
              ),
              
              StacSizedBox(height: 32),
              
              // Full Name Field
              StacText(
                data: '{{fullNameLabel}}',
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 8),
              
              StacTextFormField(
                id: 'full_name',
                decoration: StacInputDecoration(
                  hintText: '{{fullNamePlaceholder}}',
                  hintStyle: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  filled: true,
                  fillColor: 'surface',
                ),
                keyboardType: StacTextInputType.text,
                textInputAction: StacTextInputAction.next,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 16),
              
              // Email Field
              StacText(
                data: '{{emailLabel}}',
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 8),
              
              StacTextFormField(
                id: 'email',
                decoration: StacInputDecoration(
                  hintText: '{{emailPlaceholder}}',
                  hintStyle: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  filled: true,
                  fillColor: 'surface',
                ),
                keyboardType: StacTextInputType.emailAddress,
                textInputAction: StacTextInputAction.next,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 16),
              
              // Password Field
              StacText(
                data: '{{passwordLabel}}',
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 8),
              
              StacTextFormField(
                id: 'password',
                decoration: StacInputDecoration(
                  hintText: '{{passwordPlaceholder}}',
                  hintStyle: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  filled: true,
                  fillColor: 'surface',
                ),
                obscureText: true,
                keyboardType: StacTextInputType.visiblePassword,
                textInputAction: StacTextInputAction.next,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 16),
              
              // Confirm Password Field
              StacText(
                data: '{{confirmPasswordLabel}}',
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 8),
              
              StacTextFormField(
                id: 'confirm_password',
                decoration: StacInputDecoration(
                  hintText: '{{confirmPasswordPlaceholder}}',
                  hintStyle: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  filled: true,
                  fillColor: 'surface',
                ),
                obscureText: true,
                keyboardType: StacTextInputType.visiblePassword,
                textInputAction: StacTextInputAction.done,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 24),
              
              // Register Button
              StacElevatedButton(
                onPressed: StacMultiAction(
                  actions: [
                    StacDialogAction(
                      widget: {
                        'type': 'alertDialog',
                        'title': {
                          'type': 'text',
                          'data': '{{successTitle}}',
                          'style': {
                            'type': 'custom',
                            'fontSize': 18,
                            'fontWeight': 'bold',
                            'color': '{{appColors.current.text.title}}',
                          },
                        },
                        'content': {
                          'type': 'text',
                          'data': '{{successMessage}}',
                          'style': {
                            'type': 'custom',
                            'fontSize': 14,
                            'color': '{{appColors.current.text.subtitle}}',
                          },
                        },
                        'actions': [
                          {
                            'type': 'textButton',
                            'child': {
                              'type': 'text',
                              'data': '{{okButtonText}}',
                              'style': {
                                'type': 'custom',
                                'color': 'primary',
                              },
                            },
                            'onPressed': {
                              'actionType': 'navigate',
                              'assetPath': 'stac/.build/tobank_login.json',
                              'navigationStyle': 'push',
                            },
                          },
                        ],
                      },
                    ),
                  ],
                ),
                style: StacButtonStyle(
                  backgroundColor: 'primary',
                  padding: StacEdgeInsets.symmetric(vertical: 16),
                ),
                child: StacText(
                  data: '{{registerButtonText}}',
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.bold,
                    color: 'onPrimary',
                  ),
                ),
              ),
              
              StacSizedBox(height: 16),
              
              // Login Link
              StacRow(
                mainAxisAlignment: StacMainAxisAlignment.center,
                children: [
                  StacText(
                    data: '{{loginLinkText}}',
                    style: StacCustomTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w400,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                  ),
                  StacTextButton(
                    onPressed: StacNavigateAction(
                      assetPath: 'stac/.build/tobank_login.json',
                      navigationStyle: NavigationStyle.push,
                    ),
                    child: StacText(
                      data: '{{loginButtonText}}',
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.primary.color}}',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
