import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

class RadioToggleButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const RadioToggleButton({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primary
              : AppTheme.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.primary),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: selected ? AppTheme.black : AppTheme.white,
          ),
        ),
      ),
    );
  }
}
