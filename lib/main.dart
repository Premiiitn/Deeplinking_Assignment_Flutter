import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:three_post/controller/NavigationController.dart';
import 'package:three_post/view/VideoPostPage.dart';
import 'package:uni_links2/uni_links.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import 'controller/NavigationController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Post Viwer',
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: NavigationControllerPage(),
    );
  }
}
