import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:video_recorder/Features/Video/screens/videos_list_screen.dart';
import 'package:video_recorder/Utils/Helpers/helper_functions.dart';

class MetaDataController extends GetxController {
  final videoTitleController = TextEditingController();
  final videoDescriptionController = TextEditingController();
  final videoCategoryController = TextEditingController();
  final videoLocationController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isUploading = false.obs;
  FirebaseStorage storage = FirebaseStorage.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> uploadVideo(String filePath) async {
    try {
      isUploading.value = true;

      File videoFile = File(filePath);
      String storagePath = "videos/$userId/${videoTitleController.text}";
      Reference ref = storage.ref().child(storagePath);
      await ref.putFile(videoFile).then((p) {
        isUploading.value = false;
        XHelperFunctions.showToastMessage(
            message: 'Video uploaded successfully');
      }).then((value) async {
        final newCustomMetaData =
            SettableMetadata(contentType: 'video/mp4', customMetadata: {
          "title": videoTitleController.text,
          "description": videoDescriptionController.text,
          "category": videoCategoryController.text,
          "location": videoLocationController.text,
        });
        final metadata = await ref.updateMetadata(newCustomMetaData);
        final printData = await ref.getMetadata();
        Get.offAll(const VideoListScreen());
        log(metadata.toString());
        log(printData.customMetadata.toString());

        XHelperFunctions.showToastMessage(message: 'Video metadata uploaded');
      });
    } catch (e) {
      isUploading.value = false;
      XHelperFunctions.showToastMessage(message: 'Error occured: $e');
    }
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      await _getAddressFromLatLng(position);
      isLoading = true.obs;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      XHelperFunctions.showToastMessage(
          message:
              'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        XHelperFunctions.showToastMessage(
            message: 'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      XHelperFunctions.showToastMessage(
          message:
              'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    String currentAddress = '';
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress =
          '${place.subLocality}, ${place.locality}, ${place.country}';
      videoLocationController.text = currentAddress;
      update();
    }).catchError((e) {
      XHelperFunctions.showToastMessage(message: e.toString());
    });
  }
}
