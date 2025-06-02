// lib/widgets/note_tile.dart
import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onDelete;

  const NoteTile({
    required this.title,
    required this.description,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
