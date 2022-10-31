import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/util/note_order.dart';

part 'notes_event.freezed.dart';

@freezed
abstract class NotesEvent<T> with _$NotesEvent<T> {
  const factory NotesEvent.loadNotes() = LoadNotes;
  const factory NotesEvent.removeNote(Note note) = RemoveNote;
  const factory NotesEvent.restoreNote() = RestoreNote;
  const factory NotesEvent.changeOrder(NoteOrder noteOrder) = ChangeOrder;
  const factory NotesEvent.changeOrderSectionVisible() = ChangeOrderSectionVisible;
}