import 'package:auto_route/auto_route.dart';
import 'package:farm_system/feature/splash/splash.dart';
import 'package:farm_system/routes/router.gr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:device_preview/device_preview.dart';

void main() {
  runApp(ProviderScope(child: FarmSystem()));

  if (defaultTargetPlatform == TargetPlatform.android) {
    // InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
    InAppPurchaseConnection.enablePendingPurchases();
    //InAppPurchaseConnection.enablePendingPurchase;
  }
  // runApp(FarmSystem());
}
// void main() => runApp(DevicePreview(
//       builder: (context) => FarmSystem(),
//     ));

class FarmSystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        builder: ExtendedNavigator.builder(router: Router()),
        home: SplashScreen());
  }
}
