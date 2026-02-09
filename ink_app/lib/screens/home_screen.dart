import 'package:flutter/material.dart';
import '../db_helper.dart';
import '../models/note_model.dart';
import 'add_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DbHelper _dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Offline Notes")),
      body: FutureBuilder<List<Note>>(
        future: _dbHelper.getLocalNotes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          if (snapshot.data!.isEmpty)
            return Center(child: Text("No notes yet!"));

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Note note = snapshot.data![index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
                trailing: Icon(
                  note.isSynced == 1 ? Icons.cloud_done : Icons.cloud_off,
                  color: note.isSynced == 1 ? Colors.green : Colors.orange,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );
          setState(() {}); // Refresh list when coming back
        },
      ),
    );
  }
}
