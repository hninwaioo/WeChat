import 'package:json_annotation/json_annotation.dart';
part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "phone_number")
  String? phoneNumber;

  @JsonKey(name: "otp_code")
  String? otpCode;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "birth_date")
  String? birthDate;

  @JsonKey(name: "gender")
  String? gender;


  UserVO({
    this.id,
    this.email,
    this.phoneNumber,
    this.otpCode,
    this.userName,
    this.password,
    this.birthDate,
    this.gender,
  });

  factory UserVO.fromJson(Map<String,dynamic> json) => _$UserVOFromJson(json);

  Map<String,dynamic> toJson() => _$UserVOToJson(this);

}