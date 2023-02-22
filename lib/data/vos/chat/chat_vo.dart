import 'package:json_annotation/json_annotation.dart';
part 'chat_vo.g.dart';

@JsonSerializable()
class ChatVO {

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "messageText")
  String? messageText;

  @JsonKey(name: "imageURL")
  String? imageURL;

  @JsonKey(name: "time")
  String? time;

  ChatVO({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.time
  });

  factory ChatVO.fromJson(Map<String,dynamic> json) => _$ChatVOFromJson(json);

  Map<String,dynamic> toJson() => _$ChatVOToJson(this);

}