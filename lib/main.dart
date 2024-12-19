import 'package:flash_card/flashcard.dart';
import 'package:flash_card/flashcard_view.dart';
import 'package:flash_card/add_flashcard.dart'; // Import the new page
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // List to hold flashcards
  List<Flashcard> _flashcards = [
    Flashcard(
        question: "What programming language does Flutter use?", answer: "Dart"),
    Flashcard(question: "What is your favorite sport?", answer: "Basketball"),
    Flashcard(question: "Who is our Prime Minister ?", answer: "Narender Modi "),
    Flashcard(question: "Which framework is better Flutter or ReactNative  ", answer: "Flutter "),

  ];

  // Index to track the current flashcard being displayed
  int _currentIndex = 0;

  // Controllers for text fields
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the current flashcard
              SizedBox(
                width: 250,
                height: 250,
                child: FlipCard(
                  fill: Fill.fillBack,
                  direction: FlipDirection.HORIZONTAL,
                  side: CardSide.FRONT,
                  front: FlashcardView(
                      text: _flashcards[_currentIndex].question),
                  back: FlashcardView(
                      text: _flashcards[_currentIndex].answer),
                ),
              ),
              // Navigation buttons for previous and next flashcards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                    onPressed: showPreviousCard,
                    icon: Icon(Icons.chevron_left),
                    label: Text("Prev"),
                  ),
                  OutlinedButton.icon(
                    onPressed: showNextCard,
                    icon: Icon(Icons.chevron_right),
                    label: Text("Next"),
                  ),
                ],
              ),
              // Buttons for adding, editing, and deleting flashcards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: () => showAddEditDialog(),
                    child: Text("ADD"),
                  ),
                  OutlinedButton(
                    onPressed: () => showAddEditDialog(index: _currentIndex),
                    child: Text("EDIT"),
                  ),
                  OutlinedButton(
                    onPressed: () => deleteCard(),
                    child: Text("DELETE"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the next flashcard
  void showNextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1 < _flashcards.length) ? _currentIndex + 1 : 0;
    });
  }

  // Function to show the previous flashcard
  void showPreviousCard() {
    setState(() {
      _currentIndex = (_currentIndex - 1 >= 0) ? _currentIndex - 1 : _flashcards.length - 1;
    });
  }

  // Function to show a dialog for adding or editing a flashcard
  void showAddEditDialog({int? index}) {
    if (index != null) {
      // Existing code for editing
      _questionController.text = _flashcards[index].question;
      _answerController.text = _flashcards[index].answer;

      // Show edit dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Edit Flashcard"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _questionController,
                    decoration: InputDecoration(labelText: "Question"),
                  ),
                  TextField(
                    controller: _answerController,
                    decoration: InputDecoration(labelText: "Answer"),
                  ),
                ],
              ),
              actions: [
              TextButton(
              onPressed: () {
            setState(() {
              _flashcards[index] = Flashcard(
                question: _questionController.text,
                answer: _answerController.text,
              );
            });
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("SAVE"),
          ),
          TextButton(
          onPressed: () {
          Navigator.of(context).pop(); // Close the dialog without saving
          },
          child: Text("CANCEL"),
          ),
          ],
          );
        },
      );
    } else {
      // Navigate to the AddFlashcardPage
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddFlashcardPage(
            onAddFlashcard: (newFlashcard) {
              setState(() {
                _flashcards.add(newFlashcard);
              });
            },
          ),
        ),
      );
    }
  }

  // Function to delete the current flashcard
  void deleteCard() {
    setState(() {
      _flashcards.removeAt(_currentIndex);
      // Adjust the current index if necessary
      if (_currentIndex >= _flashcards.length && _flashcards.isNotEmpty) {
        _currentIndex = _flashcards.length - 1;
      } else if (_flashcards.isEmpty) {
        _currentIndex = 0; // Reset index if no flashcards are left
      }
    });
  }
}