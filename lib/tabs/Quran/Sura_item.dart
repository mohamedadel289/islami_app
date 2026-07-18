import 'package:flutter/material.dart';
import 'package:islami/tabs/Quran/sura.dart';

class SuraItem extends StatelessWidget {
  Sura sura;
  SuraItem(this.sura, {super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/sura_num.png'),
              fit: BoxFit.scaleDown,
            ),
          ),
          child: Center(child: Text('${sura.num}', style: textTheme.titleSmall)),),
        SizedBox(width: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sura.nameEN, style: textTheme.titleLarge),
            Text('${sura.ayatCount} verses', style: textTheme.titleSmall),
            
          ],
        ),
        Spacer(),
        Text(sura.nameAR, style: textTheme.titleLarge,),
      ],
    );
  }
}
