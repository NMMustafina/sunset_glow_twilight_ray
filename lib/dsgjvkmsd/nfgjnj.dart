import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sunset_glow_twilight_ray_276_a/sdihfoiksj/color_ashfuoaj.dart';
import 'package:sunset_glow_twilight_ray_276_a/sdihfoiksj/dok_askbfgkahk.dart';
import 'package:sunset_glow_twilight_ray_276_a/sdihfoiksj/moti_adsafu.dart';
import 'package:sunset_glow_twilight_ray_276_a/sdihfoiksj/pro_idashf.dart';

class Nfgjnj extends StatelessWidget {
  const Nfgjnj({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colorasdf.black,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(33, 62, 61, 61),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  MotiButaslmdf(
                    onPressed: () {
                      lauchUrl(context, DokSS.priPoli);
                    },
                    child: Image.asset(
                      'assets/images/1.png',
                      width: double.infinity,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(56, 61, 61, 61),
                    height: 30,
                  ),
                  MotiButaslmdf(
                    onPressed: () {
                      lauchUrl(context, DokSS.terOfUse);
                    },
                    child: Image.asset(
                      'assets/images/2.png',
                      width: double.infinity,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(56, 61, 61, 61),
                    height: 30,
                  ),
                  MotiButaslmdf(
                    onPressed: () {
                      lauchUrl(context, DokSS.suprF);
                    },
                    child: Image.asset(
                      'assets/images/3.png',
                      width: double.infinity,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
