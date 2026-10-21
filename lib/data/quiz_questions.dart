import '../models/quiz_question.dart';

const List<QuizQuestion> sampleQuizQuestions = [
  QuizQuestion(
    id: 1,
    category: 'Film',
    question: 'Dalam film Toy Story, siapa nama boneka koboi?',
    options: ['Buzz Lightyear', 'Woody', 'Rex', 'Andy'],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    id: 2,
    category: 'Film',
    question: 'Apa nama kerajaan dalam film Frozen?',
    options: ['Corona', 'Arendelle', 'Genovia', 'Narnia'],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    id: 3,
    category: 'Film',
    question: 'Nemo dalam Finding Nemo adalah jenis ikan apa?',
    options: ['Ikan mas', 'Ikan badut', 'Ikan buntal', 'Ikan pari'],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    id: 4,
    category: 'Film',
    question: 'Apa nama sekolah sihir Harry Potter?',
    options: ['Beauxbatons', 'Durmstrang', 'Hogwarts', 'Ilvermorny'],
    correctAnswerIndex: 2,
  ),
  QuizQuestion(
    id: 5,
    category: 'Series',
    question: 'Apa nama dimensi alternatif dalam Stranger Things?',
    options: ['The Void', 'The Upside Down', 'The Backrooms', 'Shadow Realm'],
    correctAnswerIndex: 1,
  ),
  QuizQuestion(
    id: 6,
    category: 'Film',
    question: 'Siapa ayah Simba dalam The Lion King?',
    options: ['Scar', 'Rafiki', 'Mufasa', 'Timon'],
    correctAnswerIndex: 2,
  ),
];
