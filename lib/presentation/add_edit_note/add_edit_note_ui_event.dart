import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_edit_note_ui_event.freezed.dart';

@freezed
abstract class AddEditNoteUIEvent<T> with _$AddEditNoteUIEvent<T> {
  const factory AddEditNoteUIEvent.saveNote() = SaveNote;
  const factory AddEditNoteUIEvent.showSnackBar(String message) = ShowSnackBar;
}