import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';

class DetailsIntroScreen extends StatelessWidget {
  final String image;
  final String text;
  final String descp;
  const DetailsIntroScreen({
    required this.text,
    required this.image,
    this.descp = '',
  });

  static const List<DetailsIntroScreen> pages = [
    DetailsIntroScreen(
      text: 'Welcome To Islmi App',
      image: 'welcom',
      descp: '',
    ),
    DetailsIntroScreen(
      text: 'Welcome To Islami',
      image: 'kabba',
      descp: 'We Are Very Excited To Have You In Our Community',
    ),
    DetailsIntroScreen(
      text: 'Reading the Quran',
      image: 'quran',
      descp: 'Read, and your Lord is the Most Generous',
    ),
     DetailsIntroScreen(
      text: 'Holy Quran Radio',
      image: 'radio',
      descp:
          'You can listen to the Holy Quran Radio through the application for free and easily',
    ),
    DetailsIntroScreen(
      text: 'Bearish',
      image: 'bearis',
      descp: 'Praise the name of your Lord, the Most High',
    ),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/$image.png'),
        SizedBox(height: 39.75),
        Text(text, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 39.75),
        Text(
          descp,
          textAlign: .center,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppTheme.primary),
        ),
    
      ],
    );
  }
}
