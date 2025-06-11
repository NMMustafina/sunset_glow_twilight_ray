import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sunset_glow_twilight_ray_276_a/screens/photo_viewer_screen.dart';

import '../models/sunset_photo_model.dart';
import '../sdihfoiksj/color_ashfuoaj.dart';
import '../widgets/category_filter_dropdown.dart';
import '../widgets/gallery_empty_state.dart';
import '../widgets/sunset_photo_card.dart';
import 'add_edit_photo_screen.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  SunsetCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorasdf.background,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colorasdf.background,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            'Gallery',
            style: TextStyle(
              color: Colorasdf.primary,
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 162.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(32.w, 6.h, 32.w, 0),
                  child: CategoryFilterDropdown(
                    selected: selectedCategory,
                    onChanged: (value) {
                      setState(() => selectedCategory = value);
                    },
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable:
                        GetIt.I<Box<SunsetPhotoModel>>().listenable(),
                    builder: (context, Box<SunsetPhotoModel> box, _) {
                      final allPhotos = box.values.toList();
                      final filtered = selectedCategory == null
                          ? allPhotos
                          : allPhotos
                              .where((p) => p.category == selectedCategory)
                              .toList();

                      if (filtered.isEmpty) {
                        return const GalleryEmptyState();
                      }

                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.w, vertical: 4.h),
                        child: GridView.builder(
                          itemCount: filtered.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                            childAspectRatio: 0.72,
                          ),
                          itemBuilder: (_, index) {
                            final photo = filtered[index];
                            return SunsetPhotoCard(
                              photo: photo,
                              onLikeToggle: () {
                                photo.isLiked = !photo.isLiked;
                                photo.save();
                              },
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (_) => PhotoViewerScreen(
                                    photos: allPhotos,
                                    initialIndex: index,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            left: 32.w,
            right: 32.w,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddEditPhotoScreen(),
                  ),
                );
              },
              child: Container(
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: Colorasdf.primaryGradient,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Add sunset photo',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colorasdf.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
