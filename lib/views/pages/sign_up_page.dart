import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/models/sign_up_form_model.dart';
import 'package:chat_armor/shared/shared_methods.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/pages/sign_up_upload_profile.dart';
import 'package:chat_armor/views/widgets/buttons.dart';
import 'package:chat_armor/views/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty) {
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

          if (state is AuthCheckEmailSuccess) {
            // Navigator.pushNamed(context, '/sign-up-set-profile');
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => SignUpSetProfilePage(
                  data: SignUpFormModel(
                    name: nameController.text, 
                    email: emailController.text, 
                    username: usernameController.text, 
                    password: passwordController.text,
                  ),
                ),
              ),
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
                  bottom: 70,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/logo.png')),
                ),
              ),
              Text('Gabung Untuk\nMenggunakan Fiturnya',
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
                    // NOTE: USERNAME INPUT
                    CustomFormFilled(
                      title: 'Username',
                      controller: usernameController,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // NOTE: NAMA LENGKAP INPUT
                    CustomFormFilled(
                      title: 'Nama Lengkap',
                      controller: nameController,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

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
                      height: 30,
                    ),

                    CustomFilledButton(
                      title: 'Selanjutnya',
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(AuthCheckEmail(emailController.text));
                        } else {
                          showCustomSnackbar(
                              context, 'Semua atribut form diisi ya 😁');
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
                title: 'Masuk',
                onPressed: () {
                  Navigator.pushNamed(context, '/sign-in');
                },
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          );
        },
      ),
    );
  }
}
