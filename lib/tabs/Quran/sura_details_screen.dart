import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/Quran/sura.dart';

class SuraDetailsScreen extends StatelessWidget {
 static const String routeName = 'sura_details';

  @override
  Widget build(BuildContext context) {
    Sura sura = ModalRoute.of(context)?.settings.arguments as Sura;
    double screenheight = MediaQuery.of(context).size.height;
    ThemeData themeData = Theme.of(context);
    return Scaffold(
       appBar: AppBar(
        title: Text(sura.nameEN,),
      ),
      body:Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Image.asset('assets/images/img_left_corner.png',
            width: 93,
            height: screenheight*0.1,
            fit: BoxFit.fill,),
            Text(sura.nameAR,style: themeData.textTheme.titleMedium,),
            Image.asset('assets/images/img_right_corner.png',
            width: 93,
            height: screenheight*0.1,
            fit: BoxFit.fill,),
          ],),
        ),
        Expanded(
          child: ListView.builder(itemBuilder:(context,index)=>
           Text('data',textAlign: TextAlign.center,style: themeData.textTheme.titleSmall?.copyWith(color: AppTheme.primary),),
            itemCount: 114,
          ),
        ),
        Image.asset('assets/images/img_bottom_decoration.png',
            width: double.infinity,
            height: screenheight*0.1,
            fit: BoxFit.fill,),
      ],)
    );
  }
}