import 'package:flutter/material.dart';


class SettingHelp extends StatelessWidget {
  const SettingHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('¿Cómo podemos ayudarte?'),
        const Text('Puedes escribir un email a nuestro contacto de soporte: info@mercesalatpsicologia.com y te atenderemos lo antes posible.'),
        FilledButton(
          onPressed: (){},
          child: const Text('Enviar email')
          )
      ],
    );
  }
}