import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_ics_flutter/core/lang/translation_service.dart';
import 'package:mobile_ics_flutter/core/routes/initial_binding.dart';
import 'package:mobile_ics_flutter/core/routes/pages.dart';
import 'package:mobile_ics_flutter/core/services/boxes_service.dart';
import 'package:mobile_ics_flutter/core/theme/theme_config.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
import 'package:mobile_ics_flutter/views/home/home_screen.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter('${appDocDir.path}/mobile_ics_db');
  // ignore: avoid_print
  print('${appDocDir.path}/mobile_ics_db');

  // ignore: avoid_print
  print(TranslationService.locale);

  Hive.registerAdapter(NewsHiveModelAdapter());
  Hive.registerAdapter(WarningHiveModelAdapter());
  Hive.registerAdapter(DeviceHiveModelAdapter()); // đăng ký adapter
  await BoxesService().openBox(); // mở box

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
          'USE_WIFI'.tr.toast();
          break;
        case ConnectivityResult.mobile:
          'USE_MOBILE'.tr.toast();
          break;
        case ConnectivityResult.none:
          'DISCONNECT'.tr.toast();
          break;
        case ConnectivityResult.ethernet:
          'USE_ETHERNET'.tr.toast();
          break;
        case ConnectivityResult.bluetooth:
          break;
      }
    });
  }

  GetMaterialApp _getMaterialApp() {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TITLE_APP'.tr,
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
      locale: const Locale('vi', 'VN'),
      fallbackLocale: const Locale('en', 'US'),
      translations: TranslationService(),
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
