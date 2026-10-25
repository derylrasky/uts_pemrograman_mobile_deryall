import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_screen.dart';

import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/app_logo.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/theme_toggle_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final useWideLayout = width >= Responsive.tabletBreakpoint;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.pagePaddingForWidth(width),
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.contentMaxWidth(width),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Align(
                        alignment: Alignment.centerRight,
                        child: ThemeToggleButton(),
                      ),
                      const SizedBox(height: 20),

                      if (useWideLayout)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: _WelcomePanel(expanded: true),
                            ),
                            const SizedBox(width: 28),
                            Expanded(
                              child: _buildNameCard(
                                context,
                                quiz.playerName,
                                quiz.questionCount,
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            const _WelcomePanel(expanded: false),
                            const SizedBox(height: 28),
                            _buildNameCard(
                              context,
                              quiz.playerName,
                              quiz.questionCount,
                            ),
                          ],
                        ),

                      const SizedBox(height: 28),

                      Text(
                        'REELQUIZ  •  FILM & SERIES TRIVIA',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          letterSpacing: 1.2,
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

  Widget _buildNameCard(
    BuildContext context,
    String playerName,
    int questionCount,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: Theme.of(context).brightness == Brightness.light ? 1 : 0,
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 24 : 28),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mulai petualanganmu',
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Text(
                'Masukkan nama untuk mempersiapkan sesi kuis kamu.',
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: colors.onSurfaceVariant, height: 1.6),
              ),
              const SizedBox(height: 28),

              AppTextField(
                initialValue: playerName,
                label: 'Nama pemain',
                hint: 'Contoh: Rendy',
                onChanged: (value) {
                  context.read<QuizProvider>().setPlayerName(value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama tidak boleh kosong.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              PrimaryButton(
                label: 'Mulai Kuis',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  final isValid =
                      _formKey.currentState?.validate() ?? false;

                  if (!isValid) return;

                  final provider = context.read<QuizProvider>();
                  final started = provider.startQuiz();

                  if (!started) return;

                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const QuizScreen(),
                    ),
                  );
                },


              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Icon(
                    Icons.movie_filter_rounded,
                    size: 19,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '$questionCount pertanyaan tersedia',
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ),
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 18,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Data lokal',
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomePanel extends StatelessWidget {
  const _WelcomePanel({required this.expanded});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (expanded) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(iconSize: 58, lightOnDark: true),
            const SizedBox(height: 40),
            Text(
              'Kenali ceritanya.\nBuktikan ingatanmu.',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tantang ingatanmu tentang karakter, '
              'adegan, dan cerita dari film serta serial favorit.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 28),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _FeaturePill(label: 'Film'),
                _FeaturePill(label: 'Series'),
                _FeaturePill(label: 'Pilihan ganda'),
              ],
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AppLogo(iconSize: 64),
        const SizedBox(height: 24),
        Text(
          'Seberapa kenal kamu\ndengan dunia film?',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Text(
            'Uji ingatanmu tentang film dan serial favorit. '
            'Siapkan diri dan buktikan pengetahuanmu!',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.7,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeaturePill extends StatelessWidget {
  const _FeaturePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withAlpha(65)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
