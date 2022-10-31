import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/util/note_order.dart';

part 'notes_state.freezed.dart';

@freezed
class NotesState with _$NotesState {
  factory NotesState({
    required List<Note> notes,
    required NoteOrder noteOrder,
    required bool isOrderSectionVisible,
  }) = _NotesState;
}