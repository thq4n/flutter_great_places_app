import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_great_places_app/helpers/db_helper.dart';
import 'package:flutter_great_places_app/helpers/location_helper.dart';
import 'package:flutter_great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items].reversed.toList();
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.generatePreviewAddress(
        latitude: location.latitude, longitude: location.longitude);

    final updatedLocation = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address);

    final newPlace = Place(
      id: UniqueKey().toString(),
      title: title,
      location: updatedLocation,
      image: image,
    );

    _items.add(newPlace);

    notifyListeners();

    DBHelper.insert("place", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "loc_lat": newPlace.location.latitude,
      "loc_lng": newPlace.location.longitude,
      "address": newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final placeDataList = await DBHelper.getData("place");
    _items = placeDataList
        .map(
          (item) => Place(
            id: item["id"],
            title: item["title"],
            location: PlaceLocation(
              latitude: item["loc_lat"],
              longitude: item["loc_lng"],
              address: item["address"],
            ),
            image: File(
              item["image"],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }
}
