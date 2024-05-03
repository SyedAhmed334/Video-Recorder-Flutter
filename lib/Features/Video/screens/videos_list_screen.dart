import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_recorder/Features/Authentication/screens/login_screen.dart';
import 'package:video_recorder/Features/Video/controllers/vide_list_controller.dart';
import 'package:video_recorder/Features/Video/models/video_model.dart';
import 'package:video_recorder/Features/Video/screens/video_player_time.dart';
import 'package:video_recorder/Features/Video/screens/video_screen.dart';
import 'package:video_recorder/Utils/Constants/colors.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final controller = Get.put(VideoListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Videos'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const VideoListScreen());
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.offAll(() => const LoginScreen());
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: FutureBuilder<List<Video>>(
            future: controller.fetchVideos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                log('waiting');
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                log('has error');
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                log('has data');
                log(snapshot.data!.length.toString());
                return snapshot.data!.isEmpty
                    ? const Center(
                        child: Text(
                        'No video uploaded!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ))
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final video = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            child: Card(
                              color: XColors.secondaryColor,
                              child: ListTile(
                                title: Text(video.title),
                                subtitle: Text(video.description),
                                trailing: Text(
                                  video.location,
                                ),
                                leading: const Icon(Icons.video_library),
                                onTap: () => _playVideo(video),
                              ),
                            ),
                          );
                        },
                      );
              } else {
                log('else');
                return const Center(
                    child: Text(
                  'No video uploaded!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ));
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const VideoScreen());
        },
        backgroundColor: XColors.primaryColor,
        foregroundColor: XColors.whiteColor,
        child: const Icon(Icons.videocam_outlined),
      ),
    );
  }

  void _playVideo(Video video) {
    Get.to(
      () => VideoPlayerScreen(
        videoUrl: video.videoUrl,
      ),
    );
  }
}
