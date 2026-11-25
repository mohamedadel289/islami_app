class OnboardingPageModel {
  final String imagePath;
  final bool isLogo;
  final String title;
  final String subtitle;

  const OnboardingPageModel({
    required this.imagePath,
    this.isLogo = false,
    required this.title,
    required this.subtitle,
  });
}
