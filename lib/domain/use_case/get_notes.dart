import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/domain/repository/note_repository.dart';
import 'package:simple_note/domain/util/note_order.dart';

class GetNotes {
  final NoteRepository repository;

  GetNotes(this.repository);

  Future<List<Note>> call(NoteOrder noteOrder) async {
    List<Note> notes = await repository.getNotes();

    noteOrder.when(
      title: (orderType) {
        orderType.when(
          ascending: () {
            notes.sort((a, b) => a.title.compareTo(b.title));
          },
          descending: () {
            notes.sort((a, b) => -a.title.compareTo(b.title));
          },
        );
      },
      date: (orderType) {
        orderType.when(
          ascending: () {
            notes.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
          },
          descending: () {
            notes.sort((a, b) => -a.timeStamp.compareTo(b.timeStamp));
          },
        );
      },
      color: (orderType) {
        orderType.when(
          ascending: () {
            notes.sort((a, b) => a.color.compareTo(b.color));
          },
          descending: () {
            notes.sort((a, b) => -a.color.compareTo(b.color));
          },
        );
      },
    );
    return notes;
  }
}
