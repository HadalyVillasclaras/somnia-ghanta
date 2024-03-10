import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:ghanta/presentation/providers/auth/register_form_provider.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context).colorScheme;
    final sizes = MediaQuery.of(context).size;

    ref.listen(authProvider, (prev, next) {
      if (next.errorMessage.isEmpty) return;



      Future.delayed(const Duration(seconds: 2));
      if (next.authStatus == AuthStatus.authenticated) {
        context.go('/auth');
      }
    });

    return Scaffold(
        backgroundColor: theme.primary,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg-night.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: sizes.height * 0.3,
                  child: Image.asset(
                    'assets/images/logo_negativo.png',
                    width: sizes.width * 0.2,
                  )),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: RegisterForm(sizes: sizes),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({
    super.key,
    required this.sizes,
  });

  final Size sizes;

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final registerForm = ref.watch(registerFormProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: widget.sizes.height * 0.05),
        const Text(
          'Formulario de registro',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        TextField(
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          onChanged: (value) => ref.read(registerFormProvider.notifier).onNameChanged(value),
          decoration: const InputDecoration(
            hintText: 'Nombre',
            prefixIcon:  Icon(Icons.person),
            errorText: "",
          ),
        ),

        TextField(
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          onChanged: (value) => ref.read(registerFormProvider.notifier).onEmailChanged(value),
          decoration: InputDecoration(
            hintText: 'Correo electrónico',
            prefixIcon: const Icon(Icons.email_outlined),
            errorText:
                registerForm.isFormPosted 
                  ? registerForm.email.errorMessage
                  : null,
          ),
        ),
        const SizedBox(height: 20),

        TextField(
          obscureText: _obscureText,
          onChanged: (value) => ref.read(registerFormProvider.notifier).onPasswordChanged(value),
          decoration: InputDecoration(
            hintText: 'Contraseña',
            prefixIcon: const Icon(Icons.lock_outline),
            errorText:
              registerForm.isFormPosted 
                  ? registerForm.password.errorMessage
                  : null,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              })),
        ),
        const SizedBox(height: 20),

        TextField(
        obscureText: _obscureText,
        onChanged: (value) => ref.read(registerFormProvider.notifier).onPasswordConfirmationChanged(value),
        decoration: InputDecoration(
          hintText: 'Repite la contraseña',
          prefixIcon: const Icon(Icons.lock_outline),
          errorText:
            registerForm.isFormPosted 
              ? registerForm.passwordConfirmation.errorMessage
              : null,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            })),
      ),
      const SizedBox(height: 30),

        FilledButton(
            onPressed: () {
              ref.read(registerFormProvider.notifier).onFormSubmit();
              // Cerramos el teclado
              FocusScope.of(context).unfocus();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text('Iniciar Sesión',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ))),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('¿Ya tienes una cuenta?'),
            TextButton(
              onPressed: () {
                context.push('/login');
              },
              child: const Text('Inicia sesión'),
            ),
          ],
        ),
      ],
    );
  }
}
