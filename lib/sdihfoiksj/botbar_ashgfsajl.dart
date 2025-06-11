import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sunset_glow_twilight_ray_276_a/dsgjvkmsd/askfmgjn.dart';
import 'package:sunset_glow_twilight_ray_276_a/dsgjvkmsd/jfg.dart';
import 'package:sunset_glow_twilight_ray_276_a/dsgjvkmsd/nfgjnj.dart';
import 'package:sunset_glow_twilight_ray_276_a/sdihfoiksj/moti_adsafu.dart';

import '../screens/gallery_page.dart';

class SSBotomBar extends StatefulWidget {
  const SSBotomBar({super.key, this.indexScr = 0});
  final int indexScr;

  @override
  State<SSBotomBar> createState() => SSBotomBarState();
}

class SSBotomBarState extends State<SSBotomBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 75.h,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFE3E2DD),
          borderRadius: BorderRadius.circular(16),
          // border: Border(
          //     top: BorderSide(
          //   color: Colors.white.withOpacity(0.1),
          // )),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildNavItem(
              0,
              'assets/icons/1.png',
              'assets/icons/11.png',
            ),
            buildNavItem(
              1,
              'assets/icons/2.png',
              'assets/icons/22.png',
            ),
            buildNavItem(
              2,
              'assets/icons/3.png',
              'assets/icons/33.png',
            ),
            buildNavItem(
              3,
              'assets/icons/4.png',
              'assets/icons/44.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(int index, String iconPath, String ima2) {
    bool isActive = _currentIndex == index;

    return MotiButaslmdf(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        width: isActive ? 130.w : 60.w,
        color: Colors.transparent,
        // decoration: BoxDecoration(
        //   color: isActive ? Colorasdf.blue : Colors.white.withOpacity(0.0),
        //   borderRadius: BorderRadius.circular(14),
        // ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                isActive ? iconPath : ima2,
                color: isActive ? null : const Color.fromARGB(40, 0, 0, 0),
                width: isActive ? 130.w : 24.w,
                height: isActive ? 50.h : 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _pages = <Widget>[
    const GalleryPage(),
    const Askfmgjn(),
    const Jfg(),
    const Nfgjnj(),
  ];
}
