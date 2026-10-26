import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/quiz_option_card.dart';
import '../widgets/theme_toggle_button.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;
    final colors = Theme.of(context).colorScheme;

    final progress = (
      (quiz.currentQuestionIndex + 1) / quiz.questionCount
    ).clamp(0.0, 1.0).toDouble();

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.pagePaddingForWidth(width),
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.readingContentMaxWidth(width),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header: tombol kembali, logo teks, dan tema.
                      Row(
                        children: [
                          IconButton(
                            tooltip: 'Kembali ke halaman awal',
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ReelQuiz',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                Text(
                                  'FILM & SERIES TRIVIA',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: colors.onSurfaceVariant,
                                        letterSpacing: 1,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const ThemeToggleButton(),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Judul halaman dan posisi pertanyaan.
                      Text(
                        'Saatnya menguji ingatanmu!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Semangat, ${quiz.playerName}!'
                        ' Ketuk pilihan untuk langsung menjawab.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: colors.onSurfaceVariant,
                              height: 1.6,
                            ),
                      ),

                      const SizedBox(height: 24),

                      // Informasi progres.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PROGRES KUIS',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: colors.onSurfaceVariant,
                                  letterSpacing: 0.8,
                                ),
                          ),
                          Text(
                            'SOAL ${quiz.currentQuestionIndex + 1}'
                            ' DARI ${quiz.questionCount}',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor: colors.surfaceContainerHighest,
                          color: colors.primary,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Kartu pertanyaan.
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: colors.outlineVariant,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: colors.primaryContainer,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                question.category.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: colors.onPrimaryContainer,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.7,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              'PERTANYAAN ${quiz.currentQuestionIndex + 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: colors.onSurfaceVariant,
                                    letterSpacing: 0.8,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              question.question,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 1.35,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Pilih satu jawaban yang paling tepat.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: colors.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 26),

                      Text(
                        'PILIHAN JAWABAN',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(
                              color: colors.onSurfaceVariant,
                              letterSpacing: 0.8,
                            ),
                      ),
                      const SizedBox(height: 14),

                      // Pilihan menggunakan widget reusable. Langsung menjawab saat diketuk.
                      ...List.generate(
                        question.options.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: QuizOptionCard(
                              index: index,
                              label: question.options[index],
                              isSelected: quiz.selectedAnswerIndex == index,
                              isCorrect: index == question.correctAnswerIndex,
                              showResult: quiz.isAnswerConfirmed,
                              enabled: !quiz.isAnswerConfirmed &&
                                  !quiz.isQuizCompleted,
                              onTap: () {
                                context
                                    .read<QuizProvider>()
                                    .answerQuestion(index);
                              },
                            ),
                          );
                        },
                      ),

                      // Kartu hasil umpan balik instan jika jawaban sudah dijawab.
                      if (quiz.isAnswerConfirmed) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: quiz.isCurrentAnswerCorrect
                                ? Colors.green.withAlpha(22)
                                : colors.error.withAlpha(22),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: quiz.isCurrentAnswerCorrect
                                  ? Colors.green.shade700
                                  : colors.error,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                quiz.isCurrentAnswerCorrect
                                    ? Icons.check_circle_rounded
                                    : Icons.info_outline_rounded,
                                color: quiz.isCurrentAnswerCorrect
                                    ? Colors.green.shade700
                                    : colors.error,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  quiz.isCurrentAnswerCorrect
                                      ? 'Benar! Kamu mendapatkan 1 poin. Skor saat ini: ${quiz.score}.'
                                      : 'Belum tepat. Jawaban yang benar adalah "${question.options[question.correctAnswerIndex]}".',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        height: 1.5,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),

                      // Tombol Aksi Utama
                      _buildActionButton(context, quiz),

                      const SizedBox(height: 12),

                      // Keterangan Pembantu
                      _buildActionHelperText(context, quiz),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, QuizProvider quiz) {
    if (quiz.isQuizCompleted) {
      return PrimaryButton(
        label: 'Lihat Hasil Kuis',
        icon: Icons.emoji_events_rounded,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/result');
        },
      );
    }

    if (!quiz.isAnswerConfirmed) {
      return PrimaryButton(
        label: 'Pilih salah satu jawaban',
        icon: Icons.touch_app_rounded,
        onPressed: null,
      );
    }

    // Jawaban sudah dijawab, lanjut ke soal berikutnya atau ke hasil.
    final isLastQuestion =
        quiz.currentQuestionIndex == quiz.questionCount - 1;

    return PrimaryButton(
      label: isLastQuestion ? 'Lihat Hasil Kuis' : 'Soal Berikutnya',
      icon: isLastQuestion
          ? Icons.emoji_events_rounded
          : Icons.arrow_forward_rounded,
      onPressed: () {
        final provider = context.read<QuizProvider>();
        final moved = provider.goToNextQuestion();

        if (isLastQuestion || provider.isQuizCompleted || !moved) {
          Navigator.of(context).pushReplacementNamed('/result');
        }
      },
    );
  }

  Widget _buildActionHelperText(BuildContext context, QuizProvider quiz) {
    final colors = Theme.of(context).colorScheme;
    final isLastQuestion =
        quiz.currentQuestionIndex == quiz.questionCount - 1;

    String text;
    if (quiz.isQuizCompleted) {
      text =
          'Kuis selesai! Skor akhir: ${quiz.score}/${quiz.questionCount}.';
    } else if (quiz.isAnswerConfirmed) {
      text = isLastQuestion
          ? 'Jawaban sudah dinilai. Ketuk Lihat Hasil Kuis untuk melihat skor.'
          : 'Jawaban sudah dinilai. Ketuk Soal Berikutnya.';
    } else {
      text = 'Ketuk salah satu pilihan di atas untuk langsung menjawab.';
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.5,
          ),
    );
  }
}
