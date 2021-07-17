import 'package:flutter/material.dart';
import 'package:flutter_great_places_app/models/place.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;

  MapScreen(
      {this.initialLocation = const PlaceLocation(
        latitude: 10.7797179,
        longitude: 106.6991401,
      )});

  @override
  _MapscreenState createState() => _MapscreenState();
}

class _MapscreenState extends State<MapScreen> {
  var _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your map"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(
                  PlaceLocation(
                    latitude: _mapController.center.latitude,
                    longitude: _mapController.center.longitude,
                  ),
                );
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(widget.initialLocation.latitude,
                  widget.initialLocation.longitude),
              zoom: 13,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/thieuquan501/ckr7q1q9y3m7917mz4yy82acp/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidGhpZXVxdWFuNTAxIiwiYSI6ImNrcjdvcjVmdjE0OW8ycG52azBjdGJ1cm0ifQ.MEUOFikPEwuS4AQM6W1u9A",
                  additionalOptions: {
                    "accessToken":
                        "pk.eyJ1IjoidGhpZXVxdWFuNTAxIiwiYSI6ImNrcjdvcjVmdjE0OW8ycG52azBjdGJ1cm0ifQ.MEUOFikPEwuS4AQM6W1u9A",
                    "id": "mapbox.mapbox-streets-v8",
                  }),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 50.0,
                    height: 50.0,
                    point: LatLng(widget.initialLocation.latitude,
                        widget.initialLocation.longitude),
                    builder: (ctx) => Container(
                      child: FittedBox(
                        child: Icon(
                          Icons.location_on,
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Container(
              width: 50.0,
              height: 50.0,
              child: FittedBox(
                child: Icon(
                  Icons.location_on,
                  color: Colors.green,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
