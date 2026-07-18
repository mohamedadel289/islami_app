import 'package:flutter/material.dart';
import 'package:islami/tabs/Quran/Sura_item.dart';
import 'package:islami/tabs/Quran/quran_services.dart';
import 'package:islami/tabs/Quran/sura_details_screen.dart';

class QuranTab extends StatelessWidget {
  const QuranTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 10),
          child: Text(
            'Suras List',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (_, index) => GestureDetector(
              onTap: () => Navigator.pushNamed(context, SuraDetailsScreen.routeName,
                  arguments: QuranServices.getsuraforindex(index)),
              child: SuraItem(
                QuranServices.getsuraforindex(index),
              ),
            ),
            separatorBuilder: (context, index) =>
                Divider(indent: 40, endIndent: 40, thickness: 1, height: 20),
            itemCount: 114,
          ),
        ),
      ],
    );
  }
}
