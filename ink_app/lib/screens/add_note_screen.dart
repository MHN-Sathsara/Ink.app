import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../db_helper.dart';
import '../models/note_model.dart';

class AddNoteScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final DbHelper _dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: "Content"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final newNote = Note(
                  id: Uuid().v4(), // Generates a unique ID
                  title: _titleController.text,
                  content: _contentController.text,
                  isSynced: 0, // 0 because it's only on the phone right now
                );
                await _dbHelper.insertNote(newNote);
                Navigator.pop(context);
              },
              child: Text("Save Offline"),
            ),
          ],
        ),
      ),
    );
  }
}
