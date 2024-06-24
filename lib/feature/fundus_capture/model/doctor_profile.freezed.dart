// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DoctorProfile _$DoctorProfileFromJson(Map<String, dynamic> json) {
  return _DoctorProfile.fromJson(json);
}

/// @nodoc
mixin _$DoctorProfile {
  int get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get subTitle => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get preview => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DoctorProfileCopyWith<DoctorProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorProfileCopyWith<$Res> {
  factory $DoctorProfileCopyWith(
          DoctorProfile value, $Res Function(DoctorProfile) then) =
      _$DoctorProfileCopyWithImpl<$Res, DoctorProfile>;
  @useResult
  $Res call(
      {int id,
      String? title,
      String? subTitle,
      String? description,
      String? preview});
}

/// @nodoc
class _$DoctorProfileCopyWithImpl<$Res, $Val extends DoctorProfile>
    implements $DoctorProfileCopyWith<$Res> {
  _$DoctorProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? subTitle = freezed,
    Object? description = freezed,
    Object? preview = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subTitle: freezed == subTitle
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      preview: freezed == preview
          ? _value.preview
          : preview // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DoctorProfileImplCopyWith<$Res>
    implements $DoctorProfileCopyWith<$Res> {
  factory _$$DoctorProfileImplCopyWith(
          _$DoctorProfileImpl value, $Res Function(_$DoctorProfileImpl) then) =
      __$$DoctorProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? title,
      String? subTitle,
      String? description,
      String? preview});
}

/// @nodoc
class __$$DoctorProfileImplCopyWithImpl<$Res>
    extends _$DoctorProfileCopyWithImpl<$Res, _$DoctorProfileImpl>
    implements _$$DoctorProfileImplCopyWith<$Res> {
  __$$DoctorProfileImplCopyWithImpl(
      _$DoctorProfileImpl _value, $Res Function(_$DoctorProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? subTitle = freezed,
    Object? description = freezed,
    Object? preview = freezed,
  }) {
    return _then(_$DoctorProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subTitle: freezed == subTitle
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      preview: freezed == preview
          ? _value.preview
          : preview // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorProfileImpl extends _DoctorProfile {
  const _$DoctorProfileImpl(
      {required this.id,
      this.title,
      this.subTitle,
      this.description,
      this.preview})
      : super._();

  factory _$DoctorProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorProfileImplFromJson(json);

  @override
  final int id;
  @override
  final String? title;
  @override
  final String? subTitle;
  @override
  final String? description;
  @override
  final String? preview;

  @override
  String toString() {
    return 'DoctorProfile(id: $id, title: $title, subTitle: $subTitle, description: $description, preview: $preview)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subTitle, subTitle) ||
                other.subTitle == subTitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.preview, preview) || other.preview == preview));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, subTitle, description, preview);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorProfileImplCopyWith<_$DoctorProfileImpl> get copyWith =>
      __$$DoctorProfileImplCopyWithImpl<_$DoctorProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorProfileImplToJson(
      this,
    );
  }
}

abstract class _DoctorProfile extends DoctorProfile {
  const factory _DoctorProfile(
      {required final int id,
      final String? title,
      final String? subTitle,
      final String? description,
      final String? preview}) = _$DoctorProfileImpl;
  const _DoctorProfile._() : super._();

  factory _DoctorProfile.fromJson(Map<String, dynamic> json) =
      _$DoctorProfileImpl.fromJson;

  @override
  int get id;
  @override
  String? get title;
  @override
  String? get subTitle;
  @override
  String? get description;
  @override
  String? get preview;
  @override
  @JsonKey(ignore: true)
  _$$DoctorProfileImplCopyWith<_$DoctorProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
