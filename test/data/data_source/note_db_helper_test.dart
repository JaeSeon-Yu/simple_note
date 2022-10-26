import 'package:flutter_test/flutter_test.dart';
import 'package:simple_note/data/data_source/note_db.dart';
import 'package:simple_note/domain/model/note.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test('db test', () async {
    final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    await db.execute(
        'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timeStamp INTEGER)');

    final noteDBHepler = NoteDBHelper(db);

    await noteDBHepler.insertNote(Note(
      title: 'test',
      content: 'test',
      color: 1,
      timeStamp: 1,
    ));

    //insert test
    expect((await noteDBHepler.getNotes()).length, 1);

    Note note = (await noteDBHepler.getNoteById(1))!;
    //select test
    expect(note.id, 1);

    noteDBHepler.updateNote(note.copyWith(color: 2));

    //update test
    expect((await noteDBHepler.getNoteById(1))!.color, 2);

    noteDBHepler.deleteNote(note);

    //delete test
    expect((await noteDBHepler.getNotes()).length, 0);

    await db.close();
  });
}
