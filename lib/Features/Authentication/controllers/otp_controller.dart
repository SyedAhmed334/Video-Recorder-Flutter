import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_recorder/Features/Video/screens/videos_list_screen.dart';
import 'package:video_recorder/utils/helpers/helper_functions.dart';

class OTPController extends GetxController {
  final pinController = TextEditingController();
  Rx<bool> isLoading = false.obs;
  final focusNode = FocusNode();

  Future<void> verifyOtp(String verificationId) async {
    try {
      isLoading.value = true;
      PhoneAuthCredential credentials = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: pinController.text.toString());
      log('$pinController.text');
      await FirebaseAuth.instance
          .signInWithCredential(credentials)
          .then((value) {
        isLoading.value = false;
        XHelperFunctions.showToastMessage(message: 'Login Successful');
        Get.offAll(() => const VideoListScreen());
      });
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> resendOTP({required String phone}) async {
    String verificationid = '';
    int? resendCode;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        verificationid = verificationId;
        resendCode = resendToken;
      },
      timeout: const Duration(seconds: 25),
      forceResendingToken: resendCode,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationid;
      },
    );
    log("_verificationId: $verificationid");
  }
}
