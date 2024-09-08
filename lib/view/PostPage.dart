import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uni_links2/uni_links.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';

class PostPage extends StatelessWidget {
  final String title;
  final String content;
  final String postId;
  final bool isImage;

  const PostPage({
    required this.title,
    required this.content,
    required this.postId,
    this.isImage = false,
  });

  Future<void> _sharePost(BuildContext context) async {
    String? shareableLink = await _createShareableLink(postId);
    if (shareableLink != null) {
      Share.share('Check out this post: $shareableLink');
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Post Title
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
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
                  isImage
                      ? Expanded(
                          child: Image.asset(
                            content,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            content,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
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
                      ],
                    ),
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
