import 'package:flutter_test/flutter_test.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/stac/parsers/actions/custom_network_request_action_parser.dart';

void main() {
  const parser = CustomNetworkRequestActionParser();

  void clearKeys(List<String> keys) {
    for (final key in keys) {
      StacRegistry.instance.removeValue(key);
    }
  }

  setUp(() {
    clearKeys([
      'data',
      'data_payload',
      'responses.res1.raw',
      'responses.res1.payload',
      'responses.res1.data',
      'responses.res1.statusCode',
      'responses.res1.headers',
      'responses.res1.ok',
      'responses.res1.timestamp',
      'responses.res2.raw',
      'responses.res2.payload',
      'responses.res2.data',
      'responses.res2.statusCode',
      'responses.res2.headers',
      'responses.res2.ok',
      'responses.res2.timestamp',
    ]);
  });

  test('stores bound response with metadata and legacy keys', () {
    final response = <String, dynamic>{
      'data': <String, dynamic>{'id': '123'},
      'status': <String, dynamic>{
        'message': ['ok'],
      },
    };

    parser.storeResponseInRegistry(
      responseData: response,
      statusCode: 200,
      headers: const {
        'x-trace-id': ['abc'],
      },
      dataBind: 'res1',
    );

    expect(StacRegistry.instance.getValue('data'), equals(response));
    expect(
      StacRegistry.instance.getValue('data_payload'),
      equals(<String, dynamic>{'id': '123'}),
    );
    expect(
      StacRegistry.instance.getValue('responses.res1.raw'),
      equals(response),
    );
    expect(
      StacRegistry.instance.getValue('responses.res1.payload'),
      equals(<String, dynamic>{'id': '123'}),
    );
    expect(
      StacRegistry.instance.getValue('responses.res1.data'),
      equals(<String, dynamic>{'id': '123'}),
    );
    expect(
      StacRegistry.instance.getValue('responses.res1.statusCode'),
      equals(200),
    );
    expect(
      StacRegistry.instance.getValue('responses.res1.headers'),
      equals(const {
        'x-trace-id': ['abc'],
      }),
    );
    expect(StacRegistry.instance.getValue('responses.res1.ok'), isTrue);
    expect(
      StacRegistry.instance.getValue('responses.res1.timestamp'),
      isA<int>(),
    );
  });

  test('stores payload as raw when data/result.data is absent', () {
    final response = <String, dynamic>{'message': 'failed'};

    parser.storeResponseInRegistry(
      responseData: response,
      statusCode: 400,
      headers: const {
        'content-type': ['application/json'],
      },
      dataBind: 'res1',
    );

    expect(StacRegistry.instance.getValue('data'), equals(response));
    expect(StacRegistry.instance.getValue('data_payload'), isNull);
    expect(
      StacRegistry.instance.getValue('responses.res1.raw'),
      equals(response),
    );
    expect(
      StacRegistry.instance.getValue('responses.res1.payload'),
      equals(response),
    );
    expect(
      StacRegistry.instance.getValue('responses.res1.data'),
      equals(response),
    );
    expect(StacRegistry.instance.getValue('responses.res1.ok'), isFalse);
    expect(
      StacRegistry.instance.getValue('responses.res1.statusCode'),
      equals(400),
    );
  });

  test(
    'multiple binds do not overwrite each other and legacy keys stay latest',
    () {
      parser.storeResponseInRegistry(
        responseData: const {
          'data': {'id': '1'},
        },
        statusCode: 200,
        headers: const {
          'x-trace-id': ['one'],
        },
        dataBind: 'res1',
      );

      parser.storeResponseInRegistry(
        responseData: const {
          'data': {'id': '2'},
        },
        statusCode: 201,
        headers: const {
          'x-trace-id': ['two'],
        },
        dataBind: 'res2',
      );

      expect(
        StacRegistry.instance.getValue('responses.res1.payload'),
        equals(const {'id': '1'}),
      );
      expect(
        StacRegistry.instance.getValue('responses.res1.data'),
        equals(const {'id': '1'}),
      );
      expect(
        StacRegistry.instance.getValue('responses.res2.payload'),
        equals(const {'id': '2'}),
      );
      expect(
        StacRegistry.instance.getValue('responses.res2.data'),
        equals(const {'id': '2'}),
      );
      expect(
        StacRegistry.instance.getValue('data_payload'),
        equals(const {'id': '2'}),
      );
    },
  );

  test('getModel supports dataBind and data_bind alias', () {
    final modelFromDataBind = parser.getModel({
      'actionType': 'networkRequest',
      'url': 'https://example.com',
      'method': 'get',
      'results': [],
      'dataBind': 'res1',
    });
    final modelFromDataBindAlias = parser.getModel({
      'actionType': 'networkRequest',
      'url': 'https://example.com',
      'method': 'get',
      'results': [],
      'data_bind': 'res2',
    });

    expect(modelFromDataBind.request.url, equals('https://example.com'));
    expect(modelFromDataBind.dataBind, equals('res1'));
    expect(modelFromDataBindAlias.dataBind, equals('res2'));
  });
}
