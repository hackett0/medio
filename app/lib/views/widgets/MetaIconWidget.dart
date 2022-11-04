import 'dart:math';

import 'package:flutter/material.dart';

class MetaIconWidget extends StatefulWidget {
  const MetaIconWidget({super.key});

  static const double width = 120;
  static const double height = 180;

  @override
  State<MetaIconWidget> createState() => _MetaIconWidgetState();
}

class _MetaIconWidgetState extends State<MetaIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MetaIconWidget.width,
      height: MetaIconWidget.height,
      child: Card(
        color: Colors.grey,
      ),
    );
  }
}
