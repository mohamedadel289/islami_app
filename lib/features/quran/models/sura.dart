class Sura {
  final String nameEN;
  final String nameAR;
  final int ayatCount;
  final int num;
  const Sura({
    required this.nameEN,
    required this.nameAR,
    required this.ayatCount,
    required this.num,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sura && runtimeType == other.runtimeType && num == other.num;

  @override
  int get hashCode => num.hashCode;
}
