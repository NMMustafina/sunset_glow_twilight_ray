import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sdihfoiksj/color_ashfuoaj.dart';

class GradientRadio extends StatelessWidget {
  final bool selected;

  const GradientRadio({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.r,
      height: 16.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFD0CFCA),
      ),
      alignment: Alignment.center,
      child: selected
          ? Container(
              width: 8.r,
              height: 8.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: Colorasdf.primaryGradient,
              ),
            )
          : null,
    );
  }
}
