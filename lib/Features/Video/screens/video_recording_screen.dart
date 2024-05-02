import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_recorder/Features/Meta%20Data/meta_data_screen.dart';
import 'package:video_recorder/Features/Video/controllers/video_recording_controller.dart';
import 'package:video_recorder/Features/Video/screens/video_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  final String filePath;

  const VideoRecordingScreen({super.key, required this.filePath});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  @override
  // ignore: override_on_non_overriding_member
  final controller = Get.put(VideoRecordingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () async {
            controller.videoPlayerController.dispose();
            Get.offAll(() => const VideoScreen());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () async {
              controller.togglePlaying();
              Get.to(() => MetaDataScreen(filePath: widget.filePath));
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: GetBuilder<VideoRecordingController>(builder: (context) {
        return FutureBuilder(
          future: controller.initVideoPlayer(widget.filePath),
          builder: (context, state) {
            if (state.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  VideoPlayer(controller.videoPlayerController),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Obx(
                        () => Icon(controller.isPlaying.value == true
                            ? Icons.pause
                            : Icons.play_arrow),
                      ),
                      onPressed: () {
                        controller.togglePlaying();
                      },
                    ),
                  ),
                ]),
              );
            }
          },
        );
      }),
    );
  }
}
