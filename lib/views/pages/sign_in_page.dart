import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/models/sign_in_form_model.dart';
import 'package:chat_armor/shared/shared_methods.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/buttons.dart';
import 'package:chat_armor/views/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context, '/home', (route) => false
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
              horizontal: 24,
            ),
            children: [
              Container(
                width: 155,
                height: 50,
                margin: const EdgeInsets.only(
                  top: 100,
                  bottom: 100,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/logo.png')),
                ),
              ),
              Text('Masuk &\nGunakan Fiturnya',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  )),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: whiteColor,
                ),
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
                      height: 8,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Lupa Kata Sandi',
                        style: blueTextStyle.copyWith(
                          fontSize: 14,
                          color: blueColor,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    CustomFilledButton(
                      title: 'Masuk',
                      onPressed: () {

                        if (validate()) {
                          context.read<AuthBloc>().add(AuthLogin(SignInFormModel(
                            email: emailController.text,
                            password: passwordController.text
                          )));
                        } else {
                          showCustomSnackbar(context, 'Semua atribut form harus diisi');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextButton(
                title: 'Buat Akun Baru',
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-up');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
