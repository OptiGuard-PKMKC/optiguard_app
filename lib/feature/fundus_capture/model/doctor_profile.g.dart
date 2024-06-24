// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorProfileImpl _$$DoctorProfileImplFromJson(Map<String, dynamic> json) =>
    _$DoctorProfileImpl(
      id: json['id'] as int,
      title: json['title'] as String?,
      subTitle: json['subTitle'] as String?,
      description: json['description'] as String?,
      preview: json['preview'] as String?,
    );

Map<String, dynamic> _$$DoctorProfileImplToJson(_$DoctorProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'description': instance.description,
      'preview': instance.preview,
    };
