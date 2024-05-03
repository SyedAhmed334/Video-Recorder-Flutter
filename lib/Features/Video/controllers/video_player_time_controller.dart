import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:video_player/video_player.dart';

class VideoPlayController extends GetxController {
  late VideoPlayerController videoController;
  RxBool isVideoPlaying = true.obs;

  Future<void> initializeController(String videoUrl) async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        videoController.play();
        update();
      });
  }

  isPlaying() {
    if (!videoController.value.isPlaying) {
      videoController.play();
      isVideoPlaying.value = true;
    } else {
      videoController.pause();
      isVideoPlaying.value = false;
    }
    update();
  }
}
