import 'package:flutter/material.dart';
import 'editimage_view_model.dart';

class ImageText extends StatelessWidget {
  final TextInfo textInfo;
  const ImageText({Key? key,required this.textInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      style: TextStyle(
        color: textInfo.textColor,
      ),
    );
  }
}
