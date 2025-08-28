class NoteModel {
  static int _counter = 0;
  final int id;
  final String title;
  final String description;

  NoteModel({
    required this.title,
    required this.description,
  }) : id = ++_counter;
}
