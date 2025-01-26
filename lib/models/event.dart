import 'dart:io';

class Event {
  final String name;
  final String description;
  final String date;
  final String time;
  final File imageFile; // Changed from XFile? to File

  Event({
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.imageFile,
  });
}
