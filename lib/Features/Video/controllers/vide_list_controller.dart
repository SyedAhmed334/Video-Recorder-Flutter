import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:video_recorder/Features/Video/models/video_model.dart';

class VideoListController extends GetxController {
  final auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<Video>> fetchVideos() async {
    List<Video> videoList = [];
    ListResult result = await _storage
        .ref('videos/${auth.currentUser!.uid.toString()}/')
        .listAll();
    log('current user: ${auth.currentUser!.uid}');

    for (Reference ref in result.items) {
      FullMetadata metadata = await ref.getMetadata();

      Map<String, dynamic>? customMetadata = metadata.customMetadata;
      log('metaData: $customMetadata');

      String videoUrl = await ref.getDownloadURL();
      log('metaData: $videoUrl');

      // Create Video object
      Video video = Video(
        title: customMetadata!['title'] ?? '',
        description: customMetadata['description'] ?? '',
        category: customMetadata['category'] ?? '',
        location: customMetadata['location'] ?? '',
        videoUrl: videoUrl,
      );
      videoList.add(video);
    }
    return videoList;
  }
}
