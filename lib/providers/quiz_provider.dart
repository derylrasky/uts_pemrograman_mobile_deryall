import 'package:flutter/foundation.dart';

import '../data/quiz_questions.dart';
import '../models/quiz_question.dart';

class QuizProvider extends ChangeNotifier {
  String _playerName = '';

  final List<QuizQuestion> _questions = List<QuizQuestion>.unmodifiable(
    sampleQuizQuestions,
  );

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _hasStarted = false;

  String get playerName => _playerName;

  List<QuizQuestion> get questions => _questions;

  int get questionCount => _questions.length;

  int get currentQuestionIndex => _currentQuestionIndex;

  int get score => _score;

  int? get selectedAnswerIndex => _selectedAnswerIndex;

  bool get hasStarted => _hasStarted;

  QuizQuestion get currentQuestion => _questions[_currentQuestionIndex];

  void setPlayerName(String value) {
    if (_playerName == value) return;

    _playerName = value;
    notifyListeners();
  }

  bool startQuiz() {
    if (_playerName.trim().isEmpty) return false;

    _playerName = _playerName.trim();
    _currentQuestionIndex = 0;
    _score = 0;
    _selectedAnswerIndex = null;
    _hasStarted = true;

    notifyListeners();
    return true;
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _selectedAnswerIndex = null;
    _hasStarted = false;

    notifyListeners();
  }

  void selectAnswer(int index) {
    if (!_hasStarted) return;

    if (index < 0 || index >= currentQuestion.options.length) {
      return;
    }

    if (_selectedAnswerIndex == index) return;

    _selectedAnswerIndex = index;
    notifyListeners();
  }
}
