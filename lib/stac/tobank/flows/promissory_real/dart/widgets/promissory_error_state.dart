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
              'width': double.infinity,
              'padding': {'top': 0, 'right': 16, 'bottom': 16, 'left': 16},
              'child': {
                'type': 'elevatedButton',
                'onPressed': {'actionType': 'pop'},
                'style': {
                  'backgroundColor': '{{appColors.current.primary.color}}',
                  'foregroundColor': '{{appColors.current.primary.onPrimary}}',
                  'shape': {
                    'type': 'roundedRectangle',
                    'borderRadius': {'type': 'all', 'radius': 12},
                  },
                },
                'child': {
                  'type': 'text',
                  'data': 'بازگشت',
                  'style': {
                    'type': 'custom',
                    'fontSize': 16,
                    'fontWeight': 'bold',
                  },
                },
              },
            },
          ],
        },
      },
    },
  };
}
