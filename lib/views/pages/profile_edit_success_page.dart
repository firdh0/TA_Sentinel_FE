import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ProfileEditSuccessPage extends StatelessWidget {
  const ProfileEditSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            Text(
              'Berhasil Diperbarui',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: 26,
            ),

            Text(
              'Amankan Pesan WhatsApp\nSekarang Juga',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: 50,
            ),

            CustomFilledButton(
              width: 183,
              title: 'Profilku',
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}