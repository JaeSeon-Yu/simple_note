import 'package:flutter/material.dart';
import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/presentation/notes/components/note_item.dart';
import 'package:simple_note/routes.dart';
import 'package:simple_note/ui/colors.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Note',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w100),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addEditNoteScreen);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          NoteItem(
            note: Note(
              title: 'title1',
              content: 'content1',
              color: roseBud.value,
              timeStamp: 1,
            ),
          ),
          NoteItem(
            note: Note(
              title: 'title12',
              content: 'content12',
              color: wisteria.value,
              timeStamp: 1,
            ),
          ),
        ],
      ),
    );
  }
}
