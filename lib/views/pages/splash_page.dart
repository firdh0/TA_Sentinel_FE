import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            });
            // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          }

          if (state is AuthFailed) {
            Future.delayed(const Duration(seconds: 3), () {
                Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
            });
            // Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/splash_bg.png', // Ganti dengan path gambar background
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Container(
                width: 151,
                height: 75,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/logo.png'))),
              ),
            ),
          ],
        ),
        // child: Center(
        //   child: Container(
        //     width: 151,
        //     height: 75,
        //     decoration: const BoxDecoration(
        //         image: DecorationImage(image: AssetImage('assets/logo.png'))),
        //   ),
        // ),
      ),
    );
  }
}
