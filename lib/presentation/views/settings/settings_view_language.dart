import 'package:flutter/material.dart';
enum LanguageOption { spanish, catalan }

class SettingsViewLanguage extends StatefulWidget {
  const SettingsViewLanguage({super.key});

  @override
  State<SettingsViewLanguage> createState() => _SettingsViewLanguageState();
}

class _SettingsViewLanguageState extends State<SettingsViewLanguage> {
  LanguageOption? _lang = LanguageOption.spanish;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 40,),
        const Divider(height: 0.0),
        Container(
          decoration: _lang == LanguageOption.spanish 
          ? const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(0, 255, 255, 255),Color.fromARGB(57, 144, 253, 242),Color.fromARGB(69, 90, 252, 236), Color.fromARGB(57, 144, 253, 242), Color.fromARGB(0, 255, 255, 255)],
                stops: [0, 0.1, 0.5, 0.9, 1],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            )
          : null,
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 0.0),
            title: const Text('Español'),
            leading: Radio<LanguageOption>(
              value: LanguageOption.spanish,
              groupValue: _lang,
              onChanged: (LanguageOption? value) {
                setState(() {
                  _lang = value;
                });
              },
            ),
            onTap: () {
              setState(() {
                _lang = LanguageOption.spanish;
              });
            },
          ),
        ),
        const Divider(height: 0.0),
        Container(
          decoration: _lang == LanguageOption.catalan 
          ? const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(0, 255, 255, 255),Color.fromARGB(57, 144, 253, 242),Color.fromARGB(69, 90, 252, 236), Color.fromARGB(57, 144, 253, 242), Color.fromARGB(0, 255, 255, 255)],
                stops: [0, 0.1, 0.5, 0.9, 1],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            )
          : null,
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 0.0),
            title: const Text('Catalán'),
            leading: Radio<LanguageOption>(
              value: LanguageOption.catalan,
              groupValue: _lang,
              onChanged: (LanguageOption? value) {
                setState(() {
                  _lang = value;
                });
              },
            ),
            onTap: () {
              setState(() {
                _lang = LanguageOption.catalan;
              });
            },
          ),
        ),
        const Divider(height: 0.0),
      ],
    );
  }
}