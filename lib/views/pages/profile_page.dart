import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/shared/shared_methods.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,

      appBar: AppBar(
        title: const Text(
          'Profilku',
        ),
      ),

      body: BlocConsumer<AuthBloc, AuthState>(
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

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),

            children: [
              const SizedBox(
                height: 40,
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 22,
                ),

                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/img_profile.png'
                          ),
                        ),
                      ),
                  
                      child: Align(
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
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Text(
                      'firdhokk',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    ProfileMenuItem(
                      iconUrl: 'assets/ic_edit_profile.png', 
                      title: 'Sunting Profil',
                      onTap: () async{
                        if(await Navigator.pushNamed(context, '/pin') == true){
                          Navigator.pushNamed(context, '/profile-edit');
                        }
                      },
                    ),
                    ProfileMenuItem(
                      iconUrl: 'assets/ic_pin.png', 
                      title: 'Edit PIN',
                      onTap: () async{
                        if(await Navigator.pushNamed(context, '/pin') == true){
                          Navigator.pushNamed(context, '/profile-edit-pin');
                        }
                      },
                    ),
                    ProfileMenuItem(
                      iconUrl: 'assets/ic_logout.png', 
                      title: 'Keluar',
                      onTap: (){
                        context.read<AuthBloc>().add(AuthLogout());
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      )
    );
  }
}