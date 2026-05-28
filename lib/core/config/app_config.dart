import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  const AppConfig._();

  static Map<String, String> get _env =>
      dotenv.isInitialized ? dotenv.env : const {};

  static String get environment => _env['ENVIRONMENT'] ?? 'development';
  static String get apiBaseUrl => _env['API_BASE_URL'] ?? '';
  static String get firebaseProjectId =>
      _env['FIREBASE_PROJECT_ID']?.trim() ?? '';
  static String get firebaseApiKey => _env['FIREBASE_API_KEY']?.trim() ?? '';
  static String get firebaseAppId => _env['FIREBASE_APP_ID']?.trim() ?? '';
  static String get firebaseMessagingSenderId =>
      _env['FIREBASE_MESSAGING_SENDER_ID']?.trim() ?? '';
  static String get firebaseStorageBucket =>
      _env['FIREBASE_STORAGE_BUCKET']?.trim() ?? '';
  static bool get hasFirebaseConfig =>
      firebaseProjectId.isNotEmpty &&
      firebaseApiKey.isNotEmpty &&
      firebaseAppId.isNotEmpty &&
      firebaseMessagingSenderId.isNotEmpty;
  static String get revenuecatAndroidKey =>
      _env['REVENUECAT_PUBLIC_KEY_ANDROID'] ?? '';
  static String get revenuecatIosKey => _env['REVENUECAT_PUBLIC_KEY_IOS'] ?? '';
  static String get supabaseUrl => _env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => _env['SUPABASE_ANON_KEY'] ?? '';
}
