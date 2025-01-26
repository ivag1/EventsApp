import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/custom_back_button.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Event> favoriteEvents;

  FavoritesScreen({required this.favoriteEvents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Favorites Title
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                child: Center(
                  child: Text(
                    "Favorites",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // Favorites List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: favoriteEvents.length,
                  itemBuilder: (context, index) {
                    final event = favoriteEvents[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.orange.shade100,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            event.imageFile,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          event.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${event.date} ${event.time}'),
                        trailing: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(event: event),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          CustomBackButton(),
        ],
      ),
    );
  }
}
