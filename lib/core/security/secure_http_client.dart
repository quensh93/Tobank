import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../helpers/logger.dart';

/// Secure HTTP client configuration for API communication
///
/// Enforces HTTPS, adds security headers, and optionally implements certificate pinning.
class SecureHttpClient {
  /// Create a secure Dio instance with security configurations
  ///
  /// [baseUrl] - The base URL for API requests (must be HTTPS)
  /// [timeout] - Request timeout duration
  /// [headers] - Additional headers to include in requests
  /// [enableCertificatePinning] - Whether to enable certificate pinning
  /// [pinnedCertificates] - List of pinned certificate SHA-256 fingerprints
  static Dio createSecureClient({
    required String baseUrl,
    Duration timeout = const Duration(seconds: 30),
    Map<String, String> headers = const {},
    bool enableCertificatePinning = false,
    List<String> pinnedCertificates = const [],
  }) {
    // Enforce HTTPS
    if (!baseUrl.startsWith('https://')) {
      throw ArgumentError(
        'Base URL must use HTTPS protocol for secure communication. '
        'Received: $baseUrl',
      );
    }

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: timeout,
        headers: _buildSecurityHeaders(headers),
        validateStatus: (status) {
          // Accept all status codes to handle them in interceptors
          return status != null && status < 500;
        },
      ),
    );

    // Configure certificate pinning if enabled
    if (enableCertificatePinning && pinnedCertificates.isNotEmpty) {
      _configureCertificatePinning(dio, pinnedCertificates);
    } else {
      // Still enforce valid certificates even without pinning
      _enforceValidCertificates(dio);
    }

    return dio;
  }

  /// Build security headers for requests
  static Map<String, String> _buildSecurityHeaders(Map<String, String> customHeaders) {
    return {
      // Content type
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      
      // Security headers
      'X-Content-Type-Options': 'nosniff',
      'X-Frame-Options': 'DENY',
      'X-XSS-Protection': '1; mode=block',
      'Strict-Transport-Security': 'max-age=31536000; includeSubDomains',
      
      // API version
      'X-API-Version': '1.0',
      
      // Custom headers (can override defaults)
      ...customHeaders,
    };
  }

  /// Configure certificate pinning
  static void _configureCertificatePinning(
    Dio dio,
    List<String> pinnedCertificates,
  ) {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      
      // Configure certificate validation
      client.badCertificateCallback = (cert, host, port) {
        // Get certificate SHA-256 fingerprint
        final certFingerprint = _getCertificateFingerprint(cert);
        
        // Check if certificate matches any pinned certificates
        final isValid = pinnedCertificates.contains(certFingerprint);
        
        if (!isValid) {
          // Log certificate pinning failure
          AppLogger.e('❌ Certificate pinning failed for $host:$port');
          AppLogger.e('   Expected one of: ${pinnedCertificates.join(", ")}');
          AppLogger.e('   Received: $certFingerprint');
        }
        
        return isValid;
      };
      
      return client;
    };
  }

  /// Enforce valid certificates without pinning
  static void _enforceValidCertificates(Dio dio) {
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      
      // Reject all invalid certificates
      client.badCertificateCallback = (cert, host, port) {
        AppLogger.e('❌ Invalid certificate for $host:$port');
        return false;
      };
      
      return client;
    };
  }

  /// Get SHA-256 fingerprint of certificate
  static String _getCertificateFingerprint(X509Certificate cert) {
    // Convert DER bytes to hex string
    final derBytes = cert.der;
    return derBytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join(':')
        .toUpperCase();
  }

  /// Validate URL is HTTPS
  static bool isSecureUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.scheme == 'https';
    } catch (e) {
      return false;
    }
  }

  /// Add security interceptor to Dio instance
  static void addSecurityInterceptor(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Validate URL is HTTPS
          if (!isSecureUrl(options.uri.toString())) {
            return handler.reject(
              DioException(
                requestOptions: options,
                error: 'Insecure URL detected: ${options.uri}. Only HTTPS is allowed.',
                type: DioExceptionType.badResponse,
              ),
            );
          }
          
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Validate response headers for security
          _validateResponseHeaders(response);
          return handler.next(response);
        },
        onError: (error, handler) {
          // Log security-related errors
          if (error.type == DioExceptionType.badCertificate) {
            AppLogger.e('❌ SSL/TLS Error: ${error.message}');
          }
          return handler.next(error);
        },
      ),
    );
  }

  /// Validate response headers for security issues
  static void _validateResponseHeaders(Response response) {
    final headers = response.headers;
    
    // Check for security headers
    final warnings = <String>[];
    
    if (!headers.map.containsKey('strict-transport-security')) {
      warnings.add('Missing Strict-Transport-Security header');
    }
    
    if (!headers.map.containsKey('x-content-type-options')) {
      warnings.add('Missing X-Content-Type-Options header');
    }
    
    if (!headers.map.containsKey('x-frame-options')) {
      warnings.add('Missing X-Frame-Options header');
    }
    
    if (warnings.isNotEmpty) {
      AppLogger.w('⚠️ Security warnings for ${response.requestOptions.uri}:');
      for (final warning in warnings) {
        AppLogger.w('   - $warning');
      }
    }
  }
}
