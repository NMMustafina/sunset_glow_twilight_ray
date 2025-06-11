import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sdihfoiksj/color_ashfuoaj.dart';

class ActionButton extends StatelessWidget {
  final bool isFormValid;
  final VoidCallback onSave;
  final bool isEditing;

  const ActionButton({
    super.key,
    required this.isFormValid,
    required this.onSave,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isFormValid ? onSave : null,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 48.h,
        margin: EdgeInsets.symmetric(horizontal: 32.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: isFormValid
              ? Colorasdf.primaryGradient
              : LinearGradient(
                  colors: Colorasdf.primaryGradient.colors
                      .map((c) => c.withOpacity(0.4))
                      .toList(),
                ),
        ),
        child: Text(
          isEditing ? 'Save' : 'Add',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
