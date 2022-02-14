// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

class BuildPage extends StatelessWidget {
  String imageAsset;
  String text;
  int index;
  BuildPage(
      {required this.imageAsset, required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: index == 0
            ? const EdgeInsets.only(top: 10)
            : const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image.asset(imageAsset),
            index == 0
                ? const SizedBox(
                    height: 80,
                  )
                : const SizedBox(
                    height: 140,
                  ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
