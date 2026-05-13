/// Helper: Promissory Loading State
Map<String, dynamic> buildPromissoryLoadingState(String loadingStateKey) {
  return {
    'type': 'registryReactive',
    'registryKey': loadingStateKey,
    'child': {
      'type': 'visibility',
      'visible': '{{$loadingStateKey}}',
      'child': {
        'type': 'center',
        'child': {
          'type': 'column',
          'mainAxisAlignment': 'center',
          'children': [
            {
              'type': 'circularProgressIndicator',
              'color': '{{appColors.current.primary.color}}',
            },
            {'type': 'sizedBox', 'height': 16},
            {
              'type': 'text',
              // در حال دریافت...
              'data': '{{appStrings.promissory.loadingText}}',
              'textDirection': 'rtl',
              'style': {
                'type': 'custom',
                'fontSize': 14,
                'color': '{{appColors.current.text.subtitle}}',
              },
            },
          ],
        },
      },
    },
  };
}
