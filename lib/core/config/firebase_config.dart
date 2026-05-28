import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_template/core/config/app_config.dart';

class FirebaseConfig {
  const FirebaseConfig._();

  static Future<void> initialize() async {
    if (!AppConfig.hasFirebaseConfig) {
      return;
    }

    if (Firebase.apps.isNotEmpty) {
      return;
    }

    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: AppConfig.firebaseApiKey,
        appId: AppConfig.firebaseAppId,
        messagingSenderId: AppConfig.firebaseMessagingSenderId,
        projectId: AppConfig.firebaseProjectId,
        storageBucket: AppConfig.firebaseStorageBucket,
      ),
    );
  }
}
