import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/viewmodels/auth_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    authViewModel.checkSession().then((_) {
      if (authViewModel.user != null) {
        Navigator.popAndPushNamed(context, '/home');
      } else {
        Navigator.popAndPushNamed(context, '/login');
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
