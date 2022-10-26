import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/repository/note_repository.dart';

class DeleteNote {
  final NoteRepository repository;

  DeleteNote(this.repository);

  Future<void> call(Note note)async => repository.deleteNote(note);
}