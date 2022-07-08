import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editor/Widgets/default_button.dart';
import 'package:image_editor/edit_image_screen.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../utils/permission_handler.dart';

class TextInfo {
  String text;
  double left;
  double top;
  Color textColor;
  TextInfo({required this.text, required this.left, required this.top,required this.textColor});
}

abstract class EditImageViewModel extends State<EditImageScreen> {
  TextEditingController textEditingController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  List<TextInfo> texts = [];
  int currentIndex = 0;

  saveToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery.'),
          ),
        );
      }).catchError((err) => print(err));
    }
  }
  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  addNewText(BuildContext context) {
    setState(() {
      texts.add(TextInfo(text: textEditingController.text, left: 0, top: 0,textColor: Colors.black));
    });
    Navigator.of(context).pop();
    textEditingController.clear();
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Selected For Styling',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].textColor = color;
    });
  }
  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Deleted',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add new Text'),
        content: TextField(
          controller: textEditingController,
          maxLines: 6,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.edit),
              filled: true,
              hintText: 'Type Your Text Here'),
        ),
        actions: <Widget>[
          DefaultButton(
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.black,
            textColor: Colors.white,
            child: const Text('Back'),
          ),
          DefaultButton(
            onPressed: () => addNewText(context),
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('Add Text'),
          ),
        ],
      ),
    );
  }
}
