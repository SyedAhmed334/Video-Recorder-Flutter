// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_recorder/utils/constants/colors.dart';
import 'package:video_recorder/utils/themes/text_theme.dart';

class XCustomTextFields extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  dynamic getController;
  XCustomTextFields(
      {super.key,
      this.hintText,
      this.obscureText = false,
      this.suffix,
      required this.controller,
      this.borderColor = true,
      this.focus = false,
      this.maxLines = 1,
      this.prefixIcons,
      this.onlyRead = true,
      this.validationError,
      this.isConfirmPassword = false,
      this.isEmail = false,
      this.isDigit = false,
      this.isPassword = false,
      this.align = TextAlign.start,
      this.radiusCircle = 3,
      this.fillColor,
      this.textInputType = TextInputType.text,
      this.borderAssignColor,
      this.hintStyle,
      this.borderWidth,
      this.decoration,
      this.suffixContentPadding,
      this.onFieldSubmitted,
      this.numberInputFormatter = false,
      this.cursorColor,
      this.contentPad = true,
      this.textCustomStyle,
      this.getController,
      this.enable = true,
      this.borderCheck = true,
      this.onDone,
      this.unfocusOnTapOutside = false,
      this.containerHeight,
      this.radius,
      this.outlineBorderType = true,
      this.minLimit = 0,
      this.maxLength,
      this.isName = false,
      this.isUserName = false,
      this.isNumber = false,
      this.focusNode,
      this.onChange});
  FocusNode? focusNode;
  String? hintText;
  Widget? suffix;
  int minLimit = 0;
  bool? obscureText = false;
  bool? focus = false;
  ValueChanged<String>? onFieldSubmitted;
  bool numberInputFormatter;
  bool? borderColor = true;
  int? maxLines;
  Widget? prefixIcons;
  BoxDecoration? decoration;
  bool? onlyRead;
  TextInputType? textInputType;
  String? validationError;
  bool? isConfirmPassword = false;
  bool? isEmail = false;
  bool? isDigit = false;
  bool? isPassword = false;
  bool? enable = true;
  double? radiusCircle = 3;
  Color? fillColor;
  EdgeInsets? suffixContentPadding;
  Color? borderAssignColor;
  Color? cursorColor;
  TextStyle? hintStyle;
  TextStyle? textCustomStyle;
  TextAlign align = TextAlign.start;
  bool contentPad = true;
  VoidCallback? onDone;
  bool? unfocusOnTapOutside;
  Function(String)? onChange;
  bool borderCheck = true;
  double? containerHeight;
  double? radius = 12;
  bool outlineBorderType = true;
  bool isName = false;
  bool isUserName = false;
  bool isNumber = false;
  // ignore: prefer_typing_uninitialized_variables
  double? borderWidth;
  int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      onSaved: (c) {},
      onEditingComplete: onDone ?? () {},
      onTapOutside: (val) {
        if (unfocusOnTapOutside == true) {
          FocusScope.of(context).unfocus();
        }
      },
      onChanged: onChange,
      enabled: enable,
      textAlign: align,
      focusNode: focusNode,
      cursorColor: cursorColor ?? XColors.textColor,
      autofocus: focus!,
      style: textCustomStyle ?? XTextThemes.lightTextTheme.bodyMedium,
      controller: controller,
      keyboardType: textInputType,
      onFieldSubmitted: onFieldSubmitted,
      maxLength: maxLength,
      maxLengthEnforcement:
          maxLength != null ? MaxLengthEnforcement.enforced : null,
      decoration: outlineBorderType
          ? InputDecoration(
              filled: true,
              fillColor: fillColor ?? Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: borderColor == true
                        ? XColors.greyColor
                        : XColors.whiteColor),
                borderRadius: BorderRadius.circular(radius ?? 14),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: borderColor == true
                        ? XColors.greyColor
                        : XColors.whiteColor),
                borderRadius: BorderRadius.circular(radius ?? 14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: borderColor == true
                        ? XColors.textColor
                        : XColors.whiteColor),
                borderRadius: BorderRadius.circular(radius ?? 14),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: borderColor == true
                        ? XColors.greyColor
                        : XColors.whiteColor),
                borderRadius: BorderRadius.circular(radius ?? 14),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: borderColor == true
                        ? XColors.greyColor
                        : XColors.whiteColor),
                borderRadius: BorderRadius.circular(radius ?? 14),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: borderColor == true
                        ? XColors.redColor
                        : XColors.whiteColor),
                borderRadius: BorderRadius.circular(radius ?? 14),
              ),
              contentPadding: EdgeInsets.only(
                  left: contentPad ? 16 : 08, top: 08, bottom: 08, right: 16),
              hintText: hintText,
              hintStyle: hintStyle ??
                  XTextThemes.lightTextTheme.bodyMedium!.copyWith(
                      fontStyle: FontStyle.italic,
                      color: XColors.hintTextColor),
              errorStyle: XTextThemes.lightTextTheme.bodySmall!
                  .copyWith(color: XColors.redColor, fontSize: 10),
              helperStyle: XTextThemes.lightTextTheme.bodyLarge,
              suffixIcon: suffix,
              prefixIcon: prefixIcons,
            )
          : InputDecoration(
              fillColor: fillColor ?? XColors.whiteColor,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: XColors.textColor)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: XColors.textColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: XColors.textColor)),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: XColors.textColor)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: XColors.textColor)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: XColors.textColor)),
              contentPadding: suffixContentPadding ??
                  (suffix == null
                      ? EdgeInsets.only(
                          left: contentPad ? 0 : 08,
                        )
                      : const EdgeInsets.only(
                          left: 12,
                          top: 12,
                        )),
              hintText: hintText,
              hintStyle: hintStyle ??
                  XTextThemes.lightTextTheme.bodyMedium!.copyWith(
                      fontStyle: FontStyle.italic,
                      color: XColors.hintTextColor),
              errorStyle: XTextThemes.lightTextTheme.bodySmall!
                  .copyWith(color: XColors.redColor, fontSize: 10),
              helperStyle: XTextThemes.lightTextTheme.bodyMedium!.copyWith(
                  fontStyle: FontStyle.italic, color: XColors.hintTextColor),
              suffixIcon: suffix,
              prefixIcon: prefixIcons,
            ),
      readOnly: !onlyRead!,
      maxLines: maxLines,
      minLines: 1,
      obscureText: obscureText!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please $validationError';
        } else if (value.length < minLimit) {
          return 'Please enter at least $minLimit characters';
        } else if (isConfirmPassword == true) {
          if (getController.passwordController.text ==
              getController.retypePasswordController.text) {
            return null;
          } else {
            return "Confirm password doesn't match with password";
          }
        } else if (isName == true) {
          return validateName(value);
        } else if (isUserName == true) {
          return validateUsername(value);
        } else if (isNumber == true) {
          return validateNumber(value);
        } else if (isPassword == true) {
          return validatePassword(value);
        } else {
          if (isEmail == true) {
            return validateEmail(value);
          } else {
            return null;
          }
        }
      },
    );
  }

  validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Enter a valid email address";
    } else {
      return null;
    }
  }

  validateNumber(String value) {
    // Regular expression pattern for validating phone numbers
// final RegExp phoneRegex = ;

// // Validate phone number format
// bool isValidPhoneNumber(String phoneNumber) {
//   return phoneRegex.hasMatch(phoneNumber);
// }

// // Example usage:
// String phoneNumber = '+1234567890'; // Replace with user input
// if (isValidPhoneNumber(phoneNumber)) {
//   // Phone number is valid, proceed with authentication
// } else {
//   // Invalid phone number format, display error message to the user
// }

    RegExp rex = RegExp(r'^\+\d{1,3}\d{3,14}$');
    if (!rex.hasMatch(value)) {
      return "Please enter a valid phone";
    } else {
      return null;
    }
  }

  //A function that validate user entered password
  validateUsername(String value) {
    String pattern = r'^(?=.*\d)[a-zA-Z0-9]{4,16}$';
    RegExp rex = RegExp(pattern);

    String userName = value.trim();
    if (!rex.hasMatch(userName)) {
      return "Must contain alphabet and a digit or underscore";
    } else {
      return null;
    }
  } //A function that validate user entered password

  validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}';
    RegExp rex = RegExp(pattern);

    String password = value.trim();
    if (!rex.hasMatch(password)) {
      return "Must contain one digit, uppercase or lowercase and\none special character";
    } else {
      return null;
    }
  }

  validateName(String value) {
    String pattern = r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";
    RegExp rex = RegExp(pattern);
    if (!rex.hasMatch(value)) {
      return "Enter a valid name. e.g:'John wick'";
    } else {
      return null;
    }
  }
}
