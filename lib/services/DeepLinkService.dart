import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uni_links2/uni_links.dart';

class DeepLinkService {
  StreamSubscription? _sub;

  void initDeepLinkListener(Function(Uri) navigateToPost) {
    getInitialUri().then((uri) {
      if (uri != null) {
        navigateToPost(uri);
      } else {
        print("not found");
      }
    });

    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        navigateToPost(uri);
      }
    }, onError: (err) {
      print('Failed to receive uri: $err');
    });
  }

  void dispose() {
    _sub?.cancel();
  }
}
