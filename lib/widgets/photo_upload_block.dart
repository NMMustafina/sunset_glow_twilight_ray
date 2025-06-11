import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../sdihfoiksj/color_ashfuoaj.dart';

class PhotoUploadBlock extends StatelessWidget {
  final bool hasPhoto;
  final VoidCallback onTap;
  final File? photo;
  final Function() onDelete;
  final Function(File newPhoto) onReplace;

  const PhotoUploadBlock({
    super.key,
    required this.hasPhoto,
    required this.onTap,
    this.photo,
    required this.onDelete,
    required this.onReplace,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !hasPhoto ? onTap : null,
      child: Center(
        child: hasPhoto && photo != null
            ? Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.file(
                      photo!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 14.h,
                    right: 14.w,
                    child: GestureDetector(
                      onTap: () {
                        showEditDeleteDialog(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 36.w),
                        decoration: BoxDecoration(
                          gradient: Colorasdf.primaryGradient,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : AspectRatio(
                aspectRatio: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colorasdf.bg2,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50.r,
                          height: 50.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colorasdf.accentStart.withOpacity(0.2),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colorasdf.accentStart,
                            size: 24.r,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Add a picture of the \nsunset',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colorasdf.primary.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> showEditDeleteDialog(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
                _pickImage();
              });
            },
            child: Text(
              'Edit photo',
              style: TextStyle(color: Colorasdf.blue, fontSize: 16.sp),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              onDelete();
              Navigator.pop(context);
            },
            isDestructiveAction: true,
            child: Text(
              'Delete photo',
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colorasdf.blue,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);

    if (result != null) {
      final file = File(result.path);
      onReplace(file);
    }
  }
}
