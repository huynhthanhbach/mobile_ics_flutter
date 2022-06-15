import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';

class HistoryContentCard extends StatelessWidget {
  const HistoryContentCard({
    Key? key,
    this.imageIcon = 'assets/icons/icon-news.png',
    this.titleName = "Bản tin thời sự đài truyền hình Việt Nam",
    this.titleType = "Loại: Bản tin thời sự",
    this.titleTime = "Thời gian: 00:00 - 31/12/2022",
    this.titleColor = kBackgroundTitle,
    this.isTag = true,
    this.statusCode = 0, // 0: Chưa phát, 1: Đang phát, 2: Đã phát
  }) : super(key: key);

  final String imageIcon;
  final String titleName;
  final String titleType;
  final String titleTime;
  final Color titleColor;
  final bool isTag;
  final int statusCode;

  @override
  Widget build(BuildContext context) {
    String? textTag;
    Color? backgroundTag, colorTextTag;

    switch (statusCode) {
      case 1:
        textTag = "Đang phát";
        backgroundTag = kBackgroundTitle;
        colorTextTag = Colors.white;
        break;
      case 2:
        textTag = "Chưa phát";
        backgroundTag = kBackgroundTag;
        colorTextTag = kTextTag;
        break;
      default:
        textTag = "Đã phát";
        backgroundTag = kBackgroundTag2;
        colorTextTag = const Color(0xFF000000).withOpacity(.5);
    }

    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(
        horizontal: Constants.dkp * .25,
        vertical: Constants.dkp * .25,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.dkp * .25,
        vertical: Constants.dkp * .25,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(4, 4),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF000000).withOpacity(.1),
          width: .5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 45,
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.dkp * .25,
              vertical: Constants.dkp * .25,
            ),
            child: ClipRRect(
              child: Image.asset(
                imageIcon,
                width: 25,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: titleName,
                  size: 12,
                  tColor: titleColor,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: Constants.kSemiBold,
                ),
                KText(
                  text: titleType,
                  size: 12,
                  tColor: titleColor.withOpacity(.8),
                  overflow: TextOverflow.ellipsis,
                  fontWeight: Constants.kRegular,
                ),
                KText(
                  text: titleTime,
                  size: 12,
                  tColor: kTitleButtonColor,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: Constants.kRegular,
                ),
              ],
            ),
          ),
          (isTag)
              ? SizedBox(
                  width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: backgroundTag,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: KText(
                          text: textTag,
                          size: 12,
                          tColor: colorTextTag,
                          fontWeight: Constants.kRegular,
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
