import 'package:json_annotation/json_annotation.dart';
part 'otp_code_vo.g.dart';

@JsonSerializable()
class OTPCodeVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "phone_number")
  String? phoneNumber;

  @JsonKey(name: "otp_code")
  String? otpCode;

  OTPCodeVO({
    this.id,
    this.phoneNumber,
    this.otpCode,
  });

  factory OTPCodeVO.fromJson(Map<String,dynamic> json) => _$OTPCodeVOFromJson(json);

  Map<String,dynamic> toJson() => _$OTPCodeVOToJson(this);

}