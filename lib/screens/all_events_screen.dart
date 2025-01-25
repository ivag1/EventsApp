import 'dart:io';
import 'package:flutter/material.dart';
import 'add_event_screen.dart';
import 'details_screen.dart';
import 'favorites_screen.dart';
import '../models/event.dart';

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
      imageUrl: "https://via.placeholder.com/150",
    ),
    Event(
      name: "Art Exhibition",
      description: "A showcase of creative art pieces.",
      date: "1/20/2025",
      time: "18:00",
      imageUrl: "https://via.placeholder.com/150",
    ),
  ];
  final List<Event> favoriteEvents = [];

  void addToFavorites(Event event) {
    setState(() {
      if (!favoriteEvents.contains(event)) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Events'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => navigateToFavoritesScreen(context),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            color: Colors.grey[200],
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                event.imageUrl != null
                    ? Image.network(
                  event.imageUrl,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 50, color: Colors.grey),
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
                        icon: Icon(Icons.favorite_border, color: Colors.red),
                        onPressed: () => addToFavorites(event),
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
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => navigateToDetails(context, event),
                    child: Text('Details'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
