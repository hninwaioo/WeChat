import 'package:json_annotation/json_annotation.dart';
part 'chat_group_vo.g.dart';

@JsonSerializable()
class ChatGroupVO {

  @JsonKey(name: "groupImage")
  String? groupImage;

  @JsonKey(name: "groupName")
  String? groupName;


  ChatGroupVO({
    required this.groupImage,
    required this.groupName,
  });

  factory ChatGroupVO.fromJson(Map<String,dynamic> json) => _$ChatGroupVOFromJson(json);

  Map<String,dynamic> toJson() => _$ChatGroupVOToJson(this);

}