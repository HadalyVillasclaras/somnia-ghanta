import 'package:flutter/material.dart';
enum LanguageOption { spanish, catalan }

class SettingLanguage extends StatefulWidget {
  const SettingLanguage({super.key});

  @override
  State<SettingLanguage> createState() => _SettingLanguageState();
}

class _SettingLanguageState extends State<SettingLanguage> {
  LanguageOption? _lang = LanguageOption.spanish;

  @override
  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[
        SizedBox(height: 40,),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(left: 0.0),
          title: Text('Español'),
          leading: Radio<LanguageOption>(
            value: LanguageOption.spanish,
            groupValue: _lang,
            onChanged: (LanguageOption? value) {
              setState(() {
                _lang = value;
              });
            },
          ),
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.only(left: 0.0),
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
        ),
        const Divider(),

      ],
    );
  }
}