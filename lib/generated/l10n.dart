// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Tr {
  Tr();

  static Tr? _current;

  static Tr get current {
    assert(_current != null,
        'No instance of Tr was loaded. Try to initialize the Tr delegate before accessing Tr.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Tr> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Tr();
      Tr._current = instance;

      return instance;
    });
  }

  static Tr of(BuildContext context) {
    final instance = Tr.maybeOf(context);
    assert(instance != null,
        'No instance of Tr present in the widget tree. Did you add Tr.delegate in localizationsDelegates?');
    return instance!;
  }

  static Tr? maybeOf(BuildContext context) {
    return Localizations.of<Tr>(context, Tr);
  }

  /// `Good morning, {username}!`
  String home_page_header_greeting(Object username) {
    return Intl.message(
      'Good morning, $username!',
      name: 'home_page_header_greeting',
      desc: '',
      args: [username],
    );
  }

  /// `How are you feeling today?`
  String get home_page_header_feelings {
    return Intl.message(
      'How are you feeling today?',
      name: 'home_page_header_feelings',
      desc: '',
      args: [],
    );
  }

  /// `My recent courses`
  String get home_page_body_my_recent_courses {
    return Intl.message(
      'My recent courses',
      name: 'home_page_body_my_recent_courses',
      desc: '',
      args: [],
    );
  }

  /// `Phase {current_phase}/{total_phases}`
  String course_card_phase(Object current_phase, Object total_phases) {
    return Intl.message(
      'Phase $current_phase/$total_phases',
      name: 'course_card_phase',
      desc: '',
      args: [current_phase, total_phases],
    );
  }

  /// `Current subphase`
  String get course_card_current_subphase {
    return Intl.message(
      'Current subphase',
      name: 'course_card_current_subphase',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get bottom_bar_home {
    return Intl.message(
      'Home',
      name: 'bottom_bar_home',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get bottom_bar_courses {
    return Intl.message(
      'Courses',
      name: 'bottom_bar_courses',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get bottom_bar_profile {
    return Intl.message(
      'Profile',
      name: 'bottom_bar_profile',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get bottom_bar_settings {
    return Intl.message(
      'Settings',
      name: 'bottom_bar_settings',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get home_profile_my_profile {
    return Intl.message(
      'My Profile',
      name: 'home_profile_my_profile',
      desc: '',
      args: [],
    );
  }

  /// `My Activity`
  String get home_profile_my_activity {
    return Intl.message(
      'My Activity',
      name: 'home_profile_my_activity',
      desc: '',
      args: [],
    );
  }

  /// `My Achievements`
  String get home_profile_my_achievements {
    return Intl.message(
      'My Achievements',
      name: 'home_profile_my_achievements',
      desc: '',
      args: [],
    );
  }

  /// `Streak`
  String get home_profile_streak {
    return Intl.message(
      'Streak',
      name: 'home_profile_streak',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get home_profile_points {
    return Intl.message(
      'Points',
      name: 'home_profile_points',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get home_profile_level {
    return Intl.message(
      'Level',
      name: 'home_profile_level',
      desc: '',
      args: [],
    );
  }

  /// `Ready to enroll a new course?`
  String get home_store_ready_to_enroll {
    return Intl.message(
      'Ready to enroll a new course?',
      name: 'home_store_ready_to_enroll',
      desc: '',
      args: [],
    );
  }

  /// `Find by name`
  String get home_store_find_by_name {
    return Intl.message(
      'Find by name',
      name: 'home_store_find_by_name',
      desc: '',
      args: [],
    );
  }

  /// `Available courses`
  String get home_store_available_courses {
    return Intl.message(
      'Available courses',
      name: 'home_store_available_courses',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Tr> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ca', countryCode: 'ES'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Tr> load(Locale locale) => Tr.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
