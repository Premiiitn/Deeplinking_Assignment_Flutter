import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:three_post/services/DeepLinkService.dart';
import 'package:uni_links2/uni_links.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import '../view/PostPage.dart';
import '../view/VideoPostPage.dart';

class NavigationControllerPage extends StatefulWidget {
  @override
  _NavigationControllerPage createState() => _NavigationControllerPage();
}

class _NavigationControllerPage extends State<NavigationControllerPage> {
  int _selectedIndex = 0;
  final DeepLinkService _deepLinkService = DeepLinkService();

  @override
  void initState() {
    super.initState();
    _deepLinkService.initDeepLinkListener(_navigateToPost);
  }

  @override
  void dispose() {
    _deepLinkService.dispose();
    super.dispose();
  }

  void _navigateToPost(Uri uri) {
    final postId = uri.queryParameters['postId'];
    if (postId != null) {
      setState(() {
        switch (postId) {
          case 'text':
            _selectedIndex = 0;
            break;
          case 'video':
            _selectedIndex = 1;
            break;
          case 'image':
            _selectedIndex = 2;
            break;
          default:
            _selectedIndex = 0;
        }
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return const PostPage(
          title: 'Text Post',
          content:
              'Excited to share my latest project! After hours of hard work, I’ve finally brought my vision to life. This project challenged me in new ways, pushing my skills further than ever before. I am proud of the outcome and eager to hear your thoughts. Check it out and let me know what you think!',
          postId: 'text',
        );
      case 1:
        return const VideoPostPage(
          title: 'Video Post',
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          postId: 'video',
        );
      case 2:
        return const PostPage(
          title: 'Image Post',
          content: 'assets/images/bird.jpg',
          postId: 'image',
          isImage: true,
        );
      default:
        return const PostPage(
          title: 'Text Post',
          content: 'This is a sample text post.',
          postId: 'text',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Viewer',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          title: const Text('Post Viewer',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        body: _getCurrentPage(),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 18,
          unselectedFontSize: 15,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.text_fields, color: Colors.yellow),
              label: 'Text',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 20, 20, 20),
              icon: Icon(
                Icons.video_collection,
                color: Colors.red,
              ),
              label: 'Video',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 20, 20, 20),
              icon: Icon(Icons.image, color: Colors.blue),
              label: 'Image',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
