import 'package:flutter_template/core/config/app_config.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenuecatConfig {
  const RevenuecatConfig._();

  static Future<void> initialize({required bool isAndroid}) async {
    final key = isAndroid
        ? AppConfig.revenuecatAndroidKey
        : AppConfig.revenuecatIosKey;
    if (key.isEmpty) return;
    await Purchases.configure(PurchasesConfiguration(key));
  }
}
