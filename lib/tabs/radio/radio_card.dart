import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/radio/waveform.dart';

class RadioCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isPlaying;
  final bool isLoading;
  final bool isMuted;
  final VoidCallback onPlayTap;
  final VoidCallback onVolumeTap;
  final VoidCallback? onTap;

  const RadioCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.isPlaying,
    this.isLoading = false,
    required this.isMuted,
    required this.onPlayTap,
    required this.onVolumeTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Waveform(animated: isPlaying),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(color: AppTheme.dark),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.dark.withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: onPlayTap,
                        child: SizedBox(
                          width: 36,
                          height: 36,
                          child: isLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppTheme.dark,
                                  ),
                                )
                              : Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: AppTheme.dark,
                                  size: 36,
                                ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onVolumeTap,
                        child: Icon(
                          isMuted ? Icons.volume_off : Icons.volume_up,
                          color: AppTheme.dark,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
