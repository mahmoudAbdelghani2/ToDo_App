import 'package:flutter/material.dart';
import 'package:flutter_application_1/Blocs/note_cubit.dart';
import 'package:flutter_application_1/Blocs/note_states.dart';
import 'package:flutter_application_1/Models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 100, 156),

      appBar: AppBar(
        title: Text('Add Note',
        style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 32, 100, 156),
        elevation: 5,
        shadowColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 16),
                Lottie.asset("assets/lottie/Login.json", width: 300, height: 300),
                SizedBox(height: 16),
                _buildTextField(_titleController, 'Title'),
                SizedBox(height: 16),
                _buildTextField(_descriptionController, 'Description'),
                SizedBox(height: 16),
                _button(context, _titleController, _descriptionController, _formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(TextEditingController controller, String hintText) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.black),
      ),
      focusColor: Colors.black,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(color: Colors.white),
      ),
      filled: true,
      fillColor: Color.fromARGB(255, 137, 137, 137),
    ),
    validator: (value) {
      if (value == null || value.isEmpty || value.length < 3) {
        return 'Please enter at least 3 characters';
      }
      return null;
    },
  );
}

Widget _button(
  BuildContext context,
  TextEditingController titleController,
  TextEditingController descriptionController,
  GlobalKey<FormState> formKey,
) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.9,
    child: BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            final form = formKey.currentState;
            if (form != null && form.validate()) {
              final title = titleController.text;
              final description = descriptionController.text;
              final note = NoteModel(title: title, description: description);
              BlocProvider.of<NoteCubit>(context).addNote(note);
              titleController.clear();
              descriptionController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Note Added Successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Text(
            'Add Note',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    ),
  );
}
