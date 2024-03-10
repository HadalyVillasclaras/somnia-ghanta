// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(current_phase, total_phases) =>
      "Phase ${current_phase}/${total_phases}";

  static String m1(username) => "Good morning, ${username}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bottom_bar_courses": MessageLookupByLibrary.simpleMessage("Courses"),
        "bottom_bar_home": MessageLookupByLibrary.simpleMessage("Home"),
        "bottom_bar_profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "bottom_bar_settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "course_card_current_subphase":
            MessageLookupByLibrary.simpleMessage("Current subphase"),
        "course_card_phase": m0,
        "home_page_body_my_recent_courses":
            MessageLookupByLibrary.simpleMessage("My recent courses"),
        "home_page_header_feelings":
            MessageLookupByLibrary.simpleMessage("How are you feeling today?"),
        "home_page_header_greeting": m1,
        "home_profile_level": MessageLookupByLibrary.simpleMessage("Level"),
        "home_profile_my_achievements":
            MessageLookupByLibrary.simpleMessage("My Achievements"),
        "home_profile_my_activity":
            MessageLookupByLibrary.simpleMessage("My Activity"),
        "home_profile_my_profile":
            MessageLookupByLibrary.simpleMessage("My Profile"),
        "home_profile_points": MessageLookupByLibrary.simpleMessage("Points"),
        "home_profile_streak": MessageLookupByLibrary.simpleMessage("Streak"),
        "home_store_available_courses":
            MessageLookupByLibrary.simpleMessage("Available courses"),
        "home_store_find_by_name":
            MessageLookupByLibrary.simpleMessage("Find by name"),
        "home_store_ready_to_enroll": MessageLookupByLibrary.simpleMessage(
            "Ready to enroll a new course?")
      };
}
