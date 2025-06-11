import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sdihfoiksj/color_ashfuoaj.dart';

class CategorySelector extends StatelessWidget {
  final String? selected;
  final Function(String) onSelect;

  const CategorySelector(
      {super.key, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Cityscape',
      'Nature landscape',
      'Seascape',
      'Abstract rays'
    ];
    return Column(
      children: categories.map((category) {
        final isActive = selected == category;
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: GestureDetector(
            onTap: () {
              if (isActive) {
                onSelect('');
              } else {
                onSelect(category);
              }
            },
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colorasdf.bg2,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colorasdf.primary,
                      ),
                    ),
                  ),
                  if (isActive)
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Container(
                        width: 24.r,
                        height: 24.r,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: Colorasdf.primaryGradient.colors),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 16.r,
                          color: Colorasdf.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
