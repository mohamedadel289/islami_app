import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/Quran/Sura_item.dart';
import 'package:islami/tabs/Quran/most_recently_section.dart';
import 'package:islami/tabs/Quran/quran_services.dart';
import 'package:islami/tabs/Quran/sura.dart';
import 'package:islami/tabs/Quran/sura_details_screen.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: TextField(
            style: Theme.of(context).textTheme.titleSmall,
            decoration: InputDecoration(
              prefixIcon: SvgPicture.asset(
                'assets/icons/Quran.svg',
                width: 28,
                height: 28,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  AppTheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              hintText: 'Sura Name',
            ),
            onChanged: (qurey) {
              QuranServices.searchsura(qurey);
              setState(() {});
            },
          ),
        ),
        MostRecentlySection(),
        Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 10),
          child: Text(
            'Suras List',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (_, index) {
              Sura sura = QuranServices.suraReslut[index];
              return GestureDetector(
                onTap: () {
                  QuranServices.addMostrecentlyread(sura);
                  Navigator.pushNamed(
                    context,
                    SuraDetailsScreen.routeName,
                    arguments: sura,
                  );

                  setState(() {});
                },
                child: SuraItem(sura),
              );
            },
            separatorBuilder: (context, index) =>
                Divider(indent: 40, endIndent: 40, thickness: 1, height: 20),
            itemCount: QuranServices.suraReslut.length,
          ),
        ),
      ],
    );
  }
}
