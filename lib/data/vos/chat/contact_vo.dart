import 'package:json_annotation/json_annotation.dart';
import '../user_vo.dart';
part 'contact_vo.g.dart';

@JsonSerializable()
class ContactVO {

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "userId")
  String? userId;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "user_name")
  String? userName;

  ContactVO({
    required this.id,
    required this.userId,
    required this.email,
    required this.userName
  });

  factory ContactVO.fromJson(Map<String,dynamic> json) => _$ContactVOFromJson(json);

  Map<String,dynamic> toJson() => _$ContactVOToJson(this);

}