import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  const AppConfig._();

  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  static String get revenuecatAndroidKey =>
      dotenv.env['REVENUECAT_PUBLIC_KEY_ANDROID'] ?? '';
  static String get revenuecatIosKey =>
      dotenv.env['REVENUECAT_PUBLIC_KEY_IOS'] ?? '';
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
}
