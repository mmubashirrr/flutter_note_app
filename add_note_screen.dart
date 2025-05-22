// lib/screens/add_note_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';

class AddNoteScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  void _saveNote(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestoreService.addNote(
        user.uid,
        _titleController.text,
        _contentController.text,
      );
      Navigator.pop(context); // Go back to notes screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Note')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: _contentController, maxLines: 5, decoration: InputDecoration(labelText: 'Description')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _saveNote(context), child: Text('Save Note')),
          ],
        ),
      ),
    );
  }
}
