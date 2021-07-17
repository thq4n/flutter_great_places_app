import 'package:flutter/material.dart';
import 'package:flutter_great_places_app/helpers/db_helper.dart';
import 'package:flutter_great_places_app/helpers/location_helper.dart';
import 'package:flutter_great_places_app/models/place.dart';
import 'package:flutter_great_places_app/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function setLocation;
  LocationInput(this.setLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  PlaceLocation? _placeLocation;

  Future<void> _getCurrentUserLocationImage() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generatePreviewImageUrl(
        latitude: locData.latitude!, longitude: locData.longitude!);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

    widget.setLocation(
      PlaceLocation(latitude: locData.latitude!, longitude: locData.longitude!),
    );
  }

  Future<void> _getUserSelectedLocationImage() async {
    final staticMapImageUrl = LocationHelper.generatePreviewImageUrl(
        latitude: _placeLocation!.latitude,
        longitude: _placeLocation!.longitude);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<PlaceLocation> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    return _placeLocation = PlaceLocation(
        latitude: locData.latitude!, longitude: locData.longitude!);
  }

  Future<void> _selectOnMap() async {
    _placeLocation = await _getCurrentUserLocation();
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          initialLocation: _placeLocation!,
        ),
      ),
    );

    if (selectedLocation == null) {
      return;
    }

    _placeLocation = selectedLocation as PlaceLocation;

    widget.setLocation(_placeLocation);

    await _getUserSelectedLocationImage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Center(
                  child: Text(
                    "No data",
                  ),
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: _getCurrentUserLocationImage,
                icon: Icon(Icons.location_on),
                label: Text(
                  "Current location",
                ),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: _selectOnMap,
                icon: Icon(Icons.map),
                label: Text(
                  "Sellect on map",
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
