import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/custom_back_button.dart';
import 'package:event_app/screens/details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Event> favoriteEvents;

  FavoritesScreen({required this.favoriteEvents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(top: 16),
            itemCount: favoriteEvents.length,
            itemBuilder: (context, index) {
              final event = favoriteEvents[index];
              return ListTile(
                title: Text(event.name),
                subtitle: Text('${event.date} at ${event.time}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(event: event),
                    ),
                  );
                },
              );
            },
          ),
          CustomBackButton(),
        ],
      ),
    );
  }
}
