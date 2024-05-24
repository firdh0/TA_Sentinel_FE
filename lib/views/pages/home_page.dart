import 'package:chat_armor/blocs/auth/auth_bloc.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/home_feature_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            children: [
              buildProfile(context),
              buildWalletCard(),
              buildFeature(),
            ],
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfile(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Container(
            margin: const EdgeInsets.only(
              top: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Howdy,',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      state.user.username.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: Container(
                    width: 60,
                    height: 60,
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
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: whiteColor,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check_circle,
                                  color: greenColor,
                                  size: 14,
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget buildWalletCard() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {

        if (state is AuthSuccess) {
          return Container(
            width: double.infinity,
            height: 220,
            margin: const EdgeInsets.only(
              top: 30,
            ),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              image: const DecorationImage(
                // fit: BoxFit.cover,
                image: AssetImage('assets/img_bg_card.png'),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nomor WhatsApp',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),

                const SizedBox(
                  height: 28,
                ),

                Text(
                  state.user.phoneNumber.toString(),
                  
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                    letterSpacing: 5,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                // INI JADIKAN DISABLE NANTI KETIKA WA BELUM TERHUBUNG
                Container(
                  width: 120,
                  height: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: state.user.phoneNumber == null ? grey2Color : whiteColor,
                  ),
                  child: Row(
                    children: [
                      Center(
                        child: Icon(
                          Icons.check_circle,
                          color: state.user.phoneNumber == null ? whiteColor : greenColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Terhubung',
                        style: state.user.phoneNumber == null
                            ? whiteTextStyle.copyWith(fontSize: 13)
                            : greenTextStyle.copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                ),

                // INI VERSI DISABLE NANTI KETIKA WA BELUM TERHUBUNG
                // Container(
                //   width: 120,
                //   height: 30,
                //   padding: const EdgeInsets.all(4),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     color: grey2Color,
                //   ),

                //   child: Row(
                //     children: [
                //       Center(
                //         child: Icon(
                //           Icons.check_circle,
                //           color: whiteColor,
                //           size: 20,
                //         ),
                //       ),

                //       const SizedBox(
                //         width: 7,
                //       ),

                //       Text(
                //         'Terhubung',
                //         style: whiteTextStyle.copyWith(
                //           fontSize: 13,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget buildFeature() {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fitur',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(22),
            margin: const EdgeInsets.only(
              top: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: grey5Color,
            ),
            child: Column(
              children: const [
                HomeFeatureItem(
                    iconUrl: 'assets/ic_search.png', title: 'Deteksi Pesan'),

                // HomeFeatureItem(
                //   iconUrl: 'assets/ic_search.png',
                //   title: 'Hubungkan WhatsApp'
                // ),

                // HomeFeatureItem(
                //   iconUrl: 'assets/ic_search.png',
                //   title: 'Hubungkan WhatsApp'
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
