import 'package:flutter/material.dart';
import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/repository/note_repository.dart';
import 'package:simple_note/presentation/add_edit_note/add_edit_note_event.dart';

class AddEditNoteViewModel with ChangeNotifier {
  final NoteRepository repository;

  int _color = Colors.orange.value;

  int get color => color;

  AddEditNoteViewModel(this.repository);

  void onEvent(AddEditNoteEvent event) {
    event.when(
      changeColor: _changeColor,
      saveNote: _saveNote,
    );
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {
    Note note = Note(
      id: id,
      title: title,
      content: content,
      color: _color,
      timeStamp: DateTime.now().millisecondsSinceEpoch,
    );

    if (id == null) {
      repository.insertNote(
        note,
      );
    } else {
      repository.updateNote(note);
    }
  }
}
