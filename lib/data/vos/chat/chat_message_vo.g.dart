// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageVO _$ChatMessageVOFromJson(Map<String, dynamic> json) =>
    ChatMessageVO(
      messageContent: json['messageContent'] as String?,
      messageType: json['messageType'] as String?,
      timeStamp: json['timeStamp'] as String?,
    );

Map<String, dynamic> _$ChatMessageVOToJson(ChatMessageVO instance) =>
    <String, dynamic>{
      'messageContent': instance.messageContent,
      'messageType': instance.messageType,
      'timeStamp': instance.timeStamp,
    };
