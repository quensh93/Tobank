import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tobank_sdui/core/monitoring/performance_monitor.dart';
import 'package:tobank_sdui/core/cache/cache_manager.dart';

void main() {
  group('Performance Tests', () {
    late PerformanceMonitor monitor;
    late CacheManager cacheManager;

    setUp(() {
      monitor = PerformanceMonitor.instance;
      monitor.clear();
      cacheManager = CacheManager.instance;
    });

    tearDown(() {
      monitor.clear();
    });

    group('JSON Parsing Performance', () {
      test('should parse simple JSON within acceptable time', () async {
        // Arrange
        final simpleJson = {
          'type': 'text',
          'data': 'Hello World',
          'style': {'fontSize': 16, 'color': '#000000'}
        };

        // Act
        final result = await monitor.trackJsonParsing(
          'simple_screen',
          () async {
            // Simulate JSON parsing
            await Future.delayed(const Duration(milliseconds: 10));
            return jsonEncode(simpleJson);
          },
        );

        // Assert
        expect(result, isNotNull);
        final metrics = monitor.getMetrics(type: PerformanceMetricType.jsonParsing);
        expect(metrics.length, equals(1));
        expect(metrics.first.duration.inMilliseconds, lessThan(100));
      });

      test('should parse complex JSON within acceptable time', () async {
        // Arrange
        final complexJson = {
          'type': 'scaffold',
          'appBar': {
            'type': 'appBar',
            'title': {'type': 'text', 'data': 'Complex Screen'}
          },
          'body': {
            'type': 'column',
            'children': List.generate(
              20,
              (i) => {
                'type': 'container',
                'child': {'type': 'text', 'data': 'Item $i'}
              },
            )
          }
        };

        // Act
        final result = await monitor.trackJsonParsing(
          'complex_screen',
          () async {
            // Simulate complex JSON parsing
            await Future.delayed(const Duration(milliseconds: 50));
            return jsonEncode(complexJson);
          },
        );

        // Assert
        expect(result, isNotNull);
        final metrics = monitor.getMetrics(type: PerformanceMetricType.jsonParsing);
        expect(metrics.isNotEmpty, isTrue);
        
        // Complex JSON should still parse within threshold
        final complexMetric = metrics.firstWhere(
          (m) => m.operationId == 'json_parse_complex_screen',
        );
        expect(complexMetric.duration.inMilliseconds, lessThan(200));
      });

      test('should handle multiple concurrent JSON parsing operations', () async {
        // Arrange
        final screens = ['screen1', 'screen2', 'screen3', 'screen4', 'screen5'];
        final json = {'type': 'text', 'data': 'Test'};

        // Act
        final futures = screens.map((screen) {
          return monitor.trackJsonParsing(
            screen,
            () async {
              await Future.delayed(const Duration(milliseconds: 20));
              return jsonEncode(json);
            },
          );
        });

        await Future.wait(futures);

        // Assert
        final metrics = monitor.getMetrics(type: PerformanceMetricType.jsonParsing);
        expect(metrics.length, equals(5));
        
        // All operations should complete within reasonable time
        for (final metric in metrics) {
          expect(metric.duration.inMilliseconds, lessThan(100));
        }
      });

      test('should identify slow JSON parsing operations', () async {
        // Arrange
        final slowJson = {
          'type': 'column',
          'children': List.generate(100, (i) => {'type': 'text', 'data': 'Item $i'})
        };

        // Act
        await monitor.trackJsonParsing(
          'slow_screen',
          () async {
            // Simulate slow parsing (over threshold)
            await Future.delayed(const Duration(milliseconds: 150));
            return jsonEncode(slowJson);
          },
        );

        // Assert
        final slowOps = monitor.getSlowOperations();
        expect(slowOps.isNotEmpty, isTrue);
        expect(slowOps.first.type, equals(PerformanceMetricType.jsonParsing));
        expect(slowOps.first.isSlow, isTrue);
      });

      test('should calculate JSON parsing statistics correctly', () async {
        // Arrange
        final durations = [10, 20, 30, 40, 50]; // milliseconds

        // Act
        for (var i = 0; i < durations.length; i++) {
          await monitor.trackJsonParsing(
            'screen_$i',
            () async {
              await Future.delayed(Duration(milliseconds: durations[i]));
              return '{}';
            },
          );
        }

        // Assert
        final stats = monitor.getStats(type: PerformanceMetricType.jsonParsing);
        expect(stats.totalOperations, equals(5));
        expect(stats.averageDuration, closeTo(30, 15)); // Average of 10-50 with tolerance
        expect(stats.medianDuration, closeTo(30, 15)); // Median is 30 with tolerance
        expect(stats.minDuration, lessThan(20)); // Min should be small
        expect(stats.maxDuration, greaterThan(40)); // Max should be larger
      });
    });

    group('Widget Rendering Performance', () {
      test('should render simple widget within acceptable time', () {
        // Act
        final result = monitor.trackWidgetBuild(
          'SimpleText',
          () {
            // Simulate widget build
            return 'Widget built';
          },
        );

        // Assert
        expect(result, equals('Widget built'));
        final metrics = monitor.getMetrics(type: PerformanceMetricType.widgetBuild);
        expect(metrics.length, equals(1));
        
        // Widget build should be very fast (< 16ms for 60fps)
        expect(metrics.first.duration.inMilliseconds, lessThan(16));
      });

      test('should render complex widget within acceptable time', () {
        // Act
        final result = monitor.trackWidgetBuild(
          'ComplexList',
          () {
            // Simulate complex widget build with some computation
            var sum = 0;
            for (var i = 0; i < 100; i++) {
              sum += i;
            }
            return sum;
          },
        );

        // Assert
        expect(result, isNotNull);
        final metrics = monitor.getMetrics(type: PerformanceMetricType.widgetBuild);
        expect(metrics.isNotEmpty, isTrue);
        
        // Even complex widgets should render quickly
        expect(metrics.first.duration.inMilliseconds, lessThan(50));
      });

      test('should identify slow widget rendering', () {
        // Act
        monitor.trackWidgetBuild(
          'SlowWidget',
          () {
            // Simulate slow widget build (over 16ms threshold)
            final stopwatch = Stopwatch()..start();
            while (stopwatch.elapsedMilliseconds < 20) {
              // Busy wait to simulate slow operation
            }
            stopwatch.stop();
            return 'Slow widget';
          },
        );

        // Assert
        final slowOps = monitor.getSlowOperations();
        expect(slowOps.isNotEmpty, isTrue);
        
        final slowWidget = slowOps.firstWhere(
          (m) => m.type == PerformanceMetricType.widgetBuild,
        );
        expect(slowWidget.isSlow, isTrue);
        expect(slowWidget.duration.inMilliseconds, greaterThan(16));
      });

      test('should handle multiple widget builds efficiently', () {
        // Arrange
        final widgets = ['Widget1', 'Widget2', 'Widget3', 'Widget4', 'Widget5'];

        // Act
        for (final widget in widgets) {
          monitor.trackWidgetBuild(widget, () => 'Built $widget');
        }

        // Assert
        final metrics = monitor.getMetrics(type: PerformanceMetricType.widgetBuild);
        expect(metrics.length, equals(5));
        
        // All widgets should build quickly
        for (final metric in metrics) {
          expect(metric.duration.inMilliseconds, lessThan(16));
        }
      });

      test('should calculate widget rendering statistics', () {
        // Arrange
        final widgets = ['Fast1', 'Fast2', 'Medium', 'Slow1', 'Slow2'];

        // Act
        for (var i = 0; i < widgets.length; i++) {
          monitor.trackWidgetBuild(widgets[i], () {
            // Simulate varying build times
            final stopwatch = Stopwatch()..start();
            final targetMs = (i + 1) * 5; // 5, 10, 15, 20, 25 ms
            while (stopwatch.elapsedMilliseconds < targetMs) {
              // Busy wait
            }
            stopwatch.stop();
            return 'Built';
          });
        }

        // Assert
        final stats = monitor.getStats(type: PerformanceMetricType.widgetBuild);
        expect(stats.totalOperations, equals(5));
        expect(stats.slowOperations, greaterThan(0)); // Some should be slow (>16ms)
      });
    });

    group('API Call Performance', () {
      test('should track API call duration', () async {
        // Act
        final result = await monitor.trackApiCall(
          '/api/screen/home',
          () async {
            await Future.delayed(const Duration(milliseconds: 100));
            return {'data': 'response'};
          },
        );

        // Assert
        expect(result, equals({'data': 'response'}));
        final metrics = monitor.getMetrics(type: PerformanceMetricType.apiCall);
        expect(metrics.length, equals(1));
        expect(metrics.first.duration.inMilliseconds, greaterThanOrEqualTo(100));
      });

      test('should identify slow API calls', () async {
        // Act
        await monitor.trackApiCall(
          '/api/slow-endpoint',
          () async {
            // Simulate slow API call (over 1000ms threshold)
            await Future.delayed(const Duration(milliseconds: 1100));
            return {'data': 'slow response'};
          },
        );

        // Assert
        final slowOps = monitor.getSlowOperations();
        expect(slowOps.isNotEmpty, isTrue);
        
        final slowApi = slowOps.firstWhere(
          (m) => m.type == PerformanceMetricType.apiCall,
        );
        expect(slowApi.isSlow, isTrue);
        expect(slowApi.duration.inMilliseconds, greaterThan(1000));
      });

      test('should track failed API calls', () async {
        // Act & Assert
        try {
          await monitor.trackApiCall(
            '/api/failing-endpoint',
            () async {
              await Future.delayed(const Duration(milliseconds: 50));
              throw Exception('API Error');
            },
          );
          fail('Should have thrown exception');
        } catch (e) {
          expect(e.toString(), contains('API Error'));
        }

        // Assert
        final metrics = monitor.getMetrics(type: PerformanceMetricType.apiCall);
        expect(metrics.length, equals(1));
        expect(metrics.first.failed, isTrue);
        expect(metrics.first.metadata['error'], contains('API Error'));
      });

      test('should calculate API call statistics', () async {
        // Arrange
        final endpoints = [
          '/api/fast',
          '/api/medium',
          '/api/slow',
        ];
        final durations = [100, 500, 1200]; // milliseconds

        // Act
        for (var i = 0; i < endpoints.length; i++) {
          await monitor.trackApiCall(
            endpoints[i],
            () async {
              await Future.delayed(Duration(milliseconds: durations[i]));
              return {'data': 'response'};
            },
          );
        }

        // Assert
        final stats = monitor.getStats(type: PerformanceMetricType.apiCall);
        expect(stats.totalOperations, equals(3));
        expect(stats.slowOperations, greaterThan(0)); // At least one slow call
        expect(stats.averageDuration, closeTo(600, 100)); // Average around 600ms
      });
    });

    group('Performance Statistics', () {
      test('should calculate overall statistics correctly', () async {
        // Arrange - Create mix of operations
        await monitor.trackJsonParsing('screen1', () async {
          await Future.delayed(const Duration(milliseconds: 30));
          return '{}';
        });

        await monitor.trackApiCall('/api/test', () async {
          await Future.delayed(const Duration(milliseconds: 200));
          return {};
        });

        monitor.trackWidgetBuild('TestWidget', () => 'built');

        // Act
        final stats = monitor.getStats();

        // Assert
        expect(stats.totalOperations, equals(3));
        expect(stats.averageDuration, greaterThanOrEqualTo(0));
        expect(stats.minDuration, greaterThanOrEqualTo(0));
        expect(stats.maxDuration, greaterThanOrEqualTo(stats.minDuration));
      });

      test('should calculate percentiles correctly', () async {
        // Arrange - Create 100 operations with known durations
        for (var i = 1; i <= 100; i++) {
          await monitor.trackJsonParsing('screen_$i', () async {
            await Future.delayed(Duration(milliseconds: i));
            return '{}';
          });
        }

        // Act
        final stats = monitor.getStats(type: PerformanceMetricType.jsonParsing);

        // Assert
        expect(stats.totalOperations, equals(100));
        // Percentiles should be in reasonable ranges (async timing can vary)
        expect(stats.p95Duration, greaterThan(85)); // 95th percentile should be high
        expect(stats.p95Duration, lessThan(120)); // But not too high
        expect(stats.p99Duration, greaterThan(90)); // 99th percentile should be higher
        expect(stats.medianDuration, greaterThan(40)); // Median should be around middle
        expect(stats.medianDuration, lessThan(70));
      });

      test('should calculate failure rate correctly', () async {
        // Arrange - Create mix of successful and failed operations
        for (var i = 0; i < 8; i++) {
          await monitor.trackApiCall('/api/success_$i', () async {
            await Future.delayed(const Duration(milliseconds: 10));
            return {};
          });
        }

        for (var i = 0; i < 2; i++) {
          try {
            await monitor.trackApiCall('/api/fail_$i', () async {
              await Future.delayed(const Duration(milliseconds: 10));
              throw Exception('Failed');
            });
          } catch (_) {
            // Expected
          }
        }

        // Act
        final stats = monitor.getStats(type: PerformanceMetricType.apiCall);

        // Assert
        expect(stats.totalOperations, equals(10));
        expect(stats.failedOperations, equals(2));
        expect(stats.failureRate, closeTo(0.2, 0.01)); // 20% failure rate
      });

      test('should calculate slow operation rate correctly', () async {
        // Arrange - Create mix of fast and slow operations
        // Fast operations (< 100ms threshold)
        for (var i = 0; i < 7; i++) {
          await monitor.trackJsonParsing('fast_$i', () async {
            await Future.delayed(const Duration(milliseconds: 50));
            return '{}';
          });
        }

        // Slow operations (> 100ms threshold)
        for (var i = 0; i < 3; i++) {
          await monitor.trackJsonParsing('slow_$i', () async {
            await Future.delayed(const Duration(milliseconds: 150));
            return '{}';
          });
        }

        // Act
        final stats = monitor.getStats(type: PerformanceMetricType.jsonParsing);

        // Assert
        expect(stats.totalOperations, equals(10));
        expect(stats.slowOperations, equals(3));
        expect(stats.slowOperationRate, closeTo(0.3, 0.01)); // 30% slow rate
      });

      test('should return empty stats when no metrics', () {
        // Act
        final stats = monitor.getStats();

        // Assert
        expect(stats.totalOperations, equals(0));
        expect(stats.averageDuration, equals(0));
        expect(stats.failureRate, equals(0));
        expect(stats.slowOperationRate, equals(0));
      });
    });

    group('Performance Monitoring Integration', () {
      test('should track operations with metadata', () async {
        // Act
        await monitor.trackJsonParsing('test_screen', () async {
          await Future.delayed(const Duration(milliseconds: 20));
          return '{}';
        });

        // Assert
        final metrics = monitor.getMetrics();
        expect(metrics.first.metadata['screenName'], equals('test_screen'));
      });

      test('should filter metrics by type', () async {
        // Arrange
        await monitor.trackJsonParsing('screen', () async => '{}');
        await monitor.trackApiCall('/api/test', () async => {});
        monitor.trackWidgetBuild('Widget', () => 'built');

        // Act
        final jsonMetrics = monitor.getMetrics(type: PerformanceMetricType.jsonParsing);
        final apiMetrics = monitor.getMetrics(type: PerformanceMetricType.apiCall);
        final widgetMetrics = monitor.getMetrics(type: PerformanceMetricType.widgetBuild);

        // Assert
        expect(jsonMetrics.length, equals(1));
        expect(apiMetrics.length, equals(1));
        expect(widgetMetrics.length, equals(1));
      });

      test('should filter metrics by minimum duration', () async {
        // Arrange
        await monitor.trackJsonParsing('fast', () async {
          await Future.delayed(const Duration(milliseconds: 10));
          return '{}';
        });

        await monitor.trackJsonParsing('slow', () async {
          await Future.delayed(const Duration(milliseconds: 100));
          return '{}';
        });

        // Act
        final slowMetrics = monitor.getMetrics(
          minDuration: const Duration(milliseconds: 50),
        );

        // Assert
        expect(slowMetrics.length, equals(1));
        expect(slowMetrics.first.operationId, contains('slow'));
      });

      test('should filter metrics by failure status', () async {
        // Arrange
        await monitor.trackApiCall('/api/success', () async => {});

        try {
          await monitor.trackApiCall('/api/fail', () async {
            throw Exception('Failed');
          });
        } catch (_) {
          // Expected
        }

        // Act
        final failedMetrics = monitor.getMetrics(failed: true);
        final successMetrics = monitor.getMetrics(failed: false);

        // Assert
        expect(failedMetrics.length, equals(1));
        expect(successMetrics.length, equals(1));
      });

      test('should clear metrics correctly', () async {
        // Arrange
        await monitor.trackJsonParsing('screen', () async => '{}');
        expect(monitor.getMetrics().length, equals(1));

        // Act
        monitor.clear();

        // Assert
        expect(monitor.getMetrics().length, equals(0));
      });

      test('should respect maximum metrics count', () async {
        // Arrange - Create more than max metrics
        final maxCount = PerformanceMonitor.maxMetricsCount;

        // Act - Create metrics beyond the limit
        for (var i = 0; i < maxCount + 10; i++) {
          await monitor.trackJsonParsing('screen_$i', () async => '{}');
        }

        // Assert - Should not exceed max count
        final metrics = monitor.getMetrics();
        expect(metrics.length, lessThanOrEqualTo(maxCount));
      });
    });

    group('Performance Benchmarks', () {
      test('JSON parsing should meet performance requirements', () async {
        // Arrange
        final testCases = [
          {'name': 'tiny', 'size': 10},
          {'name': 'small', 'size': 50},
          {'name': 'medium', 'size': 100},
          {'name': 'large', 'size': 500},
        ];

        // Act & Assert
        for (final testCase in testCases) {
          final json = {
            'type': 'column',
            'children': List.generate(
              testCase['size'] as int,
              (i) => {'type': 'text', 'data': 'Item $i'},
            ),
          };

          await monitor.trackJsonParsing(
            testCase['name'] as String,
            () async {
              final encoded = jsonEncode(json);
              jsonDecode(encoded);
              return encoded;
            },
          );
        }

        final stats = monitor.getStats(type: PerformanceMetricType.jsonParsing);
        
        // Performance requirements:
        // - Average parsing time should be under 50ms
        // - P95 should be under 100ms
        expect(stats.averageDuration, lessThan(50));
        expect(stats.p95Duration, lessThan(100));
      });

      test('widget rendering should maintain 60fps', () {
        // Arrange
        const targetFrameTime = 16; // 16ms for 60fps
        final widgets = List.generate(10, (i) => 'Widget$i');

        // Act
        for (final widget in widgets) {
          monitor.trackWidgetBuild(widget, () {
            // Simulate widget build
            var sum = 0;
            for (var i = 0; i < 1000; i++) {
              sum += i;
            }
            return sum;
          });
        }

        // Assert
        final stats = monitor.getStats(type: PerformanceMetricType.widgetBuild);
        
        // Most widgets should render within frame budget
        expect(stats.p95Duration, lessThan(targetFrameTime));
      });

      test('API calls should complete within acceptable time', () async {
        // Arrange
        final endpoints = [
          '/api/screen/home',
          '/api/screen/profile',
          '/api/config/theme',
        ];

        // Act
        for (final endpoint in endpoints) {
          await monitor.trackApiCall(endpoint, () async {
            await Future.delayed(const Duration(milliseconds: 200));
            return {'data': 'response'};
          });
        }

        // Assert
        final stats = monitor.getStats(type: PerformanceMetricType.apiCall);
        
        // API calls should generally complete within 1 second
        expect(stats.p95Duration, lessThan(1000));
      });
    });
  });
}
