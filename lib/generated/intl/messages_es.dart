// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(currentPhase, totalPhases) =>
      "Fase ${currentPhase}/${totalPhases}";

  static String m1(username) => "Buenos días, ${username}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bottom_bar_courses": MessageLookupByLibrary.simpleMessage("Cursos"),
        "bottom_bar_home": MessageLookupByLibrary.simpleMessage("Inicio"),
        "bottom_bar_profile": MessageLookupByLibrary.simpleMessage("Perfil"),
        "bottom_bar_settings":
            MessageLookupByLibrary.simpleMessage("Configuración"),
        "course_card_current_subphase":
            MessageLookupByLibrary.simpleMessage("Subfase actual"),
        "course_card_phase": m0,
        "home_page_body_my_recent_courses":
            MessageLookupByLibrary.simpleMessage("Mis cursos recientes"),
        "home_page_header_feelings":
            MessageLookupByLibrary.simpleMessage("¿Cómo te sientes hoy?"),
        "home_page_header_greeting": m1,
        "home_profile_level": MessageLookupByLibrary.simpleMessage("Nivel"),
        "home_profile_my_achievements":
            MessageLookupByLibrary.simpleMessage("Mis logros"),
        "home_profile_my_activity":
            MessageLookupByLibrary.simpleMessage("Mi actividad"),
        "home_profile_my_profile":
            MessageLookupByLibrary.simpleMessage("Mi perfil"),
        "home_profile_points": MessageLookupByLibrary.simpleMessage("Puntos"),
        "home_profile_streak": MessageLookupByLibrary.simpleMessage("Racha"),
        "home_store_available_courses":
            MessageLookupByLibrary.simpleMessage("Cursos disponibles"),
        "home_store_find_by_name":
            MessageLookupByLibrary.simpleMessage("Buscar por nombre"),
        "home_store_ready_to_enroll":
            MessageLookupByLibrary.simpleMessage("¡Apuntate a un nuevo curso!")
      };
}
