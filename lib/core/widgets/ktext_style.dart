import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/core/theme/theme_config.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'kcolors.dart';

class KTextStyle {
  //default font weight
  static const FontWeight kExtraLight = FontWeight.w100;
  static const FontWeight kLight = FontWeight.w300;
  static const FontWeight kRegular = FontWeight.w400;
  static const FontWeight kSemiBold = FontWeight.w600;
  static const FontWeight kBold = FontWeight.w700;
  static const FontWeight kBlack = FontWeight.w900;

  //Charts
  static const charts.TextStyleSpec textInsideLabelStyleSpec =
      charts.TextStyleSpec(
          color: charts.Color.white,
          fontSize: 13,
          fontWeight: 'w500',
          fontFamily: 'SourceSansPro');

  static charts.TextStyleSpec textOutsideLabelStyleSpec = charts.TextStyleSpec(
      color: charts.ColorUtil.fromDartColor(kBackgroundTitle),
      fontSize: 13,
      fontWeight: 'w500',
      fontFamily: 'SourceSansPro');

  static charts.TextStyleSpec textChartsLabelStyle = charts.TextStyleSpec(
      fontSize: 13, // size in Pts.
      color: charts.ColorUtil.fromDartColor(
        kBorButtonNews,
      ));

  static charts.TextStyleSpec textChartsLabelStyle1 = charts.TextStyleSpec(
      fontSize: 13, // size in Pts.
      color: charts.ColorUtil.fromDartColor(
        kBackgroundTitle,
      ));

  static const TextStyle textPieLabelStyle =
      TextStyle(fontSize: 15, fontWeight: kRegular, color: kBorButtonNews);

  static TextStyle textPieLabelBandStyle =
      textPieLabelStyle.copyWith(fontSize: 12, color: kBackgroundTitle);

  static TextStyle textPieLabelBandTitleStyle =
      textPieLabelStyle.copyWith(fontSize: 13, color: kTextBand);

  //Page

  static const TextStyle textDefaultStyle = TextStyle(
      fontSize: 17,
      color: kBackgroundTitle,
      fontWeight: kRegular,
      overflow: TextOverflow.ellipsis);

  static TextStyle textButtonStyle =
      textDefaultStyle.copyWith(fontWeight: kSemiBold);

  static TextStyle textButtonStyle1 = textDefaultStyle.copyWith(
      fontWeight: kSemiBold, color: ThemeConfig.lightBG);

  static TextStyle textButtonCBXStyle =
      textDefaultStyle.copyWith(fontWeight: kSemiBold, fontSize: 16);

  static TextStyle textButtonFitterStyle = textDefaultStyle.copyWith(
      fontWeight: kSemiBold, fontSize: 16, color: ThemeConfig.lightBG);

  static TextStyle textRadioButtonStyle = textDefaultStyle.copyWith(
      fontWeight: kBold, fontSize: 14, color: kBorButtonNews);

  static TextStyle textButtonTitleStyle = textDefaultStyle.copyWith(
      fontWeight: kRegular, fontSize: 16, color: kTitleButtonColor);

  static const TextStyle textTitleMainStyle = TextStyle(
      color: ThemeConfig.lightBG,
      fontSize: 34,
      fontWeight: kRegular,
      overflow: TextOverflow.ellipsis);

  static TextStyle textTitlePageStyle =
      textTitleMainStyle.copyWith(color: kBackgroundTitle);

  static const TextStyle textSubTitleStyle = TextStyle(
      color: kSubTitleMainColor,
      fontSize: 16,
      fontWeight: kRegular,
      overflow: TextOverflow.ellipsis);

  static TextStyle textTitleFilterStyle =
      textSubTitleStyle.copyWith(color: kBorButtonNews);

  static TextStyle textLegendStyle = textSubTitleStyle.copyWith(fontSize: 15);

  static const TextStyle textSubTagStyle = TextStyle(
      color: kTextTag,
      fontSize: 13,
      fontWeight: kRegular,
      overflow: TextOverflow.ellipsis);

  static const TextStyle textAmountStyle = TextStyle(
      color: kBackgroundTitle,
      fontSize: 30,
      fontWeight: kRegular,
      overflow: TextOverflow.ellipsis);

  static TextStyle textAmountSubStyle = textAmountStyle.copyWith(fontSize: 20);

  //Time line
  static const TextStyle textTimeLineTimeStyle = TextStyle(
      fontWeight: kBold,
      fontSize: 15,
      color: kBackgroundTitle,
      overflow: TextOverflow.ellipsis);

  static TextStyle textTimeLineTitleStyle =
      textTimeLineTimeStyle.copyWith(fontWeight: kRegular, color: kTextBand);

  static TextStyle textTimeLineTitle1Style = textTimeLineTimeStyle.copyWith(
      fontWeight: kRegular, color: kBackgroundTitle);
}
