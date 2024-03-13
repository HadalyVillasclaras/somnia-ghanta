import 'package:flutter/material.dart';


class SettingHelp extends StatelessWidget {
  const SettingHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          '¿Cómo podemos ayudarte?',
          style: Theme.of(context).textTheme.titleSmall
        ),
        const SizedBox(height: 20,),
         Text(
          'Puedes escribir un email a nuestro contacto de soporte: info@mercesalatpsicologia.com y te atenderemos lo antes posible.',
          style: Theme.of(context).textTheme.titleSmall,
          ),
        const SizedBox(height: 50,),
        FilledButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          child: const Text('Enviar email')
          )
      ],
    );
  }
}