import 'dart:io';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoRecordingController extends GetxController {
  late VideoPlayerController videoPlayerController;
  RxBool isPlaying = true.obs;
  bool togglePlaying() {
    if (isPlaying.value == true) {
      videoPlayerController.pause();
      isPlaying.value = false;
    } else {
      videoPlayerController.play();
      isPlaying.value = true;
    }
    return isPlaying.value;
  }

  Future initVideoPlayer(String filePath) async {
    videoPlayerController = VideoPlayerController.file(File(filePath));
    await videoPlayerController.initialize();
    await videoPlayerController.setLooping(true);
    await videoPlayerController.play();
  }
}
