import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/core/routes/initial_binding.dart';
import 'package:mobile_ics_flutter/core/routes/pages.dart';
import 'package:mobile_ics_flutter/core/theme/theme_config.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/views/home/home_screen.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  void _subscribeConnectivityChange() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
          // 'use_wifi'.tr.toast();
          'Đang kết nối Wifi'.toast();
          break;
        case ConnectivityResult.mobile:
          // 'use_mobile'.tr.toast();
          'Đang kết nối Mobile data'.toast();
          break;
        case ConnectivityResult.none:
          // 'disconnect_wifi'.tr.toast();
          'Mất kết nối Wifi'.toast();
          break;
        case ConnectivityResult.ethernet:
          // 'use_ethernet'.tr.toast();
          'Đang kết nối Ethernet'.toast();
          break;
        case ConnectivityResult.bluetooth:
          break;
      }
    });
  }

  GetMaterialApp _getMaterialApp() {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      initialRoute: '/home',
      initialBinding: InitialBinding(),
      navigatorObservers: [GetObserver(), FlutterSmartDialog.observer],
      defaultTransition: Transition.fade,
      opaqueRoute: true,
      popGesture: true,
      builder: (context, child) {
        return FlutterSmartDialog(
          child: OKToast(
              position: const ToastPosition(
                align: Alignment.bottomCenter,
                offset: -72.0,
              ),
              child: Scaffold(
                // Nhấn vào chỗ trống để tắt bàn phím điện thoại
                body: GestureDetector(
                  onTap: () {
                    hideKeyboard(context);
                    Constants.buildContext = context;
                  },
                  child: child,
                ),
              )),
        );
      },
      //Chang mặc định theme ở đây
      themeMode: ThemeMode.light,
      theme: ThemeConfig.lightThemeData.copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeConfig.darkThemeData.copyWith(),
      getPages: Pages.routes,
      home: const HomeScreen(),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterSmartDialog.init();
    //Kiểm tra kết nối mạng trên Android, IOS, nhưng skip trên Web
    if (Constants.isMobile()) {
      _subscribeConnectivityChange();
    }
    return _getMaterialApp();
  }
}
