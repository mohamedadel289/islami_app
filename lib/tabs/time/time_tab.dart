import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/time/azkar_card.dart';
import 'package:islami/tabs/time/azkar_details_screen.dart';
import 'package:islami/tabs/time/prayer_time_card.dart';
import 'package:islami/tabs/time/time_service.dart';
import 'package:islami/widgets/loading_indictor.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  late Future<PrayerDay> future = TimeService.getPrayerDay();

  void retry() {
    setState(() => future = TimeService.getPrayerDay());
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return FutureBuilder<PrayerDay>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndictor();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Check your internet connection',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: retry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: AppTheme.black,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final day = snapshot.data!;
        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrayerTimeCard(day: day, onDayChanged: retry),
              SizedBox(height: 20),
              Text('Azkar', style: textTheme.titleMedium),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AzkarCard(
                      title: 'Evening Azkar',
                      imagePath: 'assets/images/bell-icon 1.png',
                      fallbackIcon: Icons.nights_stay_rounded,
                      onTap: () => openAzkar(context, isMorning: false),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: AzkarCard(
                      title: 'Morning Azkar',
                      imagePath: 'assets/images/comment-bubble-icon 1.png',
                      fallbackIcon: Icons.wb_sunny_rounded,
                      onTap: () => openAzkar(context, isMorning: true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void openAzkar(BuildContext context, {required bool isMorning}) {
    final String title = isMorning ? 'Morning Azkar' : 'Evening Azkar';
    final String timePhrase = isMorning
        ? 'أصبحنا وأصبح الملك لله'
        : 'أمسينا وأمسى الملك لله';
    final String dayPhrase = isMorning ? 'هذا اليوم' : 'هذه الليلة';
    final String afterPhrase = isMorning ? 'ما بعده' : 'ما بعدها';
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => AzkarDetailsScreen(
          title: title,
          azkar: [
            AzkarEntry(
              text:
                  '$timePhrase، والحمد لله، لا إله إلا الله وحده لا شريك له، '
                  'له الملك وله الحمد وهو على كل شيء قدير. رب أسألك خير $dayPhrase '
                  'وخير $afterPhrase، وأعوذ بك من شر $dayPhrase وشر $afterPhrase. '
                  'رب أعوذ بك من الكسل وسوء الكبر، رب أعوذ بك من عذاب في النار '
                  'وعذاب في القبر.',
              repetitions: 1,
            ),
            const AzkarEntry(
              text:
                  'رضيت بالله رباً، وبالإسلام ديناً، وبمحمد صلى الله عليه وسلم نبياً.',
              repetitions: 3,
            ),
            const AzkarEntry(
              text:
                  'بسم الله الذي لا يضر مع اسمه شيء في الأرض ولا في السماء '
                  'وهو السميع العليم.',
              repetitions: 3,
            ),
            AzkarEntry(
              text: isMorning
                  ? 'اللهم بك أصبحنا وبك أمسينا، وبك نحيا وبك نموت، وإليك النشور.'
                  : 'اللهم بك أمسينا وبك أصبحنا، وبك نحيا وبك نموت، وإليك المصير.',
              repetitions: 1,
            ),
            const AzkarEntry(text: 'سبحان الله وبحمده.', repetitions: 100),
          ],
        ),
      ),
    );
  }
}
