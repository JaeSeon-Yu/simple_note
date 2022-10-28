import 'package:flutter/material.dart';
import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/repository/note_repository.dart';
import 'package:simple_note/presentation/notes/notes_event.dart';
import 'package:simple_note/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  NoteRepository repository;

  NotesState _state = NotesState(notes: []);
  NotesState get state => _state;

  Note? _recentlyDeletedNote;

  NotesViewModel(this.repository){
    _loadNotes();
  }

  Future<void> onEvent(NotesEvent notesEvent) async {
    notesEvent.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
    );
  }


  Future<void> _loadNotes()async {
    _state = _state.copyWith(notes: await repository.getNotes());
    notifyListeners();
  }

  Future<void> _deleteNote(Note note)async {
    await repository.deleteNote(note);
    _recentlyDeletedNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote()async {
    if(_recentlyDeletedNote != null){
      await repository.insertNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;
      _loadNotes();
    }
  }
}
