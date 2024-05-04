import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/home_feature_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          buildProfile(context),
          buildWalletCard(),
          buildFeature(),
        ],
      ),
    );
  }

  Widget buildProfile(BuildContext context){
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
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),

              const SizedBox(
                height: 2,
              ),

              Text(
                'firdhokk',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
            ],
          ),

          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/profile');
            },
            child: Container(
              width: 60,
              height: 60,
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
                  width: 17,
                  height: 17,
          
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWalletCard(){
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
          fit: BoxFit.cover,
          image: AssetImage('assets/img_bg_card.png'),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nomor Whatsapp',
            style: whiteTextStyle.copyWith(
              fontSize: 18,
              fontWeight: medium,
            ),
          ),

          const SizedBox(
            height: 28,
          ),

          Text(
            '081246578226',
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
              color: whiteColor,
            ),
            
            child: Row(
              children: [
                Center(
                  child: Icon(
                    Icons.check_circle,
                    color: greenColor,
                    size: 20,
                  ),
                ),

                const SizedBox(
                  width: 7,
                ),
                
                Text(
                  'Terhubung',
                  style: greenTextStyle.copyWith(
                    fontSize: 13,
                  ),
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

  Widget buildFeature(){
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
              color: whiteColor,
            ),

            child: Column(
              children: const [
                HomeFeatureItem(
                  iconUrl: 'assets/ic_search.png', 
                  title: 'Deteksi Pesan'
                ),

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