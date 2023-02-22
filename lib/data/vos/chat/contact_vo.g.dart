// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactVO _$ContactVOFromJson(Map<String, dynamic> json) => ContactVO(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      userName: json['user_name'] as String?,
    );

Map<String, dynamic> _$ContactVOToJson(ContactVO instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'email': instance.email,
      'user_name': instance.userName,
    };
