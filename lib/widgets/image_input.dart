import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function selectImage;

  ImageInput(this.selectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage!.copy("${appDir.path}/$fileName");

    widget.selectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 150,
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Text("Empty!"),
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            label: Text("Take picture"),
            icon: Icon(Icons.camera),
          ),
        ),
      ],
    );
  }
}
