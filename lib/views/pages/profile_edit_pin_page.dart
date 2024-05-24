import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/shared/shared_methods.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/buttons.dart';
import 'package:chat_armor/views/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPinPage extends StatefulWidget {
  const ProfileEditPinPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPinPage> createState() => _ProfileEditPinPageState();
}

class _ProfileEditPinPageState extends State<ProfileEditPinPage> {

  final oldPinController = TextEditingController(text: '');
  final newPinController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Sunting PIN',
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
              horizontal: 22,
            ),
            children: [
              const SizedBox(
                height: 40,
              ),

              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // NOTE: USERNAME INPUT
                    CustomFormFilled(
                      title: 'PIN Lama',
                      controller: oldPinController,
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // NOTE: NAMA LENGKAP INPUT
                    CustomFormFilled(
                      title: 'PIN Baru',
                      controller: newPinController,
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    CustomFilledButton(
                      title: 'Perbarui Sekarang',
                      onPressed: (){
                        context.read<AuthBloc>().add(
                          AuthUpdatePin(oldPinController.text, newPinController.text)
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      )
    );
  }
}