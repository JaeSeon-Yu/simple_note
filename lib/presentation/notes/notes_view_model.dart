import 'package:flutter/material.dart';
import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/use_case/use_cases.dart';
import 'package:simple_note/domain/util/note_order.dart';
import 'package:simple_note/domain/util/order_type.dart';
import 'package:simple_note/presentation/notes/notes_event.dart';
import 'package:simple_note/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final UseCases useCases;

  NotesState _state = NotesState(
    notes: [],
    noteOrder: const NoteOrder.date(OrderType.descending()),
    isOrderSectionVisible: false,
  );

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
      changeOrder: _changeOrder,
      changeOrderSectionVisible: _changeOrderSectionVisible,
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await useCases.getNotes(_state.noteOrder);
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

  Future<void> _changeOrder(NoteOrder noteOrder) async {
    _state = _state.copyWith(
      noteOrder: noteOrder,
    );
    _loadNotes();
  }

  Future<void> _changeOrderSectionVisible() async {
    _state = _state.copyWith(
      isOrderSectionVisible: !state.isOrderSectionVisible,
    );

    notifyListeners();
  }
}
