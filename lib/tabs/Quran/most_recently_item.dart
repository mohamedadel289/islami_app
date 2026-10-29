import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/Quran/sura.dart';

class MostRecentlyItem extends StatelessWidget {
  Sura sura;
  MostRecentlyItem({super.key, required this.sura});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12.0, right: 8.0),
      margin: EdgeInsets.only(right: 2),
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.width * 0.72,
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sura.nameEN,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: AppTheme.dark),
                ),
                Text(
                  sura.nameAR,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: AppTheme.dark),
                ),
                SizedBox(height: 8),
                Text(
                  '${sura.ayatCount} Ayat',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: AppTheme.dark),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/img_most_recent.png',
            height: MediaQuery.of(context).size.height * 0.17,
            width: MediaQuery.of(context).size.width * 0.39,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
