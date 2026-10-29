import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/Quran/quran_services.dart';
import 'package:islami/tabs/radio/radio_service.dart';

class SurahPickerSheet extends StatefulWidget {
  final Reciter reciter;
  final void Function(Moshaf moshaf, int surahNumber) onSelect;

  const SurahPickerSheet({
    super.key,
    required this.reciter,
    required this.onSelect,
  });

  static String surahName(int number) => (number >= 1 && number <= 114)
      ? QuranServices.suranameAR[number - 1]
      : 'Surah $number';

  @override
  State<SurahPickerSheet> createState() => _SurahPickerSheetState();
}

class _SurahPickerSheetState extends State<SurahPickerSheet> {
  int moshafIndex = 0;

  @override
  Widget build(BuildContext context) {
    final moshafs = widget.reciter.moshafs;
    final moshaf = moshafs[moshafIndex];
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(widget.reciter.name, style: textTheme.titleLarge),
          if (moshafs.length > 1)
            SizedBox(
              height: 56,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                itemCount: moshafs.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (_, i) => ChoiceChip(
                  label: Text(moshafs[i].name),
                  selected: i == moshafIndex,
                  selectedColor: AppTheme.primary,
                  onSelected: (_) => setState(() => moshafIndex = i),
                ),
              ),
            ),
          const Divider(color: AppTheme.primary),
          Expanded(
            child: ListView.builder(
              itemCount: moshaf.surahs.length,
              itemBuilder: (_, i) {
                final number = moshaf.surahs[i];
                return ListTile(
                  leading: Text('$number', style: textTheme.titleMedium),
                  title: Text(
                    SurahPickerSheet.surahName(number),
                    style: textTheme.titleLarge,
                  ),
                  trailing: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppTheme.primary,
                  ),
                  onTap: () => widget.onSelect(moshaf, number),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
