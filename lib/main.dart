import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:video_recorder/Features/Video/screens/video_screen.dart';
import 'package:video_recorder/Features/Video/screens/videos_list_screen.dart';
import 'package:video_recorder/firebase_options.dart';
import 'package:video_recorder/utils/themes/theme.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Video Recorder',
      debugShowCheckedModeBanner: false,
      theme: XTheme.lightTheme,
      home: const VideoScreen(),
    );
  }
}
