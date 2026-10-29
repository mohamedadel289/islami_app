import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

class AzkarCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final IconData fallbackIcon;
  final VoidCallback onTap;

  const AzkarCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.fallbackIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.primary,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.white.withValues(alpha: 0.6)),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 90,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  // Shown until the azkar images are added to assets/images/
                  errorBuilder: (_, _, _) =>
                      Icon(fallbackIcon, size: 64, color: AppTheme.black),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
