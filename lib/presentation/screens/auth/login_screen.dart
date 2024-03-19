import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghanta/presentation/providers/_providers.dart';
import 'package:ghanta/presentation/providers/auth/login_form_provider.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                image: AssetImage('assets/images/gradient-bg.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: sizes.height * 0.2,
                  ),
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
                    child: LoginForm(sizes: sizes),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({
    super.key,
    required this.sizes,
  });

  final Size sizes;

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  bool _obscureText = true;
  bool _isLoading = false;

    void  showSnackbar(BuildContext context, String message){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:   Text(message))
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = ref.watch(loginFormProvider);
    final theme = Theme.of(context);

    ref.listen(authProvider, ((previous, next) { 
    if (next.errorMessage.isEmpty  ) return;

    showSnackbar(context, next.errorMessage);

    }));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: widget.sizes.height * 0.05),
        const Text(
          'Iniciar Sesión',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        TextField(
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          onChanged: (value) =>
              ref.read(loginFormProvider.notifier).onEmailChange(value),
          decoration: InputDecoration(
            hintText: 'Correo electrónico',
            prefixIcon: const Icon(Icons.email_outlined),
            errorText:
              loginForm.isEmailValid.isNotValid && loginForm.isFormPosted
                ? 'Email no válido'
                : null,
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          obscureText: _obscureText,
          onChanged: (value) =>
              ref.read(loginFormProvider.notifier).onPasswordChange(value),
          decoration: InputDecoration(
              hintText: 'Contraseña',
              prefixIcon: const Icon(Icons.lock_outline),
              errorText:
                  loginForm.isPasswordValid.isNotValid && loginForm.isFormPosted  
                      ? 'Contraseña no válida'
                      : null,
              suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  })
              ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
            onPressed: () {
              ref.read(loginFormProvider.notifier).onFormSubmitted();
              // Cerramos el teclado
              FocusScope.of(context).unfocus();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: loginForm.isPosting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text('Iniciar Sesión')),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿No tienes una cuenta?', style: TextStyle(color: theme.colorScheme.tertiary ),),
            TextButton(
              onPressed: () {
                context.push('/register');
              },
              child: const Text('Regístrate'),
            ),
          ],
        ),
      ],
    );
  }
}
