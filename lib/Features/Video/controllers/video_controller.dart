import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:video_recorder/Features/Video/screens/video_recording_screen.dart';

class VideoController extends GetxController {
  RxBool isLoading = true.obs;
  late CameraController cameraController;
  RxBool isRecording = false.obs;
  Rx<CameraLensDirection> cameraDirection = CameraLensDirection.front.obs;
  initCamera() async {
    final cameras = await availableCameras();
    final front = cameras
        .firstWhere((camera) => camera.lensDirection == cameraDirection.value);
    cameraController = CameraController(front, ResolutionPreset.max);
    await cameraController.initialize();
    isLoading.value = false;
    update();
  }

  recordVideo(bool isMounted) async {
    if (isRecording.value) {
      final file = await cameraController.stopVideoRecording();
      isRecording.value = false;
      // final route = MaterialPageRoute(
      //   fullscreenDialog: true,
      //   builder: (_) => VideoRecordingScreen(filePath: file.path),
      // );
      if (isMounted) {
        Get.to(() => VideoRecordingScreen(filePath: file.path));
      }
    } else {
      await cameraController.prepareForVideoRecording();
      await cameraController.startVideoRecording();
      isRecording.value = true;
      update();
    }
  }
}
