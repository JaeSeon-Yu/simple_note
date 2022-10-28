import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/repository/note_repository.dart';
import 'package:simple_note/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:simple_note/presentation/add_edit_note/add_edit_note_ui_event.dart';
import 'package:simple_note/ui/colors.dart';

class AddEditNoteViewModel with ChangeNotifier {
  final NoteRepository repository;

  int _color = roseBud.value;

  int get color => _color;

  final _eventController = StreamController<AddEditNoteUIEvent>.broadcast();
  Stream<AddEditNoteUIEvent> get eventStream => _eventController.stream;

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
    if(title.isEmpty || content.isEmpty){
      _eventController.add(const AddEditNoteUIEvent.showSnackBar('제목과 내용을 입력해주세요.'));
      return;
    }

    Note note = Note(
      id: id,
      title: title,
      content: content,
      color: color,
      timeStamp: DateTime.now().millisecondsSinceEpoch,
    );

    if (id == null) {
      repository.insertNote(
        note,
      );
    } else {
      repository.updateNote(note);
    }

    _eventController.add(const AddEditNoteUIEvent.saveNote());
  }
}
