import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:simple_note/data/data_source/note_db.dart';
import 'package:simple_note/data/repository/note_repository_impl.dart';
import 'package:simple_note/domain/repository/note_repository.dart';
import 'package:simple_note/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:simple_note/presentation/notes/notes_view_model.dart';
import 'package:sqflite/sqflite.dart';

Future<List<SingleChildWidget>> getProviders() async {
  Database database =
      await openDatabase('note_db', version: 1, onCreate: (db, version) async {
    await db.execute(
        'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timeStamp INTEGER)');
  });

  NoteDBHelper noteDBHelper = NoteDBHelper(database);
  NoteRepository repository = NoteRepositoryImpl(noteDBHelper);
  NotesViewModel notesViewModel = NotesViewModel(repository);
  AddEditNoteViewModel addEditNoteViewModel = AddEditNoteViewModel(repository);

  return [
    ChangeNotifierProvider(create: (_) => notesViewModel),
    ChangeNotifierProvider(create: (_) => addEditNoteViewModel),
  ];
}
