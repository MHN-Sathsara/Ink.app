class Note {
  final String id;
  final String title;
  final String content;
  final int isSynced;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.isSynced,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'content': content, 'isSynced': isSynced};
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      isSynced: map['isSynced'],
    );
  }
}
