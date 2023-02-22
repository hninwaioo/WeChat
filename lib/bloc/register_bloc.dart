import 'package:flutter/material.dart';
import '../models/authentication_model.dart';
import '../models/authentication_model_impl.dart';

class RegisterBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  bool isCheck = false;

  String email = "";
  // String phoneNumber = "";
  // String otpCode = "";
  String password = "";
  String userName = "";

  String birthDay = "";
  String birthMonth = "";
  String birthYear = "";

  String birthDate = "";
  String gender = "";
  bool isDisposed = false;

  ///Model
  final AuthenticationModel _model = AuthenticationModelImpl();

  Future onTapRegister(String phoneNumber, String otpCode){
    _showLoading();
    return _model.register(email, phoneNumber, otpCode, userName, password, birthDate, gender).whenComplete(()=> _hideLoading());

  }

  void onEmailChanged(String email) {
    this.email = email;
    debugPrint("UserEmail=====>${email}");

  }

  // void onPhoneChanged(String phoneNumber) {
  //   this.phoneNumber = phoneNumber;
  // }
  //
  // void onOTPCode(String otpCode){
  //   this.otpCode = otpCode;
  // }

  void onUserNameChanged(String userName){
    this.userName = userName;
    debugPrint("UserName=====>${userName}");
  }

  void onBirthDateDayChanged(String birthDay){
    this.birthDay = birthDay;
    debugPrint("birthDay=====>${birthDay}");

  }

  void onBirthDateMonthChanged(String birthMonth){
    this.birthMonth = birthMonth;
    debugPrint("birthMonth=====>${birthMonth}");

  }

  void onBirthDateYearChanged(String birthYear){
    this.birthYear = birthYear;
    debugPrint("birthYear=====>${birthYear}");

  }

  void onBirthDateChanged(String birth_date){
    birth_date = birthDay+"/"+birthMonth+"/"+birthYear;
    debugPrint("BirthDate=====>${birth_date}");
    this.birthDate = birth_date;
  }

  void onGenderChanged(String gender){
    this.gender = gender;
    debugPrint("gender=====>${gender}");

  }

  void onPasswordChanged(String password){
    this.password = password;
    debugPrint("gender=====>${password}");

  }

  void onCheckTermAndService(bool isCheckTermsAndService){
    this.isCheck = isCheckTermsAndService;
  }

  void _showLoading(){
    isLoading = true;
    _notifySafety();
  }

  void _hideLoading(){
    isLoading = false;
    _notifySafety();
  }

  void _notifySafety(){
    if(!isDisposed){
      notifyListeners();
    }
  }
  @override
  void dispose(){
    super.dispose();
    isDisposed = true;
  }

}