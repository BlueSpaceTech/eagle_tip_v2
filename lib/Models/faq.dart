import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FAQtext {
  FAQtext({
    required this.overallindex,
    required this.data,
    required this.categoryindex,
    required this.type,
  });
  int overallindex;
  String data;

  int categoryindex;
  String type;
}

class FAQfield {
  FAQfield({
    required this.controllerr,
    required this.type,
    required this.isreadonly,
    required this.overallindex,
  });

  TextEditingController controllerr;
  String type;
  bool isreadonly;
  int overallindex;
}

class FAQVideo {
  FAQVideo({
    required this.overallindex,
    required this.controller,
    required this.categoryindex,
    required this.type,
    required this.path,
  });
  int overallindex;
  VideoPlayerController controller;
  String path;
  int categoryindex;
  String type;
}

class FAQimage {
  FAQimage({
    required this.overallindex,
    required this.image,
    required this.categoryindex,
    required this.type,
  });
  int overallindex;
  Uint8List image;

  int categoryindex;
  String type;
}
