import 'dart:async';
import 'dart:core';

import 'package:simple_note/domain/model/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteDBHelper {
  Database db;

  NoteDBHelper(this.db);

  Future<Note?> getNoteById(int id) async {
    // select * from note where id = :id
    final maps = await db.query(
      'note',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Note>> getNotes() async {
    final maps = await db.query(
      'note',
    );

    return maps.map((e) => Note.fromJson(e)).toList();
  }

  Future<void> deleteNote(Note note) async {
    await db.delete(
      'note',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> updateNote(Note note) async {
    await db.update(
      'note',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> insertNote(Note note) async {
    await db.insert(
      'note',
      note.toJson(),
    );
  }
}
