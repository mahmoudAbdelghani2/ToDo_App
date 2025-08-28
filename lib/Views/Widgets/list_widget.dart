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
      elevation: 8,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(
          widget.note.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          widget.note.description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Image.asset("assets/images/note.png", width: 60, height: 60),
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
