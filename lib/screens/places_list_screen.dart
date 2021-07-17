import 'package:flutter/material.dart';
import 'package:flutter_great_places_app/providers/great_places_provider.dart';
import 'package:flutter_great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                builder: (ctx, placesData, ch) => placesData.items.length <= 0
                    ? ch!
                    : ListView.builder(
                        itemCount: placesData.items.length,
                        itemBuilder: (ctx, index) {
                          final place = placesData.items[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(place.image),
                            ),
                            title: Text(place.title),
                            subtitle: Text(place.location.address),
                            onTap: () {},
                          );
                        },
                      ),
                child: Center(
                    child: Text("Get no places yet, start adding some!")),
              ),
      ),
    );
  }
}
