import 'dart:convert';
import 'package:http/http.dart' as http;

class RadioStation {
  final int id;
  final String name;
  final String url;

  const RadioStation({required this.id, required this.name, required this.url});

  factory RadioStation.fromJson(Map<String, dynamic> json) => RadioStation(
    id: json['id'],
    // بعض الأسماء فيها - أو * في الأول أو الآخر
    name: (json['name'] as String).replaceAll(
      RegExp(r'^[\s\-*]+|[\s\-*]+$'),
      '',
    ),
    url: json['url'],
  );
}

class Moshaf {
  final int id;
  final String name;
  final String server;
  final List<int> surahs;

  const Moshaf({
    required this.id,
    required this.name,
    required this.server,
    required this.surahs,
  });

  factory Moshaf.fromJson(Map<String, dynamic> json) {
    String server = json['server'] ?? '';
    if (!server.endsWith('/')) server = '$server/';
    return Moshaf(
      id: json['id'],
      name: json['name'] ?? '',
      server: server,
      surahs: (json['surah_list'] as String? ?? '')
          .split(',')
          .map(int.tryParse)
          .whereType<int>()
          .toList(),
    );
  }

  String surahUrl(int number) =>
      '$server${number.toString().padLeft(3, '0')}.mp3';
}

class Reciter {
  final int id;
  final String name;
  final List<Moshaf> moshafs;

  const Reciter({required this.id, required this.name, required this.moshafs});

  factory Reciter.fromJson(Map<String, dynamic> json) => Reciter(
    id: json['id'],
    name: json['name'] ?? '',
    moshafs: (json['moshaf'] as List? ?? [])
        .map((m) => Moshaf.fromJson(m))
        .toList(),
  );
}

class RadioService {
  static Future<Map<String, dynamic>> _get(String path) async {
    final uri = Uri.https('www.mp3quran.net', path, {'language': 'ar'});
    final response = await http.get(uri).timeout(const Duration(seconds: 20));
    if (response.statusCode != 200) {
      throw Exception('Server error ${response.statusCode}');
    }
    // utf8.decode عشان العربي يظهر صح
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<List<RadioStation>> getRadios() async {
    final data = await _get('/api/v3/radios');
    return (data['radios'] as List)
        .map((e) => RadioStation.fromJson(e))
        .toList();
  }

  static Future<List<Reciter>> getReciters() async {
    final data = await _get('/api/v3/reciters');
    return (data['reciters'] as List)
        .map((e) => Reciter.fromJson(e))
        .where((r) => r.moshafs.isNotEmpty)
        .toList();
  }
}
