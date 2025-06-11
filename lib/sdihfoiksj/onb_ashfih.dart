import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sunset_glow_twilight_ray_276_a/sdihfoiksj/botbar_ashgfsajl.dart';
import 'package:sunset_glow_twilight_ray_276_a/sdihfoiksj/color_ashfuoaj.dart';
import 'package:sunset_glow_twilight_ray_276_a/sdihfoiksj/moti_adsafu.dart';

class OnBoDiasdf extends StatefulWidget {
  const OnBoDiasdf({super.key});

  @override
  State<OnBoDiasdf> createState() => _OnBoDiasdfState();
}

class _OnBoDiasdfState extends State<OnBoDiasdf> {
  final PageController _controller = PageController();
  int introIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorasdf.background,
      body: Stack(
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                introIndex = index;
              });
            },
            children: const [
              OnWid(
                image: '1',
              ),
              OnWid(
                image: '2',
              ),
              OnWid(
                image: '3',
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 300,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colorasdf.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        width: introIndex == 0
                            ? 100
                            : introIndex == 1
                                ? 200
                                : 300,
                        height: 8,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xffFC466C),
                              Color(0xffF31BAA),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 700.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MotiButaslmdf(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SSBotomBar(),
                      ),
                      (protected) => false,
                    );
                  },
                  child: Container(
                    height: 55,
                    width: 130.w,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 106, 180, 241),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Color.fromARGB(136, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                MotiButaslmdf(
                  onPressed: () {
                    if (introIndex != 2) {
                      _controller.animateToPage(
                        introIndex + 1,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.ease,
                      );
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SSBotomBar(),
                        ),
                        (protected) => false,
                      );
                    }
                  },
                  child: Container(
                    height: 55,
                    width: 130.w,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xffFC466C),
                          Color(0xffF31BAA),
                        ],
                      ),
                      // color: const Color.fromARGB(255, 106, 180, 241),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        introIndex != 2 ? 'Next' : 'Start',
                        style: const TextStyle(
                          color: Colorasdf.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnWid extends StatelessWidget {
  const OnWid({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/on$image.png',
      height: 812.h,
      width: 305.w,
      fit: BoxFit.cover,
      // alignment: Alignment.bottomCenter,
    );
  }
}
