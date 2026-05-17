import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  const FirebaseConfig._();

  static Future<void> initialize() async {
    if (Firebase.apps.isNotEmpty) {
      return;
    }
    await Firebase.initializeApp();
  }
}
