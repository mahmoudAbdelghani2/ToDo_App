import 'package:flutter_application_1/Models/note_model.dart';

abstract class NoteState {}

class InitialNoteState extends NoteState {}

class LoadingNoteState extends NoteState {}

class NotesLoadedState extends NoteState {
  final List<NoteModel> notes;
  NotesLoadedState(this.notes);
}

class AddedNoteState extends NoteState {
  final List<NoteModel> notes;
  AddedNoteState(this.notes);
}

class DeletedNoteState extends NoteState {
  final int noteId;
  DeletedNoteState(this.noteId);
}
