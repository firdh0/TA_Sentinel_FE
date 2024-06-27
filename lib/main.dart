import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/pages/home_page.dart';
import 'package:chat_armor/views/pages/onboarding_page.dart';
import 'package:chat_armor/views/pages/pin_page.dart';
import 'package:chat_armor/views/pages/profile_edit_page.dart';
import 'package:chat_armor/views/pages/profile_edit_pin_page.dart';
import 'package:chat_armor/views/pages/profile_edit_success_page.dart';
import 'package:chat_armor/views/pages/profile_page.dart';
import 'package:chat_armor/views/pages/scan_qrcode_sg_page.dart';
import 'package:chat_armor/views/pages/scan_qrcode_success_page.dart';
import 'package:chat_armor/views/pages/sign_in_page.dart';
import 'package:chat_armor/views/pages/sign_up_page.dart';
import 'package:chat_armor/views/pages/sign_up_success.dart';
import 'package:chat_armor/views/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthGetCurrentUser()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData( 
          // scaffoldBackgroundColor: lightBackgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: lightBackgroundColor,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: blackColor,
            ),
    
            titleTextStyle: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
        ),
        routes: {
          '/': (context) => const SplashPage(),
          '/onboarding': (context) => OnboardingPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          // '/sign-up-set-profile':(context) => const SignUpSetProfilePage(),
          '/sign-up-success': (context) => const SignUpSuccessPage(),
          '/home':(context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
          '/pin': (context) => const PinPage(),
          '/profile-edit': (context) => const ProfileEditPage(),
          '/profile-edit-pin': (context) => const ProfileEditPinPage(),
          '/profile-edit-success': (context) => const ProfileEditSuccessPage(),
          // '/scan-qr': (context) => const ScanQrcodePage(),
          '/scan-qr-sg': (context) => const ScanQrcodePageSg(),
          '/scan-qr-success': (context) => const ScanQrcodeSuccessPage(),
        },
      ),
    );
  }
}