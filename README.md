# Islami App

A Flutter Islamic companion app for reading Quran and Hadith, listening to radio recitations, tracking prayer times, and using daily azkar.

## Features

- Quran reading with recently-read persistence
- Hadith browsing and details
- Prayer times using location or a fallback city
- Quran radio and reciter selection
- Sebha and daily azkar
- Arabic-first dark theme

## Built with

Flutter, Dart, SharedPreferences, REST APIs, Geolocator, and just_audio.

## Project structure

- `lib/core/` contains shared theme and reusable widgets.
- `lib/features/` contains feature-specific code, grouped into `data/`, `models/`, and `presentation/`.
- `lib/main.dart` is the application entry point.

## Run locally

```bash
flutter pub get
flutter run
```
