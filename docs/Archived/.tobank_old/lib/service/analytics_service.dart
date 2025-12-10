// import 'package:firebase_analytics/firebase_analytics.dart';

/// todo: add later to pwa

class AnalyticsService {
  // final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserProperties({required String? userId}) async {
    // await _analytics.setUserId(id: userId);
  }

  Future logLogin() async {
    // await _analytics.logLogin(loginMethod: 'mobile');
  }

  Future logLogout() async {
    // await _analytics.logEvent(name: 'logout');
  }

  Future logEvent({required String name, Map<String, Object>? parameters}) async {
    // await _analytics.logEvent(name: name, parameters: parameters);
  }
}
