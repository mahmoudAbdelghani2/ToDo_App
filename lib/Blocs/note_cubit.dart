import 'package:flutter_application_1/Blocs/note_states.dart';
import 'package:flutter_application_1/Models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(InitialNoteState());

  List<NoteModel> notes = [];

  void loadNotes() {
    emit(NotesLoadedState(List.from(notes)));
  }

  void addNote(NoteModel note) {
    emit(LoadingNoteState());
    notes.add(note);
    loadNotes();
  }

  void deleteNote(int noteId) {
    emit(LoadingNoteState());
    notes.removeWhere((note) => note.id == noteId);
    loadNotes();
  }
  void updateNote(NoteModel updatedNote) {
    emit(LoadingNoteState());
    int index = notes.indexWhere((note) => note.id == updatedNote.id);
    if (index != -1) {
      notes[index] = updatedNote;
      loadNotes();
    } else {
      loadNotes();
    }
  }
}
