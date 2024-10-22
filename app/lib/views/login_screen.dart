import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:app/viewmodels/auth_viewmodel.dart';
import 'package:app/views/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'La contraseña no debe ir vacia'),
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'El Correo es requerido'),
    EmailValidator(errorText: 'El texto del campo debe ser un Correo'),
  ]);

  final _formKey = GlobalKey<FormState>();
  //Definir los campos del formulario
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electronico',
                ),
                validator: emailValidator.call,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'Introduce una contraseña Valida'),
                obscureText: true,
                validator: passwordValidator.call,
              ),
              const SizedBox(height: 20),
              authViewModel.loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authViewModel
                              .login(_emailController.text,
                                  _passwordController.text)
                              .then((value) => {
                                    if (authViewModel.user != null)
                                      {
                                        Navigator.popAndPushNamed(
                                            context, '/home')
                                      }
                                  });
                        }
                      },
                      child: const Text('Login')),
              TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/register');
                  },
                  child: const Text('No tienes cuenta?, Registrate Aquí')),
              if (authViewModel.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    authViewModel.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
