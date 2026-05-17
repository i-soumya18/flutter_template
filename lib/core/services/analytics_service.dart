import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  const AnalyticsService._();

  static Future<void> logEvent(
    String name, {
    Map<String, Object>? params,
  }) async {
    await FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: params,
    );
  }
}
