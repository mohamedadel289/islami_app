import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:islami/tabs/time/prayer.dart';

class PrayerDay {
  final List<Prayer> prayers;
  final String gregorianText;
  final String weekday;
  final String hijriText;

  const PrayerDay({
    required this.prayers,
    required this.gregorianText,
    required this.weekday,
    required this.hijriText,
  });

  /// index الصلاة الجاية بالنسبة للوقت [now]
  int nextIndex(DateTime now) {
    final i = prayers.indexWhere((p) => p.dateTime.isAfter(now));
    return i == -1 ? 0 : i; // كلها عدّت => فجر بكرة
  }

  /// وقت الصلاة الجاية
  DateTime nextTime(DateTime now) {
    final i = prayers.indexWhere((p) => p.dateTime.isAfter(now));
    if (i == -1) return prayers[0].dateTime.add(const Duration(days: 1));
    return prayers[i].dateTime;
  }

  Duration remaining(DateTime now) => nextTime(now).difference(now);
}

class TimeService {
  /// طريقة الحساب:
  /// 5 = الهيئة المصرية | 4 = أم القرى | 3 = رابطة العالم الإسلامي
  /// 2 = ISNA | 1 = كراتشي | 8 = الخليج | 9 = الكويت | 10 = قطر
  static const int method = 5;

  // الموقع الاحتياطي لو المستخدم رفض الصلاحية أو الـ GPS مقفول
  static const String fallbackCity = 'Minya';
  static const String fallbackCountry = 'Egypt';

  static Future<PrayerDay> getPrayerDay() async {
    final now = DateTime.now();
    final date =
        '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';

    Uri uri;
    final position = await _tryGetPosition();
    if (position != null) {
      uri = Uri.https('api.aladhan.com', '/v1/timings/$date', {
        'latitude': position.latitude.toString(),
        'longitude': position.longitude.toString(),
        'method': '$method',
      });
    } else {
      uri = Uri.https('api.aladhan.com', '/v1/timingsByCity/$date', {
        'city': fallbackCity,
        'country': fallbackCountry,
        'method': '$method',
      });
    }

    final response = await http.get(uri).timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      throw Exception('Server error ${response.statusCode}');
    }

    final data = jsonDecode(response.body)['data'];
    final timings = data['timings'];

    final prayers = [
      _parse('Fajr', timings['Fajr'], now),
      _parse('Dhuhr', timings['Dhuhr'], now),
      _parse('Asr', timings['Asr'], now),
      _parse('Maghrib', timings['Maghrib'], now),
      _parse('Isha', timings['Isha'], now),
    ];

    final g = data['date']['gregorian'];
    final h = data['date']['hijri'];
    String short(String s) => s.length > 3 ? s.substring(0, 3) : s;

    return PrayerDay(
      prayers: prayers,
      gregorianText: '${g['day']} ${short(g['month']['en'])},\n${g['year']}',
      weekday: g['weekday']['en'],
      hijriText: '${h['day']} ${short(h['month']['en'])},\n${h['year']}',
    );
  }

  /// بيرجع null لو مش قادر ياخد الموقع (عشان نستخدم المدينة الاحتياطية)
  static Future<Position?> _tryGetPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low, // كفاية لمواقيت الصلاة وأسرع
          timeLimit: Duration(seconds: 10),
        ),
      );
    } catch (_) {
      return null;
    }
  }

  static Prayer _parse(String name, String raw, DateTime now) {
    // أحيانًا الـ API بترجع "04:04 (EET)" فبناخد أول 5 حروف بس
    final parts = raw.substring(0, 5).split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final h12 = hour % 12 == 0 ? 12 : hour % 12;

    return Prayer(
      name: name,
      time: '${h12.toString().padLeft(2, '0')}:${parts[1]}',
      period: hour >= 12 ? 'PM' : 'AM',
      dateTime: DateTime(now.year, now.month, now.day, hour, minute),
    );
  }
}
