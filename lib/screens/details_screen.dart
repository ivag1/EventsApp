import 'package:flutter/material.dart';
import 'dart:io';
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Event Details Title
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Event Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Event Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    event.imageFile,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),

                // Event Name
                Text(
                  event.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),

                // Event Date and Time
                Text(
                  '${event.date} at ${event.time}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),

                // Event Description
                Text(
                  event.description,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          CustomBackButton(),
        ],
      ),
    );
  }
}
