import 'package:mobile_ics_flutter/core/theme/theme_config.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/views/operator/components/component.dart';

class KImage {
  static Image imageMenu = Image.asset(
    'assets/icons/menu.png',
    color: ThemeConfig.lightBG,
    width: 30,
    height: 30,
    fit: BoxFit.fill,
  );

  static Image imageFilter = Image.asset(
    'assets/icons/menu.png',
    color: kBackgroundTitle,
    width: 30,
    height: 30,
    fit: BoxFit.fill,
  );

  static Image imageAvt = Image.asset(
    'assets/icons/avatar.png',
    color: ThemeConfig.lightBG,
    width: 68,
    height: 68,
    fit: BoxFit.fill,
  );

  static Image buttonBack = Image.asset(
    'assets/icons/button-back.png',
  );

  static Image imageNews = Image.asset(
    'assets/icons/newspaper.png',
  );

  static Image imageCalendar = Image.asset(
    'assets/icons/calendar.png',
  );
  static Image imageDevice = Image.asset(
    'assets/icons/device.png',
  );
  static Image imageWarning = Image.asset(
    'assets/icons/warning.png',
  );
  static Image imageBand = Image.asset(
    'assets/icons/bandwidth.png',
  );

  static const String imageWarningCard = 'assets/icons/icon-warning.png';
}
