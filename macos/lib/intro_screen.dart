import 'package:flutter/material.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/widgets/details_intro_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = 'intro';

  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "assets/images/islami_header.png",
              height: MediaQuery.sizeOf(context).height * 0.2,
              width: MediaQuery.sizeOf(context).width * 0.7,
              fit: BoxFit.scaleDown,
            ),
            Expanded(
              child: PageView.builder(
                itemCount: DetailsIntroScreen.pages.length,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  currentindex = index;
                  setState(() {});
                },
                controller: _pageController,
                itemBuilder: (context, index) =>
                    DetailsIntroScreen.pages[index],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    'Back',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 16),
                  ),

                  onPressed: currentindex == 0 ? null : previousPage,
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: DetailsIntroScreen.pages.length,
                  effect: WormEffect(
                    dotHeight: 7,
                    dotWidth: 7,
                    spacing: 11,
                    dotColor: AppTheme.gray,
                    activeDotColor: AppTheme.primary,
                  ),
                ),
                TextButton(
                  child: Text(
                    currentindex == DetailsIntroScreen.pages.length - 1
                        ? 'Finish'
                        : 'Next',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 16),
                  ),
                  onPressed: currentindex == DetailsIntroScreen.pages.length - 1
                      ? null
                      : nextPage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void nextPage() {
    if (currentindex < DetailsIntroScreen.pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentindex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
