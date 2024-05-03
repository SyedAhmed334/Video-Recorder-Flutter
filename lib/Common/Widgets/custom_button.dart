import 'package:flutter/material.dart';
import 'package:video_recorder/utils/constants/colors.dart';
import 'package:video_recorder/utils/themes/text_theme.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.onTap,
      this.customHeight = 45,
      this.customWidth,
      this.btnText,
      this.btnColor,
      this.showButton = false,
      this.btnTextStyle,
      this.borderColor = false,
      this.borderRadius,
      this.borderAssignColor,
      this.containLoading = false});

  GestureTapCallback? onTap;
  double? customHeight;
  double? customWidth;
  String? btnText;
  bool containLoading;
  bool? showButton = false;
  Color? btnColor;
  TextStyle? btnTextStyle;
  bool? borderColor = false;
  Color? borderAssignColor;
  double? borderRadius;
  @override
  Widget build(BuildContext context) {
    double widths = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: customHeight ?? 18,
        width: customWidth ?? widths / 1.2,
        decoration: borderAssignColor == null
            ? BoxDecoration(
                color: btnColor ?? XColors.primaryColor,
                border: Border.all(
                  color: borderColor == true
                      ? XColors.primaryColor
                      : Colors.transparent,
                  width: 1.9,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 12),
              )
            : BoxDecoration(
                color: btnColor ?? XColors.primaryColor,
                border: Border.all(
                  color: borderAssignColor ?? XColors.primaryColor,
                  width: 1.9,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
              ),
        child: Center(
          child: containLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  btnText ??
                      "                                                                                                                                                                                                                                                                                                                     ",
                  style: btnTextStyle ??
                      XTextThemes.lightTextTheme.titleMedium!.copyWith(
                        color: XColors.whiteColor,
                      ),
                ),
        ),
      ),
    );
  }
}
