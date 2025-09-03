// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Blocs/note_cubit.dart';
import 'package:flutter_application_1/Blocs/note_states.dart';
import 'package:flutter_application_1/Views/Widgets/list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
    Future.delayed(Duration.zero, () {
      BlocProvider.of<NoteCubit>(context).loadNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 100, 156),
      appBar: AppBar(
        title: Text(
          'All Notes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 32, 100, 156),
        elevation: 5,
        shadowColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _search(_searchController),
            const SizedBox(height: 15),
            Expanded(
              child: BlocBuilder<NoteCubit, NoteState>(
                builder: (context, state) {
                  if (state is LoadingNoteState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is NotesLoadedState) {
                    final notes = state.notes;
                    final filtered = _searchText.isEmpty
                        ? notes
                        : notes
                              .where(
                                (note) => note.title.toLowerCase().contains(
                                  _searchText.toLowerCase(),
                                ),
                              )
                              .toList();
                    if (filtered.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/lottie/NoData.json",
                              width: 300,
                              height: 300,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'No notes available',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Number of notes: ${filtered.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final note = filtered[index];
                              return ListWidget(note: note);
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'There was a problem loading notes',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _search(TextEditingController searchController) {
  return TextField(
    controller: searchController,
    decoration: const InputDecoration(
      prefixIcon: Icon(Icons.search),
      hintText: 'Search Notes...',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Colors.black),
      ),
      focusColor: Colors.blue,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Colors.blue),
      ),
      filled: true,
      fillColor: Color.fromARGB(255, 137, 137, 137),
    ),
  );
}
