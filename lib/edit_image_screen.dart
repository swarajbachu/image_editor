import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_editor/Widgets/editimage_view_model.dart';
import 'package:screenshot/screenshot.dart';

import 'Widgets/text_widget.dart';

class EditImageScreen extends StatefulWidget {
  final String selectedFile;
  const EditImageScreen({Key? key, required this.selectedFile})
      : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Screenshot(
         controller: screenshotController,
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                _selectedImage,
                for (int i = 0; i < texts.length; i++)
                  Positioned(
                    left: texts[i].left,
                    top: texts[i].top,
                    child: GestureDetector(
                      onLongPress: () => removeText(context),
                      onTap: () {},
                      child: Draggable(
                        feedback: ImageText(textInfo: texts[i]),
                        child: ImageText(textInfo: texts[i]),
                        onDragEnd: (drag) {
                          final renderBox =
                              context.findRenderObject() as RenderBox;
                          Offset off = renderBox.globalToLocal(drag.offset);
                          setState(() {
                            texts[i].top = off.dy;
                            texts[i].left = off.dx;
                          });
                        },
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _addNewTextTab,
    );
  }

  Widget get _selectedImage => Center(
        child: Image.file(
          File(
            widget.selectedFile,
          ),
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
        ),
      );

  Widget get _addNewTextTab => FloatingActionButton(
        onPressed: () => addNewDialog(context),
        backgroundColor: Colors.white,
        tooltip: 'Add New Text',
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );
  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                onPressed: () => saveToGallery(context),
                tooltip: 'Save Image',
              ),
              GestureDetector(
                onTap: ()=>changeTextColor(Colors.black),
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                  maxRadius: 13,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: ()=>changeTextColor(Colors.grey),
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  maxRadius: 13,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: ()=>changeTextColor(Colors.blue),
                child: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  maxRadius: 13,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: ()=>changeTextColor(Colors.green),
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  maxRadius: 13,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: ()=>changeTextColor(Colors.red),
                child: const CircleAvatar(
                  backgroundColor: Colors.red,
                  maxRadius: 13,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: ()=>changeTextColor(Colors.yellow),
                child: const CircleAvatar(
                  backgroundColor: Colors.yellow,
                  maxRadius: 13,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: ()=> changeTextColor(Colors.white),
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                  maxRadius: 13,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 12,
                  ),

                ),
              ),
            ],
          ),
        ),
      );
}
