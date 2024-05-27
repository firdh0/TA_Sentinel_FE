import 'dart:convert';
import 'dart:typed_data';

import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/models/sign_up_form_model.dart';
import 'package:chat_armor/shared/shared_methods.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ScanQrcodePage extends StatefulWidget {
  final SignUpFormModel data;

  const ScanQrcodePage({Key? key, required this.data}) : super(key: key);

  @override
  State<ScanQrcodePage> createState() => _ScanQrcodePageState();
}

class _ScanQrcodePageState extends State<ScanQrcodePage> {
  // final String phoneNumber = '01234567890'; // Jadikan bisa ambil phone number + tampilkan kode QR-nya
  String? phoneNumber;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _fetchQRCode();
  }

  Future<void> _fetchQRCode() async {
    final url = 'https://901f-2001-448a-5110-9379-f908-3312-56fd-d44c.ngrok-free.app/api/default/auth/qr?format=image';
    try {
      final response = await http.get(Uri.parse(url));
      print('Status Code: ${response.statusCode}');
      print('Content Type: ${response.headers['content-type']}');
      if (response.statusCode == 200 && response.headers['content-type']!.contains('image')) {
        setState(() {
          _imageBytes = response.bodyBytes;
        });

        // _fetchPhoneNumber();
      } else {
        print('Failed to load QR code');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching QR code: $e');
    }
  }

  Future<void> _fetchPhoneNumber() async {
    final url = 'https://901f-2001-448a-5110-9379-f908-3312-56fd-d44c.ngrok-free.app/api/sessions/default';
    try {
      final response = await http.get(Uri.parse(url));
      print('Status Code: ${response.statusCode}');
      print('Content Type: ${response.headers['content-type']}');
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print(responseBody);
        setState(() {
          phoneNumber = responseBody['me']['id'];
          phoneNumber = phoneNumber?.replaceAll(RegExp(r'[^0-9]'), '');
          phoneNumber = phoneNumber?.replaceFirst('62', '0');
          print(phoneNumber);
        });
      } else {
        print('Failed to load QR code');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching QR code: $e');
    }
  }

  bool validate() {
    if (phoneNumber == null || phoneNumber!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data.toJson());

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
              horizontal: 22,
              vertical: 24
            ),
            children: [
              Text(
                "Pindai Kode QR",
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
                "Eitss, pindai kode QR berikut untuk\nterhubung dengan WhatsApp anda",
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
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
                    _imageBytes != null
                      ? Image.memory(Uint8List.fromList(_imageBytes!))
                      : const SizedBox(
                          width: 120,
                          height: 120,
                          child: Center(child: CircularProgressIndicator()),
                        ),

                    const SizedBox(
                      height: 50,
                    ),

                    CustomGreyFilledButton(
                      title: 'Dapatkan Nomor WhatsApp',
                      onPressed: _fetchPhoneNumber,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFilledButton(
                      title: 'Selanjutnya',
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                            AuthRegister(widget.data.copyWith(
                              phoneNumber: phoneNumber,
                            ))
                          );
                        } else {
                          showCustomSnackbar(context, 'Nomor handphone kosong');
                        }
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
