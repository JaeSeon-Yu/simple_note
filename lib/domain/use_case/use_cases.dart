import 'package:simple_note/domain/use_case/delete_note.dart';
import 'package:simple_note/domain/use_case/get_note_by_id.dart';
import 'package:simple_note/domain/use_case/get_notes.dart';
import 'package:simple_note/domain/use_case/insert_note.dart';
import 'package:simple_note/domain/use_case/update_note.dart';

class UseCases {
  final DeleteNote deleteNote;
  final GetNoteById getNoteById;
  final GetNotes getNotes;
  final InsertNote insertNote;
  final UpdateNote updateNote;

  UseCases({
    required this.deleteNote,
    required this.getNoteById,
    required this.getNotes,
    required this.insertNote,
    required this.updateNote,
  });
}
