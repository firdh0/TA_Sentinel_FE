import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/models/sign_up_form_model.dart';
import 'package:chat_armor/shared/shared_methods.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanQrcodePage extends StatefulWidget {
  final SignUpFormModel data;

  const ScanQrcodePage({Key? key, required this.data}) : super(key: key);

  @override
  State<ScanQrcodePage> createState() => _ScanQrcodePageState();
}

class _ScanQrcodePageState extends State<ScanQrcodePage> {
  final phoneNumber =
      '01234567890'; //JADIIN BISA AMBIL PHONE NUMBER + NAMPILIN KODE QRNYA

  bool validate() {
    if (phoneNumber == null) {
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
                  image: DecorationImage(image: AssetImage('assets/logo.png')),
                ),
              ),
              Text('Pindai kode QR &\nAmankan WhatsApp',
                  style: blackTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  )),
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
                    // Container(
                    //   width: 120,
                    //   height: 120,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: lightBackgroundColor,
                    //   ),
                    //   child: Center(child: Image.asset(
                    //       'assets/ic_upload.png',
                    //       width: 32,
                    //     ),
                    //   ),
                    // ),

                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/qr_code.png'),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    Text(
                      'Pindai kode QR di atas untuk\nterhubung dengan WhatsApp Anda',
                      style: greyTextStyle.copyWith(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(
                      height: 50,
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
