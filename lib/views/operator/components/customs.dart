//custom container
import 'package:flutter/material.dart';
import 'package:mobile_ics_flutter/views/operator/components/op_constant.dart';
import 'package:mobile_ics_flutter/views/operator/components/texts.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final Widget child;
  final double marginVertical;
  final double marginHorizontal;
  final double paddingVertical;
  final double paddingHorizontal;

  const CustomContainer(
      {super.key,
      this.height,
      this.marginVertical = 0,
      this.marginHorizontal = 0,
      this.paddingVertical = 0,
      this.paddingHorizontal = 0,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: paddingVertical, horizontal: paddingHorizontal),
      width: MediaQuery.of(context).size.width,
      height: height,
      margin: EdgeInsets.symmetric(
          vertical: marginVertical, horizontal: marginHorizontal),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        color: kWhite,
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
//custom container

//custom text button

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.icon,
    required this.onpress,
    this.background,
  });
  final String text;
  final IconData? icon;
  final Function onpress;
  final bool? background;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(kLightGrey),
        foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            side: const BorderSide(color: kWhite),
          ),
        ),
      ),
      onPressed: () {
        onpress();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: icon == null ? 0 : defaultIconSize,
            height: icon == null ? 0 : defaultIconSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              color: (background == null)
                  ? Colors.white.withOpacity(.0)
                  : primaryColor,
            ),
            child: Icon(
              icon,
              size: (icon == null)
                  ? 0
                  : (background == null
                      ? defaultIconSize
                      : defaultIconSize - 7),
              color: background == null ? primaryColor : kWhite,
            ),
          ),
          SizedBox(
            width: (icon == null) ? 0 : defaultPadding,
          ),
          textStyle1(
            text: text,
          )
        ],
      ),
    );
  }
}

//custom text button 1

class CustomButton1 extends StatelessWidget {
  const CustomButton1(
      {super.key,
      required this.text,
      this.icon,
      this.space,
      this.padding,
      this.background});
  final String text;
  final IconData? icon;
  final double? space;
  final double? padding;
  final bool? background;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: const Color(0xffededed),
          border: Border.all(color: const Color(0xff000000).withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(4, 4), // changes position of shadow
            ),
          ],
        ),
        child: TextButton(
          onPressed: () {
            // ignore: avoid_print
            print('Custom TextButton 1');
          },
          child: Row(
            children: [
              SizedBox(
                width: (padding != null) ? padding : defaultPadding,
              ),
              Container(
                width: defaultIconSize,
                height: defaultIconSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  color: (background == null) ? null : primaryColor,
                ),
                child: Icon(
                  icon,
                  size: background == null
                      ? defaultIconSize
                      : defaultIconSize - 7,
                  color: background == null ? primaryColor : Colors.white,
                ),
              ),
              SizedBox(
                width: (space != null) ? space : defaultPadding,
              ),
              textStyle1(text: text),
              SizedBox(
                width: (padding != null) ? padding : defaultPadding,
              ),
            ],
          ),
        ));
  }
}
