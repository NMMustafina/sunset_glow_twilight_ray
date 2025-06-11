import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sdihfoiksj/color_ashfuoaj.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final split = text.split('(optional)');
    final hasOptional = split.length > 1;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 4.r,
            height: 4.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colorasdf.accentStart,
              boxShadow: [
                BoxShadow(
                  color: Colorasdf.accentStart.withOpacity(0.9),
                  blurRadius: 2.r,
                  spreadRadius: 2.r,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: hasOptional
                ? RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colorasdf.primary,
                      ),
                      children: [
                        TextSpan(text: split[0]),
                        TextSpan(
                          text: '(optional)',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colorasdf.primary.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colorasdf.primary,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
