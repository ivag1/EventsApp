import 'package:flutter/material.dart';
import 'package:event_app/screens/all_events_screen.dart';

void main() {
  runApp(MyApp());
}

//class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  home: AllEventsScreen(),
  );
  }
  }
