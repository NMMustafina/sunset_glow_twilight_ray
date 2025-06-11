import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../models/sunset_photo_model.dart';
import '../sdihfoiksj/color_ashfuoaj.dart';

class SunsetPhotoCard extends StatelessWidget {
  final SunsetPhotoModel photo;
  final VoidCallback onLikeToggle;
  final VoidCallback? onTap;

  const SunsetPhotoCard({
    super.key,
    required this.photo,
    required this.onLikeToggle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.file(
                  File(photo.photoPath),
                  width: double.infinity,
                  height: 140.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: GestureDetector(
                  onTap: onLikeToggle,
                  child: Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      color: Colorasdf.background,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      photo.isLiked
                          ? 'assets/icons/heart_fill.svg'
                          : 'assets/icons/heart.svg',
                      width: 20.r,
                      height: 20.r,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            photo.category.label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: Colorasdf.primary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            photo.note ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colorasdf.primary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
