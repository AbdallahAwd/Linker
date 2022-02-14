// import this Package in pubspec.yaml file
// dependencies:
//
//   animated_text_kit:

// ignore_for_file: must_be_immutable

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class WavyText extends StatelessWidget {
  String text;
  double fontSize;
  // ignore: use_key_in_widget_constructors
  WavyText({required this.text, required this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(fontSize: fontSize),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText(text),
          ],
          repeatForever: true,
          isRepeatingAnimation: true,
        ),
      ),
    );
  }
}
