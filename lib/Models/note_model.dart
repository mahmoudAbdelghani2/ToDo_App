class NoteModel {
  static int _counter = 0;

  final int id;
  final String title;
  final String description;
  final bool isCompleted;

  NoteModel({
    required this.title,
    required this.description,
    this.isCompleted = false,
    int? id,
  }) : id = id ?? ++_counter;

  NoteModel copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    int? id,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
