import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_armor/shared/theme.dart';
import 'package:chat_armor/views/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  List<String> titles = [
    'Deteksi\nReal Time',
    'Integrasi\nMudah',
    'Dukungan Dari\nAI',
  ];

  List<String> subtitles = [
    'Deteksi dan kenali setiap pesan\nWhatsApp yang masuk,\nbiar chat kamu tetap aman dan asik!',
    'Sambungkan ke WhatsApp\nlangsung dengan kode QR,\nga pake lama langsung klop!',
    'Perlindungan tak terlihat tapi mantap!\nAI jadi jagoanmu, lawan pesan phishing\ntanpa cela',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 24
                  ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider(
                  items: [
                    Image.asset(
                      'assets/ilustrasi1.png',
                      width: screenWidth,
                    ),
                    Image.asset(
                      'assets/ilustrasi2.png',
                      width: screenWidth,
                    ),
                    Image.asset(
                      'assets/ilustrasi3.png',
                      width: screenWidth,
                    ),
                  ], 
                  options: CarouselOptions(
                    height: screenWidth,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason){
                      setState(() {
                        currentIndex = index;
                      });
                    }
                  ),
                  carouselController: carouselController,
                ),
      
                const SizedBox(
                  height: 40,
                ),
      
                Column(
                    children: [
                      Text(
                        titles[currentIndex],
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                        ),
                        textAlign: TextAlign.center,
                      ),
      
                      const SizedBox(
                        height: 10,
                      ),
      
                      Text(
                        subtitles[currentIndex],
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
      
                      SizedBox(
                        height: currentIndex == 2 ? 38 : 50,
                      ),
      
                      currentIndex == 2 
                          ? Column(
                              children: [
                                CustomFilledButton(
                                  title: 'Daftar',
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(context, '/sign-up', (route) => false);
                                  },
                                ),
      
                                const SizedBox(height: 20,),
      
                                CustomGreyFilledButton(
                                  title: 'Masuk',
                                  onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
                                  },
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  margin: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentIndex == 0 ? blueColor : grey3Color, 
                                  ),
                                ),
                                Container(
                                  width: 12,
                                  height: 12,
                                  margin: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentIndex == 1 ? blueColor : grey3Color, 
                                  ),
                                ),
                                Container(
                                  width: 12,
                                  height: 12,
                                  margin: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentIndex == 2 ? blueColor : grey3Color, 
                                  ),
                                ),
      
                                const Spacer(),
      
                                CustomFilledButton(
                                  width: 150,
                                  title: 'Selanjutnya',
                                  onPressed: () {
                                    carouselController.nextPage(); 
                                  },
                                ),
                              ],
                            )
                    ],
                  ),
      
                // Container(
                //   margin: const EdgeInsets.symmetric(
                //     horizontal: 24,
                //   ),
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 22,
                //     vertical: 24
                //   ),
                //   decoration: BoxDecoration(
                //     color: whiteColor,
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: 
                // ),
              ],
            ),
          ),
        ),
      )
    );
  }
}