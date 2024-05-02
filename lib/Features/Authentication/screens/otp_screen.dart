import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:video_recorder/common/widgets/app_logo.dart';
import 'package:video_recorder/common/widgets/custom_button.dart';
import 'package:video_recorder/Features/Authentication/controllers/otp_controller.dart';
import 'package:video_recorder/utils/constants/colors.dart';
import 'package:video_recorder/utils/helpers/helper_functions.dart';
import 'package:video_recorder/utils/themes/otp_pin_theme.dart';
import 'package:video_recorder/utils/themes/text_theme.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  final int? resendToken;
  final String phoneNumber;
  const OTPScreen(
      {super.key,
      required this.verificationId,
      this.resendToken,
      required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final controller = Get.put(OTPController());
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.pinController.dispose();
    controller.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<OTPController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  'Verification Code',
                  style: XTextThemes.lightTextTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Enter your verification code below that we\'ve sent you via sms',
                  style: XTextThemes.lightTextTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Pinput(
                      defaultPinTheme: XOtpPinTheme.defaultPinTheme,
                      focusedPinTheme: XOtpPinTheme.focusedPinTheme,
                      submittedPinTheme: XOtpPinTheme.submittedPinTheme,
                      errorPinTheme: XOtpPinTheme.errorPinTheme,
                      length: 6,
                      controller: controller.pinController,
                      focusNode: controller.focusNode,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      listenForMultipleSmsOnAndroid: true,
                      showCursor: true,
                      onCompleted: (pin) {
                        log('$pin ${controller.pinController.text}');
                      }),
                ),
                const SizedBox(
                  height: 60,
                ),
                CustomButton(
                  onTap: () async {
                    controller.focusNode.unfocus();
                    if (formKey.currentState!.validate()) {
                      log(widget.verificationId);
                      await controller.verifyOtp(widget.verificationId);
                    }
                  },
                  containLoading: controller.isLoading.value,
                  btnText: 'Verify',
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Didn\'t you recieve any code?',
                      style: XTextThemes.lightTextTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () async {
                        await controller.resendOTP(phone: widget.phoneNumber);
                        XHelperFunctions.showToastMessage(
                            message: '6-digit OTP has been to your number');
                      },
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.all(0))),
                      child: Text(
                        'Resend',
                        style: XTextThemes.lightTextTheme.titleLarge!
                            .copyWith(color: XColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
