import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/hadeth/hadeth.dart';
import 'package:islami/tabs/hadeth/hadeth_details_screen.dart';
import 'package:islami/widgets/loading_indictor.dart';

class HadethItem extends StatefulWidget {
  final int index;

  const HadethItem({super.key, required this.index});

  @override
  State<HadethItem> createState() => _HadethItemState();
}

class _HadethItemState extends State<HadethItem> {
  Hadeth? hadeth;

  @override
  void initState() {
    super.initState();
    loadHadeth();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        if (hadeth == null) return; // لسه بيحمّل
        Navigator.of(
          context,
        ).pushNamed(HadethDetailsScreen.routeName, arguments: hadeth);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/hadeth_left_corner.png',
                    height: screenHeight * 0.1,
                    fit: .fill,
                  ),
                  if (hadeth != null)
                    Expanded(
                      child: Text(
                        hadeth!.title,
                        style: textTheme.headlineSmall,
                        textAlign: .center,
                      ),
                    ),
                  Image.asset(
                    'assets/images/hadeth_right_corner.png',
                    height: screenHeight * 0.1,
                    fit: .fill,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/hadeth_card_background.png',
                    ),
                  ),
                ),
                child: hadeth == null
                    ? LoadingIndictor()
                    : ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemBuilder: (_, index) => Text(
                          hadeth!.content[index],
                          style: textTheme.titleMedium?.copyWith(
                            color: AppTheme.black,
                          ),
                          textAlign: .center,
                        ),
                        separatorBuilder: (_, _) => SizedBox(height: 4),
                        itemCount: hadeth!.content.length,
                      ),
              ),
            ),
            Image.asset(
              'assets/images/hadeth_footer.png',
              width: double.infinity,
              fit: .fill,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadHadeth() async {
    final String fileContent = await rootBundle.loadString(
      'assets/text/h${widget.index + 1}.txt',
    );
    final List<String> lines = const LineSplitter().convert(fileContent);
    if (!mounted) return;
    setState(() {
      hadeth = Hadeth(
        title: lines.first,
        content: lines.skip(1).toList(),
        num: widget.index + 1,
      );
    });
  }
}
