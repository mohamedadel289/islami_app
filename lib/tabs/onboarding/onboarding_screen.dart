import 'package:flutter/material.dart';
import 'package:islami/Home_Screen.dart';
import 'package:islami/app_theme.dart';
import 'package:islami/tabs/onboarding/onboarding_page_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageModel> _pages = [
    OnboardingPageModel(
      imagePath: 'assets/images/Frame1.png',
      //isLogo: true,
      title: 'Welcome To Islami App',
      subtitle: 'Your companion for Quran, Hadeth, Sebha and prayer times',
    ),
    OnboardingPageModel(
      imagePath: 'assets/images/Frame2.png',
      title: 'Welcome To Islami',
      subtitle: 'We Are Very Excited To Have You In Our Community',
    ),
    OnboardingPageModel(
      imagePath: 'assets/images/Frame3.png',
      title: 'Reading the Quran',
      subtitle: 'Read, and your Lord is the Most Generous',
    ),
    OnboardingPageModel(
      imagePath: 'assets/images/Frame4.png',
      title: 'Sebha',
      subtitle: 'Praise the name of your Lord, the Most High',
    ),
    OnboardingPageModel(
      imagePath: 'assets/images/Frame5.png',
      title: 'Holy Quran Radio',
      subtitle:
          'You can listen to the Holy Quran Radio through the application for free and easily',
    ),
  ];

  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _onBackPressed() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLast = _currentPage == _pages.length - 1;
    final bool isFirst = _currentPage == 0;

    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: SafeArea(
        child: Column(
          children: [
            // Header — Islami logo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  const SizedBox(width: 70),
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/islami_header.png',
                        height: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: isLast
                        ? const SizedBox()
                        : TextButton(
                            onPressed: _finishOnboarding,
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: AppTheme.white.withValues(alpha: 0.75),
                                fontSize: 14,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) =>
                    _OnboardingPage(page: _pages[index]),
              ),
            ),

            // Dots + buttons row
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  SizedBox(
                    width: 70,
                    child: isFirst
                        ? const SizedBox()
                        : TextButton(
                            onPressed: _onBackPressed,
                            child: const Text(
                              'Back',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                  ),

                  // Dots
                  Row(
                    children: List.generate(
                      _pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == i ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == i
                              ? AppTheme.primary
                              : AppTheme.primary.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  // Next / Finish button
                  SizedBox(
                    width: 70,
                    child: TextButton(
                      onPressed: _onNextPressed,
                      child: Text(
                        isLast ? 'Finish' : 'Next',
                        style: const TextStyle(
                          color: AppTheme.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingPageModel page;

  const _OnboardingPage({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: page.isLogo
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App icon placeholder for the first screen
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: AppTheme.primary.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Image.asset(
                              'assets/images/splash_logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Arabic calligraphy / branding for first screen
                        Image.asset(
                          'assets/images/branding.png',
                          height: 180,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const SizedBox(),
                        ),
                      ],
                    )
                  : Image.asset(page.imagePath, fit: BoxFit.contain),
            ),
          ),

          // Title
          Text(
            page.title,
            style: const TextStyle(
              color: AppTheme.primary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Subtitle
          Text(
            page.subtitle,
            style: TextStyle(
              color: AppTheme.white.withValues(alpha: 0.75),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
