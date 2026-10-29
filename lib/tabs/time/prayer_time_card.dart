import 'dart:async';
import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/time/prayer_box.dart';
import 'package:islami/tabs/time/time_service.dart';

class PrayerTimeCard extends StatefulWidget {
  final PrayerDay day;

  /// بيتنادى لما اليوم يتغير (بعد منتصف الليل) عشان نجيب مواقيت اليوم الجديد
  final VoidCallback onDayChanged;

  const PrayerTimeCard({
    super.key,
    required this.day,
    required this.onDayChanged,
  });

  @override
  State<PrayerTimeCard> createState() => _PrayerTimeCardState();
}

class _PrayerTimeCardState extends State<PrayerTimeCard> {
  late int nextIndex = widget.day.nextIndex(DateTime.now());
  late int current = nextIndex;
  late final PageController controller = PageController(
    initialPage: nextIndex,
    viewportFraction: 0.32,
  );
  Timer? timer;
  final int startDay = DateTime.now().day;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(minutes: 1), (_) => tick());
  }

  void tick() {
    if (!mounted) return;
    if (DateTime.now().day != startDay) {
      widget.onDayChanged();
      return;
    }
    final newNext = widget.day.nextIndex(DateTime.now());
    if (newNext != nextIndex) {
      // دخلت صلاة جديدة: نحرّك الكاروسيل للصلاة الجاية
      nextIndex = newNext;
      if (controller.hasClients) {
        controller.animateToPage(
          newNext,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    }
    setState(() {}); // يحدّث العدّاد
  }

  String get nextIn {
    final d = widget.day.remaining(DateTime.now());
    final totalMinutes = (d.inSeconds / 60).ceil().clamp(0, 99 * 60);
    final h = (totalMinutes ~/ 60).toString().padLeft(2, '0');
    final m = (totalMinutes % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: AppTheme.black,
    );

    final Color notchColor = Color.alphaBlend(
      AppTheme.black.withValues(alpha: 0.12),
      AppTheme.primary,
    );

    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, top: 12),
                  child: Text(widget.day.gregorianText, style: textStyle),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: notchColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  children: [
                    const Text('Pray Time', style: textStyle),
                    Text(
                      widget.day.weekday,
                      style: textStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 18, top: 12),
                  child: Text(
                    widget.day.hijriText,
                    style: textStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 124,
            child: PageView.builder(
              controller: controller,
              itemCount: widget.day.prayers.length,
              onPageChanged: (i) => setState(() => current = i),
              itemBuilder: (context, i) => Center(
                child: PrayerBox(
                  prayer: widget.day.prayers[i],
                  selected: i == current,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                Text(
                  'Next Pray - $nextIn',
                  style: textStyle.copyWith(fontSize: 13),
                ),
                const Icon(
                  Icons.volume_up_rounded,
                  color: AppTheme.black,
                  size: 22,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
