import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

class AzkarEntry {
  final String text;
  final int repetitions;

  const AzkarEntry({required this.text, required this.repetitions});
}

class AzkarDetailsScreen extends StatefulWidget {
  final String title;
  final List<AzkarEntry> azkar;

  const AzkarDetailsScreen({
    super.key,
    required this.title,
    required this.azkar,
  });

  @override
  State<AzkarDetailsScreen> createState() => _AzkarDetailsScreenState();
}

class _AzkarDetailsScreenState extends State<AzkarDetailsScreen> {
  late final List<int> counts = List<int>.filled(widget.azkar.length, 0);

  void increment(int index) {
    if (counts[index] >= widget.azkar[index].repetitions) return;
    setState(() => counts[index]++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: widget.azkar.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final AzkarEntry entry = widget.azkar[index];
          final int count = counts[index];
          final bool isComplete = count == entry.repetitions;

          return Material(
            color: AppTheme.black,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: () => increment(index),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.primary.withValues(alpha: 0.7),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      entry.text,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.primary,
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      isComplete
                          ? 'اكتمل الذكر'
                          : '$count / ${entry.repetitions}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: isComplete ? AppTheme.primary : AppTheme.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
