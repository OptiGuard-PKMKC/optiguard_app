import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_profile.freezed.dart';
part 'doctor_profile.g.dart';

List<DoctorProfile> doctorProfilesFromJson(List<dynamic> data) =>
    List<DoctorProfile>.from(data.map((x) => DoctorProfile.fromJson(x as Map<String, dynamic>)));

DoctorProfile doctorProfileFromJson(String str) =>
    DoctorProfile.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
class DoctorProfile with _$DoctorProfile {
  const DoctorProfile._();

  const factory DoctorProfile({
    required int id,
    String? title,
    String? subTitle,
    String? description,
    String? preview,
  }) = _DoctorProfile;

  factory DoctorProfile.fromJson(Map<String, dynamic> json) => _$DoctorProfileFromJson(json);
}
