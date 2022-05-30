import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/core/routes/initial_binding.dart';
import 'package:mobile_ics_flutter/core/routes/pages.dart';
import 'package:mobile_ics_flutter/core/theme/theme_config.dart';
import 'package:mobile_ics_flutter/views/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  GetMaterialApp _getMaterialApp() {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      initialRoute: '/',
      initialBinding: InitialBinding(),
      builder: (context, child) => Scaffold(
        body: child,
      ),
      themeMode: ThemeMode.light,
      theme: ThemeConfig.lightThemeData.copyWith(),
      darkTheme: ThemeConfig.darkThemeData.copyWith(),
      scrollBehavior: MyCustomScrollBehavior(),
      getPages: Pages.routes,
      home: const HomeScreen(),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _getMaterialApp();
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
