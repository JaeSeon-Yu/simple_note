import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/repository/note_repository.dart';

class InsertNote {
  final NoteRepository repository;

  InsertNote(this.repository);

  Future<void> call(Note note)async => repository.insertNote(note);
}