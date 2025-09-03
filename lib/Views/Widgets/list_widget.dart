import 'package:flutter/material.dart';
import 'package:flutter_application_1/Blocs/note_cubit.dart';
import 'package:flutter_application_1/Blocs/note_states.dart';
import 'package:flutter_application_1/Models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListWidget extends StatefulWidget {
  final NoteModel note;
  const ListWidget({super.key, required this.note});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 12,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(
          widget.note.title,
          style: TextStyle(
            fontWeight: !widget.note.isCompleted ? FontWeight.bold : FontWeight.normal,
            fontSize: !widget.note.isCompleted ? 20 : 17,
            color: Colors.black,
            decoration: widget.note.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor: Colors.red,
            decorationThickness: 2.0,
          ),
        ),
        subtitle: Text(
          widget.note.description,
          style: TextStyle(
            fontSize: !widget.note.isCompleted ? 16 : 14,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            decoration: widget.note.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor: Colors.red,
            decorationThickness: 2.0,
          ),
        ),
        leading: SizedBox(
          width: 120,
          child: Row(
            children: [
              Checkbox(
                value: widget.note.isCompleted,
                activeColor: Colors.green,
                checkColor: Colors.white,
                onChanged: (bool? value) {
                  context.read<NoteCubit>().updateNote(
                    widget.note.copyWith(isCompleted: value ?? false),
                  );
                },
              ),
              SizedBox(width: 8),
              Image.asset("assets/images/note.png", width: 60, height: 60),
            ],
          ),
        ),
        trailing: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Note'),
                    content: const Text(
                      'Are you sure you want to delete this note?',
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Delete'),
                        onPressed: () {
                          BlocProvider.of<NoteCubit>(
                            context,
                          ).deleteNote(widget.note.id);
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Note Deleted Successfully!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
