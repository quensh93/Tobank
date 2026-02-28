import sys

file_path = 'lib/stac/tobank/flows/promissory_real/dart/promissory_real_rules.dart'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

target = """          {
            'actionType': 'networkRequest',
            'url':
                'http://192.168.107.22:8280/api/digitalbanking/governance/v1.0/sana/{{userData.nationalCode}}/1',
            'method': 'get',
            'headers': {
              'accept': 'application/json',
              'authorization': '{{auth.accessToken}}',
            },
            'results': [
              {
                'statusCode': 200,
                'action': {
                  'actionType': 'sequence',
                  'actions': [
                    {
                      'actionType': 'setValue',
                      'key': 'isSanaLoading',
                      'value': false,
                    },
                    StacNavigateAction(
                      routeName: 'promissory_real_issuer',
                      navigationStyle: NavigationStyle.push,
                    ).toJson(),
                  ],
                },
              },
              {
                'statusCode': 500,
                'action': {
                  'actionType': 'sequence',
                  'actions': [
                    {
                      'actionType': 'setValue',
                      'key': 'isSanaLoading',
                      'value': false,
                    },
                    {
                      'actionType': 'showSnackBar',
                      'backgroundColor': '#D32F2F',
                      'content': {
                        'type': 'text',
                        // خطا در برقراری ارتباط با سرور
                        'data': '{{appStrings.promissory.serverConnectionError}}',
                        'style': {
                          'type': 'custom',
                          'color': '#FFFFFF',
                          'fontSize': 14,
                        },
                      },
                    },
                  ],
                },
              },
              {
                'statusCode': -1,
                'action': {
                  'actionType': 'sequence',
                  'actions': [
                    {
                      'actionType': 'setValue',
                      'key': 'isSanaLoading',
                      'value': false,
                    },
                    {
                      'actionType': 'showSnackBar',
                      'backgroundColor': '#D32F2F',
                      'content': {
                        'type': 'text',
                        // خطایی رخ داده است
                        'data':
                            '{{data.status.message.0 ?? appStrings.common.somethingWentWrong}}',
                        'style': {
                          'type': 'custom',
                          'color': '#FFFFFF',
                          'fontSize': 14,
                        },
                      },
                    },
                  ],
                },
              },
            ],
          },"""

replacement = """          {
            'actionType': 'apiCall',
            'path':
                '/api/digitalbanking/governance/v1.0/sana/{{userData.nationalCode}}/1',
            'method': 'get',
            'results': [
              {
                'statusCode': 200,
                'action': {
                  'actionType': 'sequence',
                  'actions': [
                    {
                      'actionType': 'setValue',
                      'key': 'isSanaLoading',
                      'value': false,
                    },
                    StacNavigateAction(
                      routeName: 'promissory_real_issuer',
                      navigationStyle: NavigationStyle.push,
                    ).toJson(),
                  ],
                },
              },
              {
                'statusCode': -1,
                'action': {
                  'actionType': 'setValue',
                  'key': 'isSanaLoading',
                  'value': false,
                },
              },
            ],
          },"""

if target in content:
    print('Target matched')
    new_content = content.replace(target, replacement)
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
else:
    print('Target NOT matched')
