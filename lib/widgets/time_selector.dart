import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sdihfoiksj/color_ashfuoaj.dart';

Future<TimeOfDay?> showCustomTimePicker(
    BuildContext context, TimeOfDay initialTime) {
  DateTime selectedDateTime = DateTime(
    2023,
    1,
    1,
    initialTime.hour,
    initialTime.minute,
  );

  return showCupertinoModalPopup<TimeOfDay>(
    context: context,
    builder: (_) => CupertinoActionSheet(
      message: SizedBox(
        height: 180.h,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          use24hFormat: false,
          initialDateTime: selectedDateTime,
          onDateTimeChanged: (DateTime newDateTime) {
            selectedDateTime = newDateTime;
          },
        ),
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            final newTime = TimeOfDay.fromDateTime(selectedDateTime);
            Navigator.pop(context, newTime);
          },
          child: Text(
            'Select',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colorasdf.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context, null),
        child: Text(
          'Cancel',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colorasdf.blue,
          ),
        ),
      ),
    ),
  );
}

class TimeSelector extends StatefulWidget {
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeChanged;
  final VoidCallback onTap;

  const TimeSelector({
    super.key,
    required this.selectedTime,
    required this.onTimeChanged,
    required this.onTap,
  });

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  late String selectedPeriod;

  @override
  void initState() {
    super.initState();
    selectedPeriod = widget.selectedTime.hour >= 12 ? 'PM' : 'AM';
  }

  @override
  void didUpdateWidget(covariant TimeSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedTime != oldWidget.selectedTime) {
      selectedPeriod = widget.selectedTime.hour >= 12 ? 'PM' : 'AM';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hour = widget.selectedTime.hourOfPeriod.toString().padLeft(2, '0');
    final minute = widget.selectedTime.minute.toString().padLeft(2, '0');
    final timeStr = '$hour : $minute';

    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _timeBox(timeStr),
          _periodBox(),
        ],
      ),
    );
  }

  Widget _timeBox(String text) {
    final parts = text.split(' : ');
    return Container(
      width: 150.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: Colorasdf.bg2,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            parts[0],
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colorasdf.primary,
            ),
          ),
          Text(
            ':',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colorasdf.primary,
            ),
          ),
          Text(
            parts[1],
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colorasdf.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _periodBox() {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 150.w,
        child: _PeriodDropdown(
          selected: selectedPeriod,
          onChanged: (newPeriod) {
            int hour = widget.selectedTime.hour;
            final minute = widget.selectedTime.minute;

            if (newPeriod == 'PM' && hour < 12) hour += 12;
            if (newPeriod == 'AM' && hour >= 12) hour -= 12;

            setState(() {
              selectedPeriod = newPeriod;
              widget.onTimeChanged(TimeOfDay(hour: hour, minute: minute));
            });
          },
        ),
      ),
    );
  }
}

class _PeriodDropdown extends StatefulWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _PeriodDropdown({
    required this.selected,
    required this.onChanged,
  });

  @override
  State<_PeriodDropdown> createState() => _PeriodDropdownState();
}

class _PeriodDropdownState extends State<_PeriodDropdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final dropdownContent = Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: ['AM', 'PM'].map((period) {
          final isSelected = widget.selected == period;
          final isLast = period == 'PM';

          return Column(
            children: [
              InkWell(
                onTap: () {
                  widget.onChanged(period);
                  setState(() => _isExpanded = false);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    children: [
                      Text(
                        period,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: widget.selected == period
                              ? Colorasdf.primary.withOpacity(0.3)
                              : Colorasdf.primary,
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
            height: 48.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colorasdf.bg2,
              borderRadius: _isExpanded
                  ? BorderRadius.vertical(top: Radius.circular(12.r))
                  : BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.selected,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colorasdf.primary,
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
            width: double.infinity,
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
      ],
    );
  }
}
