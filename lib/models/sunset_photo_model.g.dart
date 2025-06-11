// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sunset_photo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SunsetPhotoModelAdapter extends TypeAdapter<SunsetPhotoModel> {
  @override
  final int typeId = 0;

  @override
  SunsetPhotoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SunsetPhotoModel(
      photoPath: fields[0] as String,
      category: fields[1] as SunsetCategory,
      time: fields[2] as DateTime,
      note: fields[3] as String?,
      isLiked: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SunsetPhotoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.photoPath)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.isLiked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SunsetPhotoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SunsetCategoryAdapter extends TypeAdapter<SunsetCategory> {
  @override
  final int typeId = 1;

  @override
  SunsetCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SunsetCategory.cityscape;
      case 1:
        return SunsetCategory.natureLandscape;
      case 2:
        return SunsetCategory.seascape;
      case 3:
        return SunsetCategory.abstractRays;
      default:
        return SunsetCategory.cityscape;
    }
  }

  @override
  void write(BinaryWriter writer, SunsetCategory obj) {
    switch (obj) {
      case SunsetCategory.cityscape:
        writer.writeByte(0);
        break;
      case SunsetCategory.natureLandscape:
        writer.writeByte(1);
        break;
      case SunsetCategory.seascape:
        writer.writeByte(2);
        break;
      case SunsetCategory.abstractRays:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SunsetCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
