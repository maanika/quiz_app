import 'package:flutter/material.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/data/questions.dart';

const String startScreenString = 'start-screen';
const String questionsScreenString = 'questions-screen';
const String resultsScreenString = 'results-screen';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  String currentScreen = startScreenString;

  void switchScreen() {
    setState(() {
      currentScreen = questionsScreenString;
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        currentScreen = resultsScreenString;
      });
    }
  }

  void resetQuiz() {
    selectedAnswers = [];
    setState(() {
      currentScreen = startScreenString;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (currentScreen == questionsScreenString) {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    } else if (currentScreen == resultsScreenString) {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onReset: resetQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blueAccent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
