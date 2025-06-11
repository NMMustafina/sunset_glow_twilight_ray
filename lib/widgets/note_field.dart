import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sdihfoiksj/color_ashfuoaj.dart';

class NoteField extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController? controller;

  const NoteField({
    super.key,
    required this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colorasdf.bg2,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Colorasdf.primary,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter text',
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colorasdf.primary.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
