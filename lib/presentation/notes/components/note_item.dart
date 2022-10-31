import 'package:flutter/material.dart';
import 'package:simple_note/domain/model/note.dart';
import 'package:simple_note/ui/colors.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final Function? onDeleteTap;

  const NoteItem({
    Key? key,
    required this.note,
    this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(note.color),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: Theme.of(context).textTheme.titleLarge!.apply(
                  color: darkGray,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                note.content,
                style: Theme.of(context).textTheme.labelLarge!.apply(
                  color: darkGray,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: (){
                onDeleteTap?.call();
              },
              child: Icon(
                Icons.delete,
                color: Color(darkGray.value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
