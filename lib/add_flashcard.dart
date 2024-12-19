import 'package:flutter/material.dart';
import 'flashcard.dart';

class AddFlashcardPage extends StatelessWidget {
  final Function(Flashcard) onAddFlashcard;

  AddFlashcardPage({Key? key, required this.onAddFlashcard}) : super(key: key);

  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Flashcard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: "Question"),
            ),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(labelText: "Answer"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newFlashcard = Flashcard(
                  question: _questionController.text,
                  answer: _answerController.text,
                );
                onAddFlashcard(newFlashcard);
                Navigator.of(context).pop(); // Close the page
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}