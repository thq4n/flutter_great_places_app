import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_great_places_app/providers/great_places_provider.dart';
import 'package:flutter_great_places_app/widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routeName = "/add-place";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add A New Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: "Title"),
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageInput(_selectImage),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                  )
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              primary: Theme.of(context).accentColor,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text("Add place"),
          ),
        ],
      ),
    );
  }
}
