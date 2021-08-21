import 'dart:ui';

import 'package:flutter/cupertino.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;

  const TextCustom({
    Key? key,
    required this.text,
    this.fontWeight = FontWeight.w400,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: fontWeight,
      ),
    );
  }
}
