import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_recorder/Features/Meta%20Data/meta_data_controller.dart';
import 'package:video_recorder/common/widgets/app_logo.dart';
import 'package:video_recorder/common/widgets/custom_button.dart';
import 'package:video_recorder/common/widgets/custom_textfield.dart';

class MetaDataScreen extends StatefulWidget {
  final String filePath;
  const MetaDataScreen({
    super.key,
    required this.filePath,
  });

  @override
  State<MetaDataScreen> createState() => _MetaDataScreenState();
}

class _MetaDataScreenState extends State<MetaDataScreen> {
  final MetaDataController controller = Get.put(MetaDataController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getCurrentPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Details'),
      ),
      body: GetBuilder<MetaDataController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const AppLogo(
                      height: 80,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    XCustomTextFields(
                      controller: controller.videoTitleController,
                      outlineBorderType: true,
                      hintText: 'Video title here',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    XCustomTextFields(
                      controller: controller.videoDescriptionController,
                      outlineBorderType: true,
                      hintText: 'Video description here',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    XCustomTextFields(
                      controller: controller.videoCategoryController,
                      outlineBorderType: true,
                      hintText: 'Video category here',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    XCustomTextFields(
                      controller: controller.videoLocationController,
                      outlineBorderType: true,
                      hintText: 'Video location here',
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Obx(
                      () => CustomButton(
                        containLoading: controller.isUploading.value,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.uploadVideo(widget.filePath);
                          }
                        },
                        btnText: 'Save Video',
                        customHeight: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
