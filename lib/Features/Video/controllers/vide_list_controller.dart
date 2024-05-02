import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class VideoListController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  void getVideosList() async {
    // ListResult result = await storage.ref().child('videos/$userId/').;
    // log(result.sto);
  }
}
