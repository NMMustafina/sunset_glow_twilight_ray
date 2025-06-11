import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../models/sunset_photo_model.dart';
import '../sdihfoiksj/color_ashfuoaj.dart';
import 'add_edit_photo_screen.dart';

class PhotoViewerScreen extends StatefulWidget {
  final List<SunsetPhotoModel> photos;
  final int initialIndex;

  const PhotoViewerScreen({
    super.key,
    required this.photos,
    required this.initialIndex,
  });

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: _currentIndex);
  }

  void _editCurrent() {
    final photo = widget.photos[_currentIndex];
    Navigator.of(context, rootNavigator: true).pop();
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (_) => AddEditPhotoScreen(
            isEditing: true,
            initialPhoto: photo,
            photoKey: photo.key as int,
          ),
        ),
      );
    });
  }

  void _handleVerticalDrag(DragUpdateDetails details) {
    if (details.primaryDelta != null && details.primaryDelta! > 10) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Colorasdf.primary,
      ),
      child: CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        child: SafeArea(
          child: GestureDetector(
            onVerticalDragUpdate: _handleVerticalDrag,
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
                PageView.builder(
                  controller: _controller,
                  itemCount: widget.photos.length,
                  onPageChanged: (index) =>
                      setState(() => _currentIndex = index),
                  itemBuilder: (_, index) {
                    final photo = widget.photos[index];
                    final formattedTime = DateFormat.jm().format(photo.time);

                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.w, vertical: 32.h),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 64.h,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 60.h),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: Image.file(
                                        File(photo.photoPath),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () => Navigator.of(context,
                                              rootNavigator: true)
                                          .pop(),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 32.w, vertical: 14.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Text(
                                          'Close',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colorasdf.primary,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 74.h,
                                    left: 14.w,
                                    child: GestureDetector(
                                      onTap: _editCurrent,
                                      child: Container(
                                        padding: EdgeInsets.all(12.r),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icons/edit.svg',
                                          width: 24.r,
                                          height: 24.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(16.r),
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 2, sigmaY: 2),
                                        child: Container(
                                          color: Colors.black.withOpacity(0.2),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.h),
                                          alignment: Alignment.center,
                                          child: Text(
                                            formattedTime,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if ((photo.note?.trim().isNotEmpty ?? false)) ...[
                                SizedBox(height: 16.h),
                                Container(
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    photo.note!,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colorasdf.primary,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
