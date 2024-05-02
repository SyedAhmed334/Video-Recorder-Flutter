import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_recorder/common/widgets/app_logo.dart';
import 'package:video_recorder/common/widgets/custom_button.dart';
import 'package:video_recorder/common/widgets/custom_textfield.dart';
import 'package:video_recorder/Features/Authentication/controllers/phone_auth_controller.dart';
import 'package:video_recorder/utils/themes/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(PhoneAuthController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PhoneAuthController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
            child: Form(
              key: _formKey,
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
                    'Enter your phone number to login',
                    style: XTheme.lightTheme.textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  XCustomTextFields(
                    controller: controller.phoneNumberController,
                    outlineBorderType: true,
                    focusNode: controller.focusNode,
                    validationError: 'enter you phone number',
                    isNumber: true,
                    hintText: 'e.g +923XXXXXXXXXX',
                    onChange: (value) {
                      controller.phoneNumberController.text = value;
                    },
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Obx(
                    () => CustomButton(
                      onTap: () async {
                        controller.focusNode.unfocus();
                        if (_formKey.currentState!.validate()) {
                          await controller.verifyPhoneNumber();
                        }
                      },
                      btnText: 'Next',
                      containLoading: controller.isLoading.value,
                      customHeight: 50,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
