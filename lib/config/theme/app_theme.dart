

import 'package:flutter/material.dart';
import 'package:ghanta/config/_config.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get themeData => ThemeData(
        colorSchemeSeed: //HEX for #FFC107
            // const Color(0xFFA23957),
            ColorsTheme.primaryColor,
        useMaterial3: true,
        brightness: //Usamos el brillo del sistema
            Brightness.light,
        textTheme: GoogleFonts.montserratTextTheme(),
        //TextFormField
        inputDecorationTheme: InputDecorationTheme(
           border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
        )
      );
}