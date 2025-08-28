import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Screens/add_note.dart';
import 'package:flutter_application_1/Views/Screens/note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _selectedIndex = 0;
final List<Widget> _screens = [NoteScreen(), AddNoteScreen()];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 100, 156),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: const Color.fromARGB(255, 1, 44, 80),
        elevation: 8,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 20,
        unselectedFontSize: 16,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Note',
          ),
        ],
      ),
    );
  }
}
