import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/api/api_config.dart';
import 'package:tobank_sdui/core/api/exceptions/api_exceptions.dart';
import 'package:tobank_sdui/core/api/services/supabase_api_service.dart';

class InMemorySupabaseGateway implements SupabaseGateway {
  final Map<String, Map<String, dynamic>> screens = {};
  final Map<String, Map<String, dynamic>> configs = {};
  final Map<String, List<Map<String, dynamic>>> versions = {};

  @override
  Future<Map<String, dynamic>?> fetchScreen(String screenName) async {
    return screens[screenName];
  }

  @override
  Future<Map<String, dynamic>?> fetchConfig(String configName) async {
    return configs[configName];
  }

  @override
  Future<List<Map<String, dynamic>>> listScreens() async {
    return screens.values
        .map((screen) => {'name': screen['name'] as String})
        .toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getVersionHistory(
    String screenName,
  ) async {
    return versions[screenName] ?? <Map<String, dynamic>>[];
  }
}

void main() {
  group('SupabaseApiService', () {
    late InMemorySupabaseGateway gateway;
    late SupabaseApiService service;

    setUp(() {
      gateway = InMemorySupabaseGateway();
      service = SupabaseApiService(
        config: ApiConfig.supabase(
          'https://example.supabase.co',
          'public-anon-key',
        ),
        gateway: gateway,
      );
    });

    test('fetchScreen should return JSON payload', () async {
      gateway.screens['home_screen'] = {
        'name': 'home_screen',
        'json': {
          'type': 'scaffold',
          'body': {'type': 'text', 'data': 'Home'},
        },
      };

      final result = await service.fetchScreen('home_screen');

      expect(result['type'], equals('scaffold'));
      expect(service.isCached('screen_home_screen'), isTrue);
    });

    test('fetchScreen should throw when screen is missing', () async {
      expect(
        () => service.fetchScreen('missing_screen'),
        throwsA(isA<ScreenNotFoundException>()),
      );
    });

    test('fetchRoute should resolve slash routes to screen names', () async {
      gateway.screens['home_screen'] = {
        'name': 'home_screen',
        'json': {'type': 'scaffold'},
      };

      final result = await service.fetchRoute('/');
      expect(result['type'], equals('scaffold'));
    });

    test('fetchConfig should return config JSON', () async {
      gateway.configs['navigation'] = {
        'name': 'navigation',
        'json': {
          'routes': [
            {'path': '/', 'screen': 'home_screen'},
          ],
        },
      };

      final config = await service.fetchConfig('navigation');
      expect(config['routes'], isA<List>());
    });

    test('getScreenMetadata should exclude json payload', () async {
      gateway.screens['profile_screen'] = {
        'name': 'profile_screen',
        'json': {'type': 'scaffold'},
        'updated_at': DateTime(2024, 1, 1),
      };

      final metadata = await service.getScreenMetadata('profile_screen');
      expect(metadata.containsKey('json'), isFalse);
      expect(metadata['updated_at'], isNotNull);
    });

    test('listScreens should return ordered names', () async {
      gateway.screens['a_screen'] = {'name': 'a_screen'};
      gateway.screens['b_screen'] = {'name': 'b_screen'};

      final screens = await service.listScreens();
      expect(screens, containsAll(['a_screen', 'b_screen']));
    });

    test('getVersionHistory should return stored versions', () async {
      gateway.versions['home_screen'] = [
        {'version': 1, 'description': 'Initial'},
      ];

      final history = await service.getVersionHistory('home_screen');
      expect(history, hasLength(1));
      expect(history.first['version'], equals(1));
    });

    test('getCacheStats should track valid cache entries', () async {
      gateway.screens['home_screen'] = {
        'name': 'home_screen',
        'json': {'type': 'scaffold'},
      };
      await service.fetchScreen('home_screen');

      final stats = service.getCacheStats();
      expect(stats['total_cached'], equals(1));
      expect(stats['valid_cached'], equals(1));
    });

    test('should throw JsonParsingException for invalid payload type', () {
      gateway.screens['broken_screen'] = {
        'name': 'broken_screen',
        'json': 'not-a-map',
      };

      expect(
        () => service.fetchScreen('broken_screen'),
        throwsA(isA<JsonParsingException>()),
      );
    });
  });
}
