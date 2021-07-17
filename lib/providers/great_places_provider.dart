import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items].reversed.toList();
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: UniqueKey().toString(),
      title: title,
      location: null,
      image: image,
    );

    _items.add(newPlace);

    notifyListeners();
  }
}
