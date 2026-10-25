import 'package:flutter/material.dart';

class QuizOptionCard extends StatelessWidget {
  const QuizOptionCard({
    super.key,
    required this.index,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final borderColor =
    isSelected ? colors.primary : colors.outlineVariant;

    final backgroundColor =
    isSelected ? colors.primaryContainer : colors.surface;

    final textColor =
    isSelected ? colors.onPrimaryContainer : colors.onSurface;

    final letter = String.fromCharCode(65 + index);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: isSelected ? 1.8 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.primary
                        : colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(
                    letter,
                    style: TextStyle(
                      color: isSelected
                          ? colors.onPrimary
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
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: colors.primary,
                  )
                else
                  Icon(
                    Icons.circle_outlined,
                    color: colors.outlineVariant,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}