import 'package:flutter/foundation.dart';

import '../data/quiz_questions.dart';
import '../models/quiz_question.dart';

class QuizProvider extends ChangeNotifier {
  String _playerName = '';

  final List<QuizQuestion> _questions =
      List<QuizQuestion>.unmodifiable(sampleQuizQuestions);

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;

  bool _hasStarted = false;
  bool _isAnswerConfirmed = false;
  bool _isQuizCompleted = false;

  // Getters: data yang digunakan oleh UI.

  String get playerName => _playerName;

  List<QuizQuestion> get questions => _questions;

  int get questionCount => _questions.length;

  int get currentQuestionIndex => _currentQuestionIndex;

  int get score => _score;

  int? get selectedAnswerIndex => _selectedAnswerIndex;

  bool get hasStarted => _hasStarted;

  bool get isAnswerConfirmed => _isAnswerConfirmed;

  bool get isQuizCompleted => _isQuizCompleted;

  QuizQuestion get currentQuestion => _questions[_currentQuestionIndex];

  bool get isCurrentAnswerCorrect {
    return _selectedAnswerIndex != null &&
        _selectedAnswerIndex == currentQuestion.correctAnswerIndex;
  }

  // Menyimpan nama pemain.

  void setPlayerName(String value) {
    if (_playerName == value) return;

    _playerName = value;
    notifyListeners();
  }

  // Memulai atau mengulang sesi kuis.

  bool startQuiz() {
    if (_playerName.trim().isEmpty || _questions.isEmpty) {
      return false;
    }

    _playerName = _playerName.trim();
    _currentQuestionIndex = 0;
    _score = 0;
    _selectedAnswerIndex = null;

    _hasStarted = true;
    _isAnswerConfirmed = false;
    _isQuizCompleted = false;

    notifyListeners();
    return true;
  }

  // Memilih jawaban tanpa langsung menilai jawabannya.

  void selectAnswer(int index) {
    if (!_hasStarted || _isAnswerConfirmed || _isQuizCompleted) {
      return;
    }

    if (index < 0 || index >= currentQuestion.options.length) {
      return;
    }

    if (_selectedAnswerIndex == index) return;

    _selectedAnswerIndex = index;
    notifyListeners();
  }

  // Memeriksa jawaban dan menambahkan skor jika benar.
  // Jawaban hanya bisa dinilai satu kali per pertanyaan.

  bool confirmAnswer() {
    if (!_hasStarted ||
        _isAnswerConfirmed ||
        _isQuizCompleted ||
        _selectedAnswerIndex == null) {
      return false;
    }

    _isAnswerConfirmed = true;

    if (isCurrentAnswerCorrect) {
      _score++;
    }

    notifyListeners();
    return true;
  }

  // Berpindah ke pertanyaan berikutnya atau menyelesaikan kuis.

  bool goToNextQuestion() {
    if (!_hasStarted || !_isAnswerConfirmed || _isQuizCompleted) {
      return false;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      // Pindah ke pertanyaan berikutnya.
      _currentQuestionIndex++;

      // Bersihkan pilihan untuk pertanyaan baru.
      _selectedAnswerIndex = null;
      _isAnswerConfirmed = false;
    } else {
      // Jangan menambah indeks melewati pertanyaan terakhir.
      _isQuizCompleted = true;
    }

    notifyListeners();
    return true;
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _selectedAnswerIndex = null;

    _hasStarted = false;
    _isAnswerConfirmed = false;
    _isQuizCompleted = false;

    notifyListeners();
  }
}
