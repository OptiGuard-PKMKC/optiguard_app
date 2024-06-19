import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

List<Appointment> appointmentsFromJson(List<dynamic> data) =>
    List<Appointment>.from(data.map((x) => Appointment.fromJson(x as Map<String, dynamic>)));

Appointment appointmentFromJson(String str) =>
    Appointment.fromJson(json.decode(str) as Map<String, dynamic>);

@freezed
class Appointment with _$Appointment {
  const Appointment._();

  const factory Appointment({
    required int id,
    String? title,
    String? subTitle,
    String? description,
    String? preview,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);
}
