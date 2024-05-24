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
