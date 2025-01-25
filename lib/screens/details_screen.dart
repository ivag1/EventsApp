import 'package:flutter/material.dart';
import '../models/event.dart';
import '../widgets/custom_back_button.dart';

class DetailsScreen extends StatelessWidget {
  final Event event;

  DetailsScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(event.imageUrl, height: 200, fit: BoxFit.cover),
                SizedBox(height: 16),
                Text(
                  event.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('${event.date} at ${event.time}'),
                SizedBox(height: 16),
                Text(event.description),
              ],
            ),
          ),
          CustomBackButton(),
        ],
      ),
    );
  }
}
