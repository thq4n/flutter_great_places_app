import 'package:flutter/material.dart';
import 'package:flutter_great_places_app/helpers/db_helper.dart';
import 'package:flutter_great_places_app/providers/great_places_provider.dart';
import 'package:flutter_great_places_app/screens/add_place_screen.dart';
import 'package:flutter_great_places_app/screens/place_detail_screen.dart';
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
                          return Dismissible(
                            onDismissed: (direction) =>
                                Provider.of<GreatPlaces>(context, listen: false)
                                    .deleteItem(place),
                            key: Key(place.id),
                            background: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).errorColor),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) {
                              return showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text(
                                        "Delete Confirmation",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Text("Are you sure"),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 18,
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                        ),
                                        TextButton(
                                          child: Text(
                                            "Cancle",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 18,
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: ListTile(
                              leading: Hero(
                                tag: place.id,
                                child: CircleAvatar(
                                  backgroundImage: FileImage(place.image),
                                ),
                              ),
                              title: Text(place.title),
                              subtitle: Text(place.location.address),
                              onTap: () => Navigator.of(context).pushNamed(
                                PlaceDetailScreen.routeName,
                                arguments: place,
                              ),
                            ),
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
