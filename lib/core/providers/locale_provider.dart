import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for the LocaleNotifier
final localeProvider = ChangeNotifierProvider<LocaleNotifier>((ref) {
  return LocaleNotifier();
});

/// Notifier class that manages the app's locale/language settings.
/// It persists the language preference using SharedPreferences.
class LocaleNotifier extends ChangeNotifier {
  static const String _localeKey = 'app_locale';

  Locale _locale = const Locale('ar'); // Default to Arabic
  bool _isLoaded = false;

  Locale get locale => _locale;
  bool get isLoaded => _isLoaded;
  String get languageCode => _locale.languageCode;
  bool get isArabic => _locale.languageCode == 'ar';
  bool get isEnglish => _locale.languageCode == 'en';

  LocaleNotifier() {
    _loadLocale();
  }

  /// Load saved locale from SharedPreferences
  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLocale = prefs.getString(_localeKey);
      if (savedLocale != null) {
        _locale = Locale(savedLocale);
      }
    } catch (e) {
      debugPrint('Error loading locale: $e');
    } finally {
      _isLoaded = true;
      notifyListeners();
    }
  }

  /// Change the app locale and persist the preference
  Future<void> setLocale(String languageCode) async {
    if (_locale.languageCode == languageCode) return;

    _locale = Locale(languageCode);
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, languageCode);
    } catch (e) {
      debugPrint('Error saving locale: $e');
    }
  }

  /// Toggle between Arabic and English
  Future<void> toggleLocale() async {
    final newLocale = _locale.languageCode == 'ar' ? 'en' : 'ar';
    await setLocale(newLocale);
  }

  /// Get the text direction based on current locale
  TextDirection get textDirection {
    return _locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;
  }
}
