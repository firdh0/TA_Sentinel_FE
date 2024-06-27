import 'dart:convert';

import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/models/sign_in_form_model.dart';
import 'package:chat_armor/services/connectivity_service.dart';
import 'package:chat_armor/shared/shared_methods.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/buttons.dart';
import 'package:chat_armor/views/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showCustomSnackbar(context, 'Semua atribut form diisi ya 😁');
      return false;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
      showCustomSnackbar(context, 'Format email tidak valid 🥺');
      return false;
    }

    return true;
  }

  Future<void> startSession(String sessionName) async {
    var url = Uri.parse('http://34.101.217.239:3000/api/sessions/start');

    var requestBody = {
      'name': sessionName, //sesuaikan degn _username
      'config': {
        'proxy': null,
        'webhooks': [
          {
            'url': 'https://sentinel-api-model-ew5qojub4a-et.a.run.app/webhook',
            'events': ['message', 'session.status'],
            'hmac': null,
            'retries': null,
            'customHeaders': null,
          }
        ],
      },
    };

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    print('Status Code: ${response.statusCode}');
    if (response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);
      print('Response Body: $responseBody');
    } else {
      print('Failed to start session');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/sentinel_appbar.png', // Sesuaikan dengan path logo Anda
          height: 34,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            final errorMessage = state.e.toLowerCase();
            if (errorMessage.contains('<!doctype html>')) {
              showCustomSnackbar(context, 'Terjadi kesalahan pada server. Silakan coba lagi nanti.');
            } else if (errorMessage.contains('kredensial login tidak valid')) {
              showCustomSnackbar(context, 'Kredensial login tidak valid');
            } else {
              showCustomSnackbar(context, 'Login gagal, periksa kembali email dan password Anda');
            }
          }

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context, '/scan-qr-sg', (route) => false
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 24
            ),
            children: [
              Container(
                width: screenWidth * 0.5,
                height: 260,
                margin: const EdgeInsets.only(
                  bottom: 50,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/masuk.png')),
                ),
              ),

              Text(
                "Masuk",
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: 10,
              ),

              Text(
                "Masuk, awasi, hindari phishing!\nWhatsApp makin seru dan kece",
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NOTE: EMAIL INPUT
                    CustomFormFilled(
                      title: 'Email',
                      controller: emailController,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // NOTE: KATA SANDI INPUT
                    CustomFormFilled(
                      title: 'Kata Sandi',
                      obscureText: true,
                      controller: passwordController,
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    CustomFilledButton(
                      title: 'Masuk',
                      onPressed: () async {
                        if (await InternetConnection.isConnectedToInternet()) {
                          if (validate()) {
                            await startSession('default');
                            context.read<AuthBloc>().add(AuthLogin(SignInFormModel(
                              email: emailController.text,
                              password: passwordController.text
                            )));
                          } 
                        } else {
                          showCustomSnackbar(context, 'Tidak ada koneksi internet, coba lagi nanti. 😁');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomGreyFilledButton(
                title: 'Buat Akun Baru',
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-up');
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
    );
  }
}
