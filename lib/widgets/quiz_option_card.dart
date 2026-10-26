import 'package:flutter/material.dart';

class QuizOptionCard extends StatelessWidget {
  const QuizOptionCard({
    super.key,
    required this.index,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isCorrect = false,
    this.showResult = false,
    this.enabled = true,
  });

  final int index;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  final bool isCorrect;
  final bool showResult;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final showCorrect = showResult && isCorrect;
    final showIncorrect = showResult && isSelected && !isCorrect;

    final Color borderColor = showCorrect
        ? Colors.green.shade700
        : showIncorrect
        ? colors.error
        : isSelected
        ? colors.primary
        : colors.outlineVariant;

    final Color backgroundColor = showCorrect
        ? Colors.green.withAlpha(24)
        : showIncorrect
        ? colors.error.withAlpha(20)
        : isSelected
        ? colors.primaryContainer
        : colors.surface;

    final Color textColor =
    isSelected && !showResult
        ? colors.onPrimaryContainer
        : colors.onSurface;

    final String letter = String.fromCharCode(65 + index);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: showCorrect || showIncorrect || isSelected
              ? 1.8
              : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: showCorrect
                        ? Colors.green.shade700
                        : showIncorrect
                        ? colors.error
                        : isSelected
                        ? colors.primary
                        : colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(
                    letter,
                    style: TextStyle(
                      color: showCorrect || showIncorrect || isSelected
                          ? Colors.white
                          : colors.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: textColor,
                      fontWeight: isSelected || showCorrect
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
                if (showCorrect)
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green.shade700,
                  )
                else if (showIncorrect)
                  Icon(
                    Icons.cancel_rounded,
                    color: colors.error,
                  )
                else
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: isSelected
                        ? colors.primary
                        : colors.outlineVariant,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}