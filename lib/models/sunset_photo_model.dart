import 'package:hive/hive.dart';

part 'sunset_photo_model.g.dart';

@HiveType(typeId: 0)
class SunsetPhotoModel extends HiveObject {
  @HiveField(0)
  String photoPath;

  @HiveField(1)
  SunsetCategory category;

  @HiveField(2)
  DateTime time;

  @HiveField(3)
  String? note;

  @HiveField(4)
  bool isLiked;

  SunsetPhotoModel({
    required this.photoPath,
    required this.category,
    required this.time,
    this.note,
    this.isLiked = false,
  });
}

@HiveType(typeId: 1)
enum SunsetCategory {
  @HiveField(0)
  cityscape,
  @HiveField(1)
  natureLandscape,
  @HiveField(2)
  seascape,
  @HiveField(3)
  abstractRays,
}

extension SunsetCategoryExt on SunsetCategory {
  String get label {
    switch (this) {
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
}
