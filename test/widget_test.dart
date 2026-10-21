import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:uts_pemrograman_mobile_deryal/app.dart';
import 'package:uts_pemrograman_mobile_deryal/providers/quiz_provider.dart';
import 'package:uts_pemrograman_mobile_deryal/providers/theme_provider.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => QuizProvider()),
        ],
        child: const ReelQuizApp(),
      ),
    );

    expect(find.text('ReelQuiz'), findsAtLeast(1));
    expect(find.text('Mulai Kuis'), findsOneWidget);
  });
}
