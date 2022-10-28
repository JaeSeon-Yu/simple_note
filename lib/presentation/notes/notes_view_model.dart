import 'package:flutter/material.dart';
import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/use_case/use_cases.dart';
import 'package:simple_note/presentation/notes/notes_event.dart';
import 'package:simple_note/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final UseCases useCases;

  NotesState _state = NotesState(notes: []);

  NotesState get state => _state;

  Note? _recentlyDeletedNote;

  NotesViewModel(this.useCases) {
    _loadNotes();
  }

  Future<void> onEvent(NotesEvent notesEvent) async {
    notesEvent.when(
      loadNotes: _loadNotes,
      removeNote: _removeNote,
      restoreNote: _restoreNote,
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await useCases.getNotes();
    notes.sort((a, b) => -a.timeStamp.compareTo(b.timeStamp));
    _state = _state.copyWith(notes: notes);

    notifyListeners();
  }

  Future<void> _removeNote(Note note) async {
    await useCases.deleteNote(note);
    _recentlyDeletedNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeletedNote != null) {
      await useCases.insertNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;
      _loadNotes();
    }
  }
}
