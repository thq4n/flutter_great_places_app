import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_great_places_app/helpers/db_helper.dart';
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

    DBHelper.insert("place", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final placeDataList = await DBHelper.getData("place");
    _items = placeDataList
        .map(
          (item) => Place(
            id: item["id"],
            title: item["title"],
            location: null,
            image: File(
              item["image"],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }
}
