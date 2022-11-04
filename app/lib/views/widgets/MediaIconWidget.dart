import 'dart:math';

import 'package:flutter/material.dart';

class MediaCoverWidget extends StatefulWidget {
  const MediaCoverWidget({super.key});

  static const double width = 120;
  static const double height = 180;

  @override
  State<MediaCoverWidget> createState() => _MediaCoverWidgetState();
}

class _MediaCoverWidgetState extends State<MediaCoverWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaCoverWidget.width,
      height: MediaCoverWidget.height,
      child: Card(
        color: Colors.grey,
      ),
    );
  }
}
