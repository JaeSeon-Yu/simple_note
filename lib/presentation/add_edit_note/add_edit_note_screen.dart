import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:simple_note/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:simple_note/ui/colors.dart';

class AddEditNoteScreen extends StatefulWidget {
  const AddEditNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  StreamSubscription? _streamSubscription;

  Note? note;

  final List<Color> noteColors = [
    roseBud,
    primRose,
    wisteria,
    skyBlue,
    illusion,
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<AddEditNoteViewModel>();

      _streamSubscription = viewModel.eventStream.listen((event) {
        event.when(saveNote: () {
          Navigator.pop(context, true);
        }, showSnackBar: (String message) {
          final snackBar = SnackBar(content: Text(message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      });

      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;

      if (arguments.isNotEmpty) {
        note = arguments['note'];
        _titleController.text = note!.title;
        _contentController.text = note!.content;
        viewModel.onEvent(AddEditNoteEvent.changeColor(note!.color));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.onEvent(
            AddEditNoteEvent.saveNote(
              note?.id,
              _titleController.text,
              _contentController.text,
            ),
          );
        },
        child: const Icon(Icons.save),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        color: Color(viewModel.color),
        child: SafeArea(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: noteColors
                    .map(
                      (color) => InkWell(
                        child: _buildBackgroundColor(
                            color: color,
                            selected: viewModel.color == color.value),
                        onTap: () {
                          viewModel.onEvent(
                              AddEditNoteEvent.changeColor(color.value));
                        },
                      ),
                    )
                    .toList(),
              ),
              TextField(
                controller: _titleController,
                maxLines: 1,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: darkGray,
                    ),
                decoration: const InputDecoration(
                  hintText: '제목을 입력하세요',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _contentController,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: darkGray,
                    ),
                decoration: const InputDecoration(
                  hintText: '제목을 입력하세요',
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
    _titleController.dispose();
    _streamSubscription?.cancel();
  }

  Widget _buildBackgroundColor({
    required Color color,
    required bool selected,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6.0,
            spreadRadius: 1.0,
          ),
        ],
        border: selected ? Border.all(color: Colors.black, width: 3) : null,
      ),
    );
  }
}
