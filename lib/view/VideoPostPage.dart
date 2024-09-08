// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:uni_links2/uni_links.dart';
// import 'dart:async';
// import 'package:video_player/video_player.dart';

// class VideoPostPage extends StatefulWidget {
//   final String title;
//   final String videoUrl;
//   final String postId;

//   const VideoPostPage({
//     required this.title,
//     required this.videoUrl,
//     required this.postId,
//   });

//   @override
//   _VideoPostPageState createState() => _VideoPostPageState();
// }

// class _VideoPostPageState extends State<VideoPostPage> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _sharePost(BuildContext context) async {
//     String? shareableLink = await _createShareableLink(widget.postId);
//     if (shareableLink != null) {
//       Share.share('Check out this video post: $shareableLink');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Could not generate link')),
//       );
//     }
//   }

//   Future<String?> _createShareableLink(String postId) async {
//     String baseUrl = 'https://buildapplications-27ce1.web.app/post';
//     //String baseUrl = 'https://com.example.three_post/post';
//     return '$baseUrl?postId=$postId';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(widget.title, style: TextStyle(fontSize: 24)),
//           SizedBox(height: 20),
//           _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : CircularProgressIndicator(),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => _sharePost(context),
//             child: Text('Share'),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoPostPage extends StatefulWidget {
  final String title;
  final String videoUrl;
  final String postId;

  const VideoPostPage({
    required this.title,
    required this.videoUrl,
    required this.postId,
  });

  @override
  _VideoPostPageState createState() => _VideoPostPageState();
}

class _VideoPostPageState extends State<VideoPostPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sharePost(BuildContext context) async {
    String? shareableLink = await _createShareableLink(widget.postId);
    if (shareableLink != null) {
      Share.share('Check out this video post: $shareableLink');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not generate link')),
      );
    }
  }

  Future<String?> _createShareableLink(String postId) async {
    String baseUrl = 'https://buildapplications-27ce1.web.app/post';
    return '$baseUrl?postId=$postId';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              //padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(1.0),
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Post Title
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Video Player
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: _controller.value.isInitialized
                        ? FittedBox(
                            fit: BoxFit
                                .fill, // Ensures the video fills the available space
                            child: SizedBox(
                              width: _controller.value.size.width,
                              height: _controller.value.size.height,
                              child: VideoPlayer(_controller),
                            ),
                          )
                        : Center(
                            child: Container(
                              padding: EdgeInsets.all(95.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),

                  // Share Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                        child: ElevatedButton(
                          onPressed: () => _sharePost(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.send, color: Colors.black),
                              SizedBox(width: 8),
                              Text(
                                'Share',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
