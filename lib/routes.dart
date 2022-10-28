import 'package:flutter/material.dart';
import 'package:simple_note/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:simple_note/presentation/notes/notes_screen.dart';

class Routes {
  static const notesScreen = '/notesScreen';
  static const addEditNoteScreen = '/addEditNoteScreen';
}

class Pages {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var argument = settings.arguments;

    switch (settings.name) {
      case Routes.addEditNoteScreen:
        {
          return MaterialPageRoute(
            builder: (_) => const AddEditNoteScreen(),
            settings: RouteSettings(
              arguments: argument,
            ),
          );
        }
      case Routes.notesScreen:
        {
          return MaterialPageRoute(builder: (_) => const NotesScreen());
        }
      default:
        {
          return null;
        }
    }
  }
}
