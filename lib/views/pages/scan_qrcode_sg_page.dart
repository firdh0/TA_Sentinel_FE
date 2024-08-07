import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/shared/shared_methods.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ScanQrcodePageSg extends StatefulWidget {

  const ScanQrcodePageSg({Key? key}) : super(key: key);

  @override
  State<ScanQrcodePageSg> createState() => _ScanQrcodePageStateSg();
}

class _ScanQrcodePageStateSg extends State<ScanQrcodePageSg> {
  String? phoneNumber;
  Uint8List? _imageBytes;
  int _countdown = 15;
  Timer? _timer;
  bool _isFetchingQRCode = true;
  bool _isProcessingServer = false; // Menunjukkan apakah server sedang memproses
  bool _isQRCodeReady = false; // Menunjukkan apakah QR code sudah siap

  @override
  void initState() {
    super.initState();
    _fetchQRCode();
  }

  void _startCountdown() {
    _countdown = 15;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  Future<void> _fetchQRCode() async { 
    final url = 'http://34.101.217.239:3000/api/default/auth/qr?format=image';
    bool isSuccessful = false;

    while (!isSuccessful) {
      _startCountdown();
      try {
        await Future.delayed(Duration(seconds: 15));
        final response = await http.get(Uri.parse(url));
        print('Status Code: ${response.statusCode}');
        print('Content Type: ${response.headers['content-type']}');

        if (response.statusCode == 200 && response.headers['content-type']!.contains('image')) {
          setState(() {
            _imageBytes = response.bodyBytes;
            _isQRCodeReady = true; // QR code sudah siap
          });

          isSuccessful = true;
          _fetchPhoneNumber();
        } else {
          print('Failed to load QR code');
          print('Response Body: ${response.body}');
        }
      } catch (e) {
        print('Error fetching QR code: $e');
      }
    }
  }

  Future<void> _fetchPhoneNumber() async {
    final url = 'http://34.101.217.239:3000/api/sessions/default';
    bool isSuccessful = false;

    setState(() {
      _isProcessingServer = true; // Menunjukkan bahwa server sedang memproses
    });

    while (!isSuccessful) {
      try {
        await Future.delayed(Duration(seconds: 15)); // Menunggu 10 detik sebelum request
        final response = await http.get(Uri.parse(url));
        print('Status Code: ${response.statusCode}');
        print('Content Type: ${response.headers['content-type']}');

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);
          print(responseBody);

          if (responseBody['status'] == 'WORKING') {
            setState(() {
              phoneNumber = responseBody['me']['id'];
              phoneNumber = phoneNumber?.replaceAll(RegExp(r'[^0-9]'), '');
              phoneNumber = phoneNumber?.replaceFirst('62', '0');
              // print(phoneNumber);
              _isProcessingServer = false; // Server selesai memproses
              isSuccessful = true; // Berhasil
            });
          } else {
            print('Session status is not WORKING. Retrying in 15 seconds...');
          }
        } else {
          print('Failed to load phone number. Retrying...');
          print('Response Body: ${response.body}');
        }
      } catch (e) {
        print('Error fetching phone number: $e');
      }
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
    // print(widget.data.toJson());

    phoneNumber = phoneNumber; 
    // print(phoneNumber);

    // print('Phone number: $phoneNumber');

    // if (phoneNumber == null || phoneNumber!.isEmpty) {
    //   print('Kosong');
    // } else {
    //   print('Tidak');
    // }

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
                "Eitss, pindai kode QR berikut\nMenggunakan fitur scan pada WhatsApp\n Agar server bisa terhubung",
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

                    if (_imageBytes == null) // Menampilkan hitungan mundur jika QR code belum berhasil diambil
                      Text(
                        'Mengambil ulang dalam $_countdown detik...',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),

                    if (_isProcessingServer) // Menampilkan pesan jika status belum WORKING
                      Text(
                        'Scan kode QR diatas\nAgar server bisa \nMendeteksi pesan WhatsApp . . .',
                        style: greyTextStyle.copyWith(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    // else
                    //   Text(
                    //     'Silahkan klik tombol berikut',
                    //     style: blackTextStyle.copyWith(
                    //       fontSize: 16,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    

                    const SizedBox(
                      height: 20,
                    ),

                    _isQRCodeReady && !_isProcessingServer
                      ? CustomFilledButton(
                          title: 'Selanjutnya',
                          onPressed: () {
                            if (validate()) {
                              context.read<AuthBloc>().add(
                                AuthUpdatePhoneNumber(phoneNumber!)
                              );
                            } else {
                              showCustomSnackbar(
                                  context, 'Nomor handphone kosong');
                            }
                          },
                        )
                      : CustomLoadingButton(
                          title: 'Server sedang memproses',
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

  @override
  void dispose() {
    _timer?.cancel(); // Pastikan timer dibatalkan saat widget dihapus
    super.dispose();
  }
}


