import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/hadeth/hadeth.dart';

class HadethDetailsScreen extends StatelessWidget {
  static const String routeName = '/hadeth-details';

  const HadethDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Hadeth hadeth = ModalRoute.of(context)!.settings.arguments as Hadeth;
    double screenHeight = MediaQuery.sizeOf(context).height;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Hadeth ${hadeth.num}')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Image.asset(
                  'assets/images/details_left_corner.png',
                  height: screenHeight * 0.1,
                  fit: .fill,
                ),
                Text(
                  hadeth.title,
                  style: textTheme.headlineSmall?.copyWith(
                    color: AppTheme.primary,
                  ),
                ),
                Image.asset(
                  'assets/images/details_right_corner.png',
                  height: screenHeight * 0.1,
                  fit: .fill,
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) => Text(
                  hadeth.content[index],
                  style: textTheme.titleLarge?.copyWith(
                    color: AppTheme.primary,
                  ),
                  textAlign: .center,
                ),
                itemCount: hadeth.content.length,
                separatorBuilder: (_, _) => SizedBox(height: 4),
              ),
            ),
            Image.asset(
              'assets/images/details_footer.png',
              height: screenHeight * 0.11,
              width: double.infinity,
              fit: .fill,
            ),
          ],
        ),
      ),
    );
  }
}
