import 'package:flutter/material.dart';
import 'package:simple_note/presentation/notes/notes_screen.dart';
import 'package:simple_note/ui/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: darkGray,
      ),
      home: const NotesScreen(),
    );
  }
}