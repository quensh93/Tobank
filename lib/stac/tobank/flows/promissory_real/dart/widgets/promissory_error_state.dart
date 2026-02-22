/// Helper: Promissory Error State
Map<String, dynamic> buildPromissoryErrorState(String errorStateKey) {
  return {
    'type': 'registryReactive',
    'registryKey': errorStateKey,
    'child': {
      'type': 'visibility',
      'visible': '{{$errorStateKey}}',
      'child': {
        'type': 'center',
        'child': {
          'type': 'column',
          'mainAxisAlignment': 'center',
          'children': [
            {
              'type': 'image',
              'src': 'assets/icons/ic_info.svg',
              'imageType': 'asset',
              'width': 48,
              'height': 48,
              'color': '#D32F2F',
            },
            {'type': 'sizedBox', 'height': 16},
            {
              'type': 'text',
              // خطا در برقراری ارتباط با سرور
              'data': '{{appStrings.promissory.serverConnectionError}}',
              'textDirection': 'rtl',
              'textAlign': 'center',
              'style': {
                'type': 'custom',
                'fontSize': 16,
                'fontWeight': 'bold',
                'color': '{{appColors.current.text.title}}',
              },
            },
            {'type': 'sizedBox', 'height': 24},
            {
              'type': 'container',
              'width': 200,
              'child': {
                'type': 'evaluateExpressionAction',
                'expression': 'tryAgain()',
              },
            },
          ],
        },
      },
    },
  };
}
