import 'dart:io';
import 'package:flutter/material.dart';
import 'add_event_screen.dart';
import 'details_screen.dart';
import 'favorites_screen.dart';
import 'package:event_app/models/event.dart';

class AllEventsScreen extends StatefulWidget {
  @override
  _AllEventsScreenState createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  final List<Event> events = [
    Event(
      name: "Cooking Event",
      description: "A hands-on cooking experience.",
      date: "1/20/2025",
      time: "19:00",
      imageFile: File('package:event_app/assets/images/cooking_event.jpg'),
    ),
    Event(
      name: "Art Exhibition",
      description: "A showcase of creative art pieces.",
      date: "1/20/2025",
      time: "18:00",
      imageFile: File('package:event_app/assets/images/art_exhibition.jpg'),
    ),
  ];
  final List<Event> favoriteEvents = [];

  void toggleFavorite(Event event) {
    setState(() {
      if (favoriteEvents.contains(event)) {
        favoriteEvents.remove(event);
      } else {
        favoriteEvents.add(event);
      }
    });
  }

  void navigateToDetails(BuildContext context, Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(event: event),
      ),
    );
  }

  void navigateToFavoritesScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesScreen(favoriteEvents: favoriteEvents),
      ),
    );
  }

  void navigateToAddEventScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventScreen(
          onAddEvent: (Event newEvent) {
            setState(() {
              events.add(newEvent); // Add the event to the list only after user confirms.
            });
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(
          child: Text(
            'Welcome to EventHub',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Add Event and Favorites Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () => navigateToAddEventScreen(context),
                  child: Text('+ Add Event', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () => navigateToFavoritesScreen(context),
                  child: Text('Favorites', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final isFavorite = favoriteEvents.contains(event);
                return Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        child: event.imageFile != null
                            ? Image.file(
                          event.imageFile!,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          height: 100,
                          color: Colors.grey[300],
                          child: Icon(Icons.image, size: 50, color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                event.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                              onPressed: () => toggleFavorite(event),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '${event.date} - ${event.time}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () => navigateToDetails(context, event),
                            child: Text('Details'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
