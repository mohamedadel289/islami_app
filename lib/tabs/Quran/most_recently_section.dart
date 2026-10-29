import 'package:flutter/material.dart';
import 'package:islami/tabs/Quran/most_recently_item.dart';
import 'package:islami/tabs/Quran/quran_services.dart';

class MostRecentlySection extends StatelessWidget {
  const MostRecentlySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, bottom: 16),
      child: Visibility(
        visible: QuranServices.mostRecentlyRead.isNotEmpty,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Most Recently',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.18,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => MostRecentlyItem(
                  sura: QuranServices.mostRecentlyRead.reversed.toList()[index],
                ),
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemCount: QuranServices.mostRecentlyRead.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
