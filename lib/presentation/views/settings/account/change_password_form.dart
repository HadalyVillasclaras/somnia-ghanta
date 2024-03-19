import 'package:flutter/material.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({
    super.key,
    required this.sizes,
  });

  final Size sizes;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: sizes.height * 0.05),
          const Text(
            'Contraseña',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          TextFormField(
            onChanged: (value) {},
            decoration: InputDecoration(
                hintText: 'Contraseña actual',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {})),
          ),
          const SizedBox(height: 50),
          TextFormField(
            onChanged: (value) {},
            decoration: InputDecoration(
                hintText: 'Nueva contraseña',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {})),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onChanged: (value) {},
            decoration: InputDecoration(
                hintText: 'Confirma nueva contraseña',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {})),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              // Cerramos el teclado
              FocusScope.of(context).unfocus();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text('Cambiar contraseña',)),
        ],
      ),
    );
  }
}
