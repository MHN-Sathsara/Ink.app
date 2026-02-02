import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'db_helper.dart';
import './models/note_model.dart';

class SyncService {
  final DbHelper _dbHelper = DbHelper();

  Future<void> syncNotesWithServer() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      List<Note> localNotes = await _dbHelper.getLocalNotes();

      for (var note in localNotes) {
        if (note.isSynced == 0) {
          final response = await http.post(
            Uri.parse("http://YOUR_SERVER_IP:3000/sync"),
            body: jsonEncode(note.toMap()),
            headers: {"Content-Type": "application/json"},
          );

          if (response.statusCode == 200) {
            // Update local DB to say "synced"
            // (You'd add an update method in DBHelper)
          }
        }
      }
    }
  }
}
