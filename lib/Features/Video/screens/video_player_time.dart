import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_recorder/Features/Video/controllers/video_player_time_controller.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  void initState() {
    super.initState();
    controller.initializeController(widget.videoUrl);
  }

  @override
  void dispose() {
    super.dispose();
    controller.videoController.dispose();
  }

  final controller = Get.put(VideoPlayController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Player')),
      body: GetBuilder<VideoPlayController>(builder: (controller) {
        return Center(
          child: controller.videoController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: controller.videoController.value.aspectRatio,
                  child: VideoPlayer(controller.videoController),
                )
              : const CircularProgressIndicator(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.isPlaying();
        },
        child: Obx(
          () => Icon(
            controller.isVideoPlaying.value ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}
