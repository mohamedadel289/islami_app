import 'dart:async';

import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/Quran/quran_services.dart';
import 'package:islami/tabs/Quran/sura.dart';
import 'package:islami/widgets/loading_indictor.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const String routeName = 'sura_details';

  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  late Sura sura;

  List<String> ayat = [];

  @override
  Widget build(BuildContext context) {
    sura = ModalRoute.of(context)?.settings.arguments as Sura;
    if (ayat.isEmpty) {
      readsura();
    }
    double screenheight = MediaQuery.of(context).size.height;
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(sura.nameEN)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/img_left_corner.png',
                  width: 93,
                  height: screenheight * 0.1,
                  fit: BoxFit.fill,
                ),
                Text(sura.nameAR, style: themeData.textTheme.titleMedium),
                Image.asset(
                  'assets/images/img_right_corner.png',
                  width: 93,
                  height: screenheight * 0.1,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          Expanded(
            child: ayat.isEmpty
                ? LoadingIndictor()
                : ListView.separated(
                    itemBuilder: (context, index) => Text(
                      ayat[index],
                      textAlign: TextAlign.center,
                      style: themeData.textTheme.titleSmall?.copyWith(
                        color: AppTheme.primary,
                      ),
                    ),
                    itemCount: ayat.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 5),
                  ),
          ),
          Image.asset(
            'assets/images/img_bottom_decoration.png',
            width: double.infinity,
            height: screenheight * 0.1,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  Future<void> readsura() async {
    String suraContent = await QuranServices.readsurafilecontent(sura.num);
    ayat = suraContent.split('\r\n');
    setState(() {});
  }
}
