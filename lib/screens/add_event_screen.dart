import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:event_app/models/event.dart';

class AddEventScreen extends StatefulWidget {
  final Function(Event) onAddEvent;

  AddEventScreen({required this.onAddEvent});

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  File? _selectedImage;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _addEvent() {
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null &&
        _selectedImage != null) {
      final newEvent = Event(
        name: _nameController.text,
        description: _descriptionController.text,
        date: "${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}",
        time: _selectedTime!.format(context),
        imageFile: _selectedImage!, // Pass the File object
      );
      widget.onAddEvent(newEvent);
      Navigator.pop(context); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Event")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Event Name"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickDate,
                  child: Text(_selectedDate == null
                      ? "Pick Date"
                      : "${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _pickTime,
                  child: Text(_selectedTime == null
                      ? "Pick Time"
                      : _selectedTime!.format(context)),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Pick Image"),
            ),
            SizedBox(height: 16),
            _selectedImage != null
                ? Image.file(
              _selectedImage!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Container(
              height: 150,
              color: Colors.grey,
              child: Icon(Icons.image, size: 50),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addEvent,
              child: Text("+ Add Event"),
            ),
          ],
        ),
      ),
    );
  }
}


