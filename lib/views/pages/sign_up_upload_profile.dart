
// import 'dart:html';
import 'dart:convert';
import 'dart:io';

import 'package:chat_armor/models/sign_up_form_model.dart';
import 'package:chat_armor/shared/shared_methods.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/pages/scan_qrcode_page.dart';
import 'package:chat_armor/views/widgets/buttons.dart';
import 'package:chat_armor/views/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpSetProfilePage extends StatefulWidget {

  final SignUpFormModel data;

  const SignUpSetProfilePage({Key? key, required this.data}) : super(key: key);

  @override
  State<SignUpSetProfilePage> createState() => _SignUpSetProfilePageState();
}

class _SignUpSetProfilePageState extends State<SignUpSetProfilePage> {
  final pinController = TextEditingController(text: '');
  XFile? selectedImage;

  bool validate(){
    if (pinController.text.length != 6) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {

    // print(data.toJson());
    print(widget.data.toJson());
    // Sparse = widget.data.toJson()
    String _username = widget.data.username!; // Mengasumsikan bahwa username tidak null, akan memunculkan error jika null
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: ListView(
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
              image: DecorationImage(
                image: AssetImage('assets/logo.png')
              ),
            ),
          ),

          Text(
            'Unggah Foto &\nBuat PIN',
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            )
          ),

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
              children: [
                GestureDetector(
                  onTap: () async {
                    final image = await selectImage();
                    setState(() {
                      selectedImage = image;
                    });
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightBackgroundColor,
                      image: selectedImage == null 
                        ? null 
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(selectedImage!.path),
                            ),
                          ),
                    ),
                    child: selectedImage != null ? null : Center(child: Image.asset(
                        'assets/ic_upload.png',
                        width: 32,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                Text(
                  _username,
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                CustomFormFilled(
                  title: 'Atur PIN (6 Digit Angka)',
                  obscureText: true,
                  controller: pinController,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(
                  height: 30,
                ),

                CustomFilledButton(
                  title: 'Selanjutnya',
                  onPressed: (){
                    if (validate()) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ScanQrcodePage(data: widget.data.copyWith(
                        pin: pinController.text,
                        profilePicture: selectedImage == null ? null : 'data:image/png;base64,' + base64Encode(File(selectedImage!.path).readAsBytesSync(),),
                      ),),),); // INI SEHARUSNYA MENGARAH KE SCAN QR CODE
                    } else {
                      showCustomSnackbar(context, 'PIN harus 6 digit 😉');
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}