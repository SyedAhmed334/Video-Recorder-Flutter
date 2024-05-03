import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_recorder/Features/Authentication/screens/otp_screen.dart';
import 'package:video_recorder/utils/helpers/helper_functions.dart';

class PhoneAuthController extends GetxController {
  final phoneNumberController = TextEditingController();
  final focusNode = FocusNode();
  Rx<bool> isLoading = false.obs;

  Future<void> verifyPhoneNumber() async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credentials) {
          isLoading.value = false;
          log(credentials.smsCode!);
        },
        verificationFailed: (FirebaseAuthException exception) {
          isLoading.value = false;
          XHelperFunctions.showToastMessage(message: exception.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          isLoading.value = false;
          isLoading.value = false;
          Get.to(() => OTPScreen(
                verificationId: verificationId,
                resendToken: resendToken,
                phoneNumber: phoneNumberController.text.toString(),
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          isLoading.value = false;
          // XHelperFunctions.showToastMessage(message: 'Request Timeout!');
        },
        phoneNumber: phoneNumberController.text.toString(),
      );
    } catch (e) {
      XHelperFunctions.showToastMessage(message: e.toString());
    }
  }
}
