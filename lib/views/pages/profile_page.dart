import 'dart:convert';

import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/shared/shared_methods.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> endSession(String sessionName) async {
    var url = Uri.parse('http://34.128.66.110:3000/api/sessions/start');

    var requestBody = {
      'name': sessionName, //sesuaikan degn _username
      'config': {
        'proxy': null,
        'webhooks': [
          {
            'url': 'https://eb89-2001-448a-5110-9379-14bd-994e-95a3-fd0b.ngrok-free.app/webhook',
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
        title: const Text(
          'Profilku',
        ),
      ),
      body: Stack(
        children: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailed) {
                showCustomSnackbar(context, state.e);
              }

              if (state is AuthInitial) {
                Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is AuthSuccess) {
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
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: state.user.profilePicture == null
                                    ? const AssetImage('assets/img_profile.png')
                                    : NetworkImage(state.user.profilePicture!)
                                        as ImageProvider,
                              ),
                            ),
                            child: state.user.verified == 1
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: whiteColor,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.check_circle,
                                          color: greenColor,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            state.user.username.toString(),
                            style: blackTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ProfileMenuItem(
                            iconUrl: 'assets/ic_edit_profile.png',
                            title: 'Sunting Profil',
                            onTap: () async {
                              if (await Navigator.pushNamed(context, '/pin') ==
                                  true) {
                                Navigator.pushNamed(context, '/profile-edit');
                              }
                            },
                          ),
                          ProfileMenuItem(
                            iconUrl: 'assets/ic_pin.png',
                            title: 'Edit PIN',
                            onTap: () async {
                              if (await Navigator.pushNamed(context, '/pin') ==
                                  true) {
                                Navigator.pushNamed(context, '/profile-edit-pin');
                              }
                            },
                          ),
                          ProfileMenuItem(
                            iconUrl: 'assets/ic_logout.png',
                            title: 'Keluar',
                            onTap: () async {
                              // await endSession('default');
                              context.read<AuthBloc>().add(AuthLogout());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return Container();
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/bg_homepage.png', // Sesuaikan dengan path gambar Anda
                fit: BoxFit.cover,
                width: screenWidth, // Mengatur lebar sesuai dengan lebar layar
              ),
            ),
          ),
        ],
      ),
    );
  }
}