import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/models/user_edit_form_model.dart';
import 'package:chat_armor/shared/shared_methods.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/buttons.dart';
import 'package:chat_armor/views/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {

  final usernameController = TextEditingController(text: '');
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthSuccess) {
      usernameController.text = authState.user.username!;
      nameController.text = authState.user.name!;
      emailController.text = authState.user.email!;
      passwordController.text = authState.user.password!;

      print(usernameController);
      print(nameController);
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sunting Profil',
        ),
      ),

      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, '/profile-edit-success', (route) => false);
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
              const SizedBox(
                height: 40,
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
                      title: 'Perbarui Sekarang',
                      onPressed: (){
                        context.read<AuthBloc>().add(
                          AuthUpdateUser(
                            UserEditFormModel(
                              username: usernameController.text,
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            )
                          )
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}