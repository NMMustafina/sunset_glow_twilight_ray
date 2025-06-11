import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/sunset_photo_model.dart';
import '../sdihfoiksj/color_ashfuoaj.dart';
import 'gradient_radio.dart';

class CategoryFilterDropdown extends StatefulWidget {
  final SunsetCategory? selected;
  final void Function(SunsetCategory?) onChanged;

  const CategoryFilterDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<CategoryFilterDropdown> createState() => _CategoryFilterDropdownState();
}

class _CategoryFilterDropdownState extends State<CategoryFilterDropdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final categories = [null, ...SunsetCategory.values];

    final dropdownContent = Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: categories.map((category) {
          final isSelected = widget.selected == category;
          final isLast = category == categories.last;

          return Column(
            children: [
              InkWell(
                onTap: () {
                  widget.onChanged(category);
                  setState(() => _isExpanded = false);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    children: [
                      GradientRadio(selected: isSelected),
                      SizedBox(width: 12.w),
                      Text(
                        _getLabel(category),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colorasdf.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colorasdf.primary.withOpacity(0.1),
                ),
              if (isLast) SizedBox(height: 16.h),
            ],
          );
        }).toList(),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Container(
            height: 52.h,
            decoration: BoxDecoration(
              color: Colorasdf.bg2,
              borderRadius: _isExpanded
                  ? BorderRadius.vertical(top: Radius.circular(12.r))
                  : BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/filter.svg',
                  width: 16.r,
                  height: 16.r,
                  colorFilter: const ColorFilter.mode(
                      Colorasdf.accentStart, BlendMode.srcIn),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    _getLabel(widget.selected),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colorasdf.primary,
                    ),
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 20.r,
                  color: Colorasdf.primary,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            decoration: BoxDecoration(
              color: Colorasdf.bg2,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(12.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: dropdownContent,
          ),
        SizedBox(height: 12.h),
      ],
    );
  }

  String _getLabel(SunsetCategory? category) {
    if (category == null) return 'All photos';
    return category.label;
  }
}
