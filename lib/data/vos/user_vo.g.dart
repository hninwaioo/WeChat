// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      id: json['id'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      otpCode: json['otp_code'] as String?,
      userName: json['user_name'] as String?,
      password: json['password'] as String?,
      birthDate: json['birth_date'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'otp_code': instance.otpCode,
      'user_name': instance.userName,
      'password': instance.password,
      'birth_date': instance.birthDate,
      'gender': instance.gender,
    };
