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
                    color: theme.surface,
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
    void  showSnackbar(BuildContext context, String message){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:   Text(message))
      );
    }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Dont open keyboard automatically
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, ((previous, next) { 
      if (next.errorMessage.isEmpty  ) return;
      showSnackbar(context, next.errorMessage);
    }));


    return GestureDetector(
       onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: _formKey,
        child: Column(
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
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              onChanged: (value) =>
                  ref.read(loginFormProvider.notifier).onEmailChange(value),
              decoration: InputDecoration(
                hintText: 'Correo electrónico',
                prefixIcon: const Icon(Icons.email_outlined),
                errorText:
                  loginForm.isFormPosted && 
                  !loginForm.editedFieldsAfterSubmit.contains('email') 
                    ? 'Email no válido'
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: _obscureText,
              autofocus: false,
              onChanged: (value) =>
                  ref.read(loginFormProvider.notifier).onPasswordChange(value),
              decoration: InputDecoration(
                  hintText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock_outline),
                  errorText:
                      loginForm.isFormPosted  && !loginForm.editedFieldsAfterSubmit.contains('password')
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
        ),
      ),
    );
  }
}
