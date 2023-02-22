// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_code_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPCodeVO _$OTPCodeVOFromJson(Map<String, dynamic> json) => OTPCodeVO(
      id: json['id'] as int?,
      phoneNumber: json['phone_number'] as String?,
      otpCode: json['otp_code'] as String?,
    );

Map<String, dynamic> _$OTPCodeVOToJson(OTPCodeVO instance) => <String, dynamic>{
      'id': instance.id,
      'phone_number': instance.phoneNumber,
      'otp_code': instance.otpCode,
    };
