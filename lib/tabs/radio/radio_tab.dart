import 'package:flutter/material.dart';
import 'package:islami/tabs/radio/radio_card.dart';
import 'package:islami/tabs/radio/radio_service.dart';
import 'package:islami/tabs/radio/radio_toggle_button.dart';
import 'package:islami/tabs/radio/surah_picker_sheet.dart';
import 'package:islami/widgets/loading_indictor.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:islami/app_theme.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  final AudioPlayer player = AudioPlayer();

  late Future<List<RadioStation>> radiosFuture = RadioService.getRadios();
  late Future<List<Reciter>> recitersFuture = RadioService.getReciters();

  bool isRadioSelected = true;
  String? playingKey; // 'radio:ID' أو 'reciter:ID'
  String? playingSubtitle; // اسم السورة للقارئ
  bool muted = false;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void selectTab(bool radio) {
    if (isRadioSelected == radio) return;
    player.stop();
    setState(() {
      isRadioSelected = radio;
      playingKey = null;
      playingSubtitle = null;
    });
  }

  Future<void> togglePause() async {
    // بعد ما الصوت يخلص: نرجع من الأول بدل ما الزرار يفضل "Pause"
    if (player.processingState == ProcessingState.completed) {
      await player.seek(Duration.zero);
      player.play();
    } else {
      player.playing ? player.pause() : player.play();
    }
  }

  void toggleMute() {
    setState(() => muted = !muted);
    player.setVolume(muted ? 0 : 1);
  }

  Future<void> play(
    String key,
    String url, {
    required String title,
    String? artist,
    String? subtitle,
  }) async {
    setState(() {
      playingKey = key;
      playingSubtitle = subtitle;
    });
    try {
      // just_audio_background بيطلب MediaItem tag عشان إشعار التشغيل
      await player.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(id: '$key|$url', title: title, artist: artist),
        ),
      );
      player.play(); // من غير await: بتخلص لما الصوت يخلص
    } catch (_) {
      // لو المستخدم اختار حاجة تانية أثناء التحميل نتجاهل الخطأ
      if (!mounted || playingKey != key) return;
      setState(() {
        playingKey = null;
        playingSubtitle = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not play this audio')),
      );
    }
  }

  void openReciter(Reciter reciter) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.dark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SurahPickerSheet(
        reciter: reciter,
        onSelect: (moshaf, number) {
          Navigator.pop(sheetContext);
          final String surah = SurahPickerSheet.surahName(number);
          play(
            'reciter:${reciter.id}',
            moshaf.surahUrl(number),
            title: surah,
            artist: reciter.name,
            subtitle: surah,
          );
        },
      ),
    );
  }

  Widget buildError(VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Check your internet connection',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.dark,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget buildRadios(bool playing, bool loading) {
    return FutureBuilder<List<RadioStation>>(
      future: radiosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndictor();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return buildError(
            () => setState(() => radiosFuture = RadioService.getRadios()),
          );
        }
        final radios = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
          itemCount: radios.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (_, index) {
            final station = radios[index];
            final key = 'radio:${station.id}';
            final active = playingKey == key;
            return RadioCard(
              title: station.name,
              isPlaying: active && playing,
              isLoading: active && loading,
              isMuted: muted,
              onPlayTap: () => active
                  ? togglePause()
                  : play(key, station.url, title: station.name),
              onVolumeTap: toggleMute,
            );
          },
        );
      },
    );
  }

  Widget buildReciters(bool playing, bool loading) {
    return FutureBuilder<List<Reciter>>(
      future: recitersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingIndictor();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return buildError(
            () => setState(() => recitersFuture = RadioService.getReciters()),
          );
        }
        final reciters = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
          itemCount: reciters.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (_, index) {
            final reciter = reciters[index];
            final key = 'reciter:${reciter.id}';
            final active = playingKey == key;
            return RadioCard(
              title: reciter.name,
              subtitle: active ? playingSubtitle : null,
              isPlaying: active && playing,
              isLoading: active && loading,
              isMuted: muted,
              // الضغط على الكارت نفسه يفتح قائمة السور (لتغيير السورة)
              onTap: () => openReciter(reciter),
              onPlayTap: () => active ? togglePause() : openReciter(reciter),
              onVolumeTap: toggleMute,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        final playing =
            (state?.playing ?? false) &&
            state?.processingState != ProcessingState.completed;
        final loading =
            state?.processingState == ProcessingState.loading ||
            state?.processingState == ProcessingState.buffering;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  Expanded(
                    child: RadioToggleButton(
                      title: 'Radio',
                      selected: isRadioSelected,
                      onTap: () => selectTab(true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RadioToggleButton(
                      title: 'Reciters',
                      selected: !isRadioSelected,
                      onTap: () => selectTab(false),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isRadioSelected
                  ? buildRadios(playing, loading)
                  : buildReciters(playing, loading),
            ),
          ],
        );
      },
    );
  }
}
