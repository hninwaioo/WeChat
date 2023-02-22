import 'package:json_annotation/json_annotation.dart';
part 'chat_message_vo.g.dart';

@JsonSerializable()
class ChatMessageVO {

  @JsonKey(name: "messageContent")
  String? messageContent;

  @JsonKey(name: "messageType")
  String? messageType;

  // timeStamp
  @JsonKey(name: "timeStamp")
  String? timeStamp;

  ChatMessageVO({
    required this.messageContent,
    required this.messageType,
    required this.timeStamp
  });

  factory ChatMessageVO.fromJson(Map<String,dynamic> json) => _$ChatMessageVOFromJson(json);

  Map<String,dynamic> toJson() => _$ChatMessageVOToJson(this);

}