import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_recorder/Features/Video/controllers/video_controller.dart';
import 'package:video_recorder/utils/constants/colors.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.initCamera();
  }

  final controller = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: XColors.blackBackgroundColor,
      appBar: AppBar(),
      body: GetBuilder<VideoController>(
        builder: (controller) {
          return Obx(() {
            if (controller.isLoading.value) {
              return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return GestureDetector(
                onDoubleTap: () {
                  if (controller.cameraDirection.value ==
                      CameraLensDirection.front) {
                    controller.cameraDirection.value = CameraLensDirection.back;
                  } else {
                    controller.cameraDirection.value =
                        CameraLensDirection.front;
                  }
                  controller.initCamera();
                },
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CameraPreview(controller.cameraController),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          child: Icon(controller.isRecording.value
                              ? Icons.stop
                              : Icons.circle),
                          onPressed: () => controller.recordVideo(mounted),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          });
        },
      ),
    );
  }
}
