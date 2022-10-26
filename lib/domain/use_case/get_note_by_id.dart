import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/repository/note_repository.dart';

class GetNoteById {
  final NoteRepository repository;

  GetNoteById(this.repository);

  Future<Note?> call(int id)async => repository.getNoteById(id);
}