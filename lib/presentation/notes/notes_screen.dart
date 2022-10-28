import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_note/presentation/notes/components/note_item.dart';
import 'package:simple_note/presentation/notes/notes_event.dart';
import 'package:simple_note/presentation/notes/notes_view_model.dart';
import 'package:simple_note/routes.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesViewModel>();
    final state = viewModel.state;

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
        onPressed: () async {
          var isSaved =
              await Navigator.pushNamed(context, Routes.addEditNoteScreen);

          if (isSaved != null && isSaved == true) {
            viewModel.onEvent(const NotesEvent.loadNotes());
          }
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: state.notes
            .map(
              (note) => GestureDetector(
                onTap: () async {
                  var isSaved = await Navigator.pushNamed(
                      context, Routes.addEditNoteScreen,
                      arguments: {'note': note});

                  if (isSaved != null && isSaved == true) {
                    viewModel.onEvent(const NotesEvent.loadNotes());
                  }
                },
                child: NoteItem(
                  note: note,
                  onDeleteTap: () {
                    viewModel.onEvent(NotesEvent.deleteNote(note));

                    final snackBar = SnackBar(
                      content: const Text("노트를 삭제했습니다."),
                      action: SnackBarAction(
                        onPressed: () {
                          viewModel.onEvent(const NotesEvent.restoreNote());
                        },
                        label: '되돌리기',
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              ),
            )
            .toList()
            .reversed
            .toList(),
      ),
    );
  }
}
