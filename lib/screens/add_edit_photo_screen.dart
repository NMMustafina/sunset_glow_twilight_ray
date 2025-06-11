import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/sunset_photo_model.dart';
import '../sdihfoiksj/color_ashfuoaj.dart';
import '../widgets/action_button.dart';
import '../widgets/category_selector.dart';
import '../widgets/note_field.dart';
import '../widgets/photo_upload_block.dart';
import '../widgets/section_title.dart';
import '../widgets/time_selector.dart';

class AddEditPhotoScreen extends StatefulWidget {
  final bool isEditing;
  final SunsetPhotoModel? initialPhoto;
  final int? photoKey;

  const AddEditPhotoScreen({
    super.key,
    this.isEditing = false,
    this.initialPhoto,
    this.photoKey,
  });

  @override
  State<AddEditPhotoScreen> createState() => _AddEditPhotoScreenState();
}

class _AddEditPhotoScreenState extends State<AddEditPhotoScreen> {
  String? _selectedCategory;
  TimeOfDay? _selectedTime;
  late final TextEditingController _noteController;
  bool _hasPhoto = false;
  XFile? _photo;
  int? _photoKey;
  late final TimeOfDay _initialTime;
  SunsetPhotoModel? _initialPhoto;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.initialPhoto != null) {
      final photo = widget.initialPhoto!;
      _initialPhoto = photo;
      _photoKey = widget.photoKey;
      _photo = XFile(photo.photoPath);
      _hasPhoto = true;
      _selectedCategory = _stringFromCategory(photo.category);
      _selectedTime = TimeOfDay.fromDateTime(photo.time);
      _initialTime = _selectedTime!;
      _noteController = TextEditingController(text: photo.note ?? '');
    } else {
      _selectedTime = TimeOfDay.now();
      _initialTime = _selectedTime!;
      _noteController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorasdf.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.isEditing ? 'Sunset editing' : 'Sunset adding',
          style: const TextStyle(
            color: Colorasdf.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colorasdf.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 60.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colorasdf.primary),
            onPressed: () async {
              final shouldLeave = await _showLeaveConfirmation();
              if (shouldLeave) Navigator.pop(context);
            },
          ),
        ),
        actions: widget.isEditing
            ? [
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: GestureDetector(
                    onTap: _showDeleteConfirmation,
                    child: SizedBox(
                      width: 38.r,
                      height: 38.r,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/trash.svg',
                          width: 38.r,
                          height: 38.r,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 32.w,
              right: 32.w,
              top: 20.h,
              bottom: 90.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(
                    text: 'Add a photo of a sunset (limit 1 photo)'),
                PhotoUploadBlock(
                  hasPhoto: _hasPhoto,
                  onTap: _pickImage,
                  photo: _photo != null ? File(_photo!.path) : null,
                  onDelete: _deletePhoto,
                  onReplace: _updatePhoto,
                ),
                SizedBox(height: 24.h),
                const SectionTitle(text: 'Select a photo category:'),
                CategorySelector(
                  selected: _selectedCategory,
                  onSelect: (val) {
                    setState(() {
                      _selectedCategory = _selectedCategory == val ? null : val;
                    });
                  },
                ),
                SizedBox(height: 24.h),
                const SectionTitle(
                    text: 'Select the time the photo was taken:'),
                TimeSelector(
                  selectedTime: _selectedTime!,
                  onTimeChanged: _onTimeChanged,
                  onTap: () async {
                    final newTime = await showCustomTimePicker(
                      context,
                      _selectedTime ?? TimeOfDay.now(),
                    );
                    if (newTime != null) {
                      setState(() {
                        _selectedTime = newTime;
                      });
                    }
                  },
                ),
                SizedBox(height: 24.h),
                const SectionTitle(
                    text: 'Type a note for the photo (optional)'),
                NoteField(
                  controller: _noteController,
                  onChanged: (v) => setState(() {}),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 80.h,
              color: Colorasdf.background,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16.h,
            child: Center(
              child: ActionButton(
                isFormValid: widget.isEditing ? _hasChanges() : _isFormValid(),
                onSave: _handleSubmit,
                isEditing: widget.isEditing,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isFormValid() =>
      _hasPhoto && _selectedCategory != null && _selectedTime != null;

  bool _hasChanges() {
    if (_initialPhoto == null) return false;
    return _photo?.path != _initialPhoto!.photoPath ||
        _stringFromCategory(_initialPhoto!.category) != _selectedCategory ||
        _initialPhoto!.time.hour != _selectedTime!.hour ||
        _initialPhoto!.time.minute != _selectedTime!.minute ||
        (_initialPhoto!.note ?? '') != _noteController.text;
  }

  Future<void> _handleSubmit() async {
    if (!(widget.isEditing ? _hasChanges() : _isFormValid())) return;

    final box = GetIt.I<Box<SunsetPhotoModel>>();
    final newPhoto = SunsetPhotoModel(
      photoPath: _photo!.path,
      category: _parseCategory(_selectedCategory!),
      time: DateTime(
        2000,
        1,
        1,
        _selectedTime!.hour,
        _selectedTime!.minute,
      ),
      note: _noteController.text.isNotEmpty ? _noteController.text : null,
    );

    if (widget.isEditing && _photoKey != null) {
      await box.put(_photoKey, newPhoto);
    } else {
      await box.add(newPhoto);
    }

    Navigator.pop(context);
  }

  void _deletePhoto() {
    setState(() {
      _photo = null;
      _hasPhoto = false;
    });
  }

  void _updatePhoto(File newPhoto) {
    setState(() {
      _photo = XFile(newPhoto.path);
      _hasPhoto = true;
    });
  }

  void _onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _selectedTime = newTime;
    });
  }

  Future<void> _pickImage() async {
    final status = await Permission.mediaLibrary.request();
    if (!status.isGranted) {
      await showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Access to Photos has been denied'),
          content: const Text(
            'Allow access in Settings. This will allow you to add sunset photos',
            style: TextStyle(color: Colors.black54),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                openAppSettings();
                Navigator.pop(context);
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      );
      return;
    }

    final picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);

    if (result != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = result.name;
      final savedImage =
          await File(result.path).copy('${directory.path}/$fileName');

      setState(() {
        _photo = XFile(savedImage.path);
        _hasPhoto = true;
      });
    }
  }

  SunsetCategory _parseCategory(String value) {
    switch (value) {
      case 'Cityscape':
        return SunsetCategory.cityscape;
      case 'Nature landscape':
        return SunsetCategory.natureLandscape;
      case 'Seascape':
        return SunsetCategory.seascape;
      case 'Abstract rays':
        return SunsetCategory.abstractRays;
      default:
        throw Exception('Unknown category: $value');
    }
  }

  String _stringFromCategory(SunsetCategory category) {
    switch (category) {
      case SunsetCategory.cityscape:
        return 'Cityscape';
      case SunsetCategory.natureLandscape:
        return 'Nature landscape';
      case SunsetCategory.seascape:
        return 'Seascape';
      case SunsetCategory.abstractRays:
        return 'Abstract rays';
    }
  }

  Future<bool> _showLeaveConfirmation() async {
    final hasChanges = _hasChanges();
    if (!hasChanges) return true;

    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('Leave the page'),
        content: Text(
          widget.isEditing
              ? 'Your sunset changes will not be saved'
              : 'This sunset will not be added to your collection',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
          CupertinoDialogAction(
            isDestructiveAction: false,
            child: const Text('Leave', style: TextStyle(color: Colors.blue)),
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  void _showDeleteConfirmation() async {
    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Sunset delete'),
        content: const Text(
          'Are you sure you want to delete this sunset? This action cannot be canceled',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(ctx, true),
            isDestructiveAction: true,
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (result == true && _photoKey != null) {
      final box = GetIt.I<Box<SunsetPhotoModel>>();
      await box.delete(_photoKey);
      Navigator.pop(context);
    }
  }
}
