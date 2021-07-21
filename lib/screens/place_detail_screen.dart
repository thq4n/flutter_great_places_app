import 'package:flutter/material.dart';
import 'package:flutter_great_places_app/helpers/location_helper.dart';
import 'package:flutter_great_places_app/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  static String routeName = "/place-detail";

  bool _isInit = false;

  late Place _curPlace;

  @override
  Widget build(BuildContext context) {
    _curPlace = ModalRoute.of(context)!.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(
        title: Text(_curPlace.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: _curPlace.id,
              child: Image.file(_curPlace.image),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Location:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    title: Text(
                      _curPlace.location.address,
                    ),
                  ),
                  child: Image.network(
                    LocationHelper.generatePreviewImageUrl(
                      latitude: _curPlace.location.latitude,
                      longitude: _curPlace.location.longitude,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
