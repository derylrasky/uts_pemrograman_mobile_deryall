
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_logo.dart';
import '../widgets/primary_button.dart';
import '../widgets/result_stat_card.dart';
import '../widgets/theme_toggle_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final colors = Theme.of(context).colorScheme;

    final total = quiz.questionCount;
    final score = quiz.score;

    final percentage =
    total == 0 ? 0 : (score * 100 / total).round();

    final isWide =
        MediaQuery.sizeOf(context).width >=
            Responsive.tabletBreakpoint;

    final message = percentage >= 80
        ? 'Luar biasa! Kamu sangat mengenal dunia film.'
        : percentage >= 50
        ? 'Bagus! Pengetahuan filmmu sudah cukup baik.'
        : 'Terus berlatih dan coba tantang dirimu lagi!';

    final stats = [
      ResultStatCard(
        label: 'Jawaban benar',
        value: '$score',
        icon: Icons.check_circle_outline_rounded,
      ),
      ResultStatCard(
        label: 'Total pertanyaan',
        value: '$total',
        icon: Icons.quiz_outlined,
      ),
      ResultStatCard(
        label: 'Akurasi',
        value: '$percentage%',
        icon: Icons.track_changes_rounded,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.pagePaddingForWidth(width),
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.readingContentMaxWidth(width),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header aplikasi.
                      Row(
                        children: [
                          const Expanded(
                            child: AppLogo(iconSize: 48),
                          ),
                          const ThemeToggleButton(),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Ringkasan hasil.
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(
                          width < Responsive.mobileBreakpoint
                              ? 24
                              : 36,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: colors.outlineVariant,
                          ),
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/trophy.svg',
                              width: 112,
                              height: 112,
                              semanticsLabel: 'Ilustrasi piala kuis',
                            ),

                            const SizedBox(height: 20),

                            Text(
                              'Kuis Selesai!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                color: colors.onPrimaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              'Kerja bagus, ${quiz.playerName}!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                color: colors.onPrimaryContainer,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              message,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                color: colors.onPrimaryContainer,
                                height: 1.6,
                              ),
                            ),

                            const SizedBox(height: 28),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '$score',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                    color: colors.onPrimaryContainer,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '/ $total poin',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                    color: colors.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: LinearProgressIndicator(
                                value: percentage / 100,
                                minHeight: 9,
                                backgroundColor:
                                colors.onPrimaryContainer.withAlpha(30),
                                color: colors.primary,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              '$percentage% jawaban benar',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                color: colors.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      Text(
                        'RINGKASAN HASIL',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(
                          color: colors.onSurfaceVariant,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 14),

                      if (isWide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < stats.length; i++) ...[
                              if (i > 0) const SizedBox(width: 12),
                              Expanded(child: stats[i]),
                            ],
                          ],
                        )
                      else
                        Column(
                          children: [
                            for (int i = 0; i < stats.length; i++) ...[
                              if (i > 0) const SizedBox(height: 12),
                              stats[i],
                            ],
                          ],
                        ),

                      const SizedBox(height: 28),

                      // Mulai sesi baru dengan skor dari nol.
                      PrimaryButton(
                        label: 'Main Lagi',
                        icon: Icons.replay_rounded,
                        onPressed: () {
                          final provider = context.read<QuizProvider>();

                          if (!provider.startQuiz()) return;

                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                            '/quiz',
                                (route) => route.isFirst,
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      // Kembali ke halaman awal.
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            final navigator = Navigator.of(context);

                            context.read<QuizProvider>().resetQuiz();

                            navigator.popUntil(
                                  (route) => route.isFirst,
                            );
                          },
                          icon: const Icon(Icons.home_rounded),
                          label: const Text('Kembali ke Beranda'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(54),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      Text(
                        'REELQUIZ • FILM & SERIES TRIVIA',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.onSurfaceVariant,
                          letterSpacing: 1,
                        ),
                      ),
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
}
