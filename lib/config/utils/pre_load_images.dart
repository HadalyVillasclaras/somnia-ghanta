import 'dart:async';
import 'package:flutter/material.dart';

Future<void> preloadImages(BuildContext context) async {
  List<String> images = [
    'assets/course/fondo.png',
    'assets/images/gradient-bg.png',
    'assets/icons/activity_icons/tinder.png',
    'assets/icons/activity_icons/texto.png',
    'assets/icons/activity_icons/pop_up.png',
    'assets/icons/activity_icons/voice_record.png',
    'assets/icons/activity_icons/meditacion.png',
    'assets/icons/activity_icons/podcast.png',
  ];

  for (String imagePath in images) {
    await precacheImage(AssetImage(imagePath), context);
  }
}

