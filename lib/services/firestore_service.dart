// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a new note
  Future<void> addNote(String userId, String title, String content) async {
    try {
      await _db.collection('users').doc(userId).collection('notes').add({
        'title': title,
        'content': content,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding note: $e");
    }
  }

  // Get notes stream
  Stream<QuerySnapshot> getNotes(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('notes')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Update a note
  Future<void> updateNote(String userId, String noteId, String title, String content) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('notes')
          .doc(noteId)
          .update({
        'title': title,
        'content': content,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error updating note: $e");
    }
  }

  // Delete a note
  Future<void> deleteNote(String userId, String noteId) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('notes')
          .doc(noteId)
          .delete();
    } catch (e) {
      print("Error deleting note: $e");
    }
  }
}
