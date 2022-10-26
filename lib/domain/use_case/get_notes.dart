import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/repository/note_repository.dart';

class GetNotes {
  final NoteRepository repository;

  GetNotes(this.repository);

  Future<List<Note>> call()async => await repository.getNotes();
}