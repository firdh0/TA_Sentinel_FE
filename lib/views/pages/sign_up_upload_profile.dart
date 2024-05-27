
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
import 'package:http/http.dart' as http;
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

  Future<void> startSession(String sessionName) async {
    var url = Uri.parse('https://682a-2001-448a-5110-9379-dcbf-88-ec0e-88d0.ngrok-free.app/api/sessions/start');

    var requestBody = {
      'name': sessionName, //sesuaikan degn _username
      'config': {
        'proxy': null,
        'webhooks': [
          {
            'url': 'https://myapp-r2ucola5za-et.a.run.app/webhook',
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

    // print(data.toJson());
    print(widget.data.toJson());
    // Sparse = widget.data.toJson()
    String _username = widget.data.username!; // Mengasumsikan bahwa username tidak null, akan memunculkan error jika null
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
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 24
        ),

        children: [
          Text(
            "Unggah Gambar Profilmu",
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
            "Tingkatkan penampilan profilmu,\nunggah gambarmu\ndan jadi yang paling kece di sini!",
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
                      color: grey3Color,
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
                        width: 50,
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
                  onPressed: () async {
                    await startSession('default');
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