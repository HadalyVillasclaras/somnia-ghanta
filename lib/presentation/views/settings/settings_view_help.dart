import 'package:flutter/material.dart';


class SettingsViewHelp extends StatelessWidget {
  const SettingsViewHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
         Text(
          '¿Cómo podemos ayudarte?',
          style: Theme.of(context).textTheme.titleSmall
        ),
        const SizedBox(height: 20,),
         Text(
          'Puedes escribir un email a nuestro contacto de soporte: info@mercesalatpsicologia.com y te atenderemos lo antes posible.',
          style: Theme.of(context).textTheme.titleSmall,
          ),
      ],
    );
  }
}