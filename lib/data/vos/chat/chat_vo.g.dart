// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatVO _$ChatVOFromJson(Map<String, dynamic> json) => ChatVO(
      name: json['name'] as String?,
      messageText: json['messageText'] as String?,
      imageURL: json['imageURL'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$ChatVOToJson(ChatVO instance) => <String, dynamic>{
      'name': instance.name,
      'messageText': instance.messageText,
      'imageURL': instance.imageURL,
      'time': instance.time,
    };
