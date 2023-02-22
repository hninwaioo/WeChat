import 'package:flutter/material.dart';
import 'package:wechat/data/vos/otp_code_vo.dart';
import '../models/authentication_model.dart';
import '../models/authentication_model_impl.dart';

class OTPCodeBloc extends ChangeNotifier {
  /// State
  bool isLoading = false;
  String phoneNumber = "";
  String otpCode = "";
  bool isDisposed = false;
  bool isPhoneNumberError = false;
  bool isPhoneNumber = false;
  bool isResendCode = false;
  OTPCodeVO? otpCodeVO;

  ///Model
  final AuthenticationModel _model = AuthenticationModelImpl();

  Future onTapGetOTP(){
    _showLoading();
    if(phoneNumber.isEmpty){
      isPhoneNumberError = true;
      _notifySafety();
      return Future.error("Error");
    }
    else{
      isLoading = true;
      _notifySafety();
      isPhoneNumberError = false;

      if(isPhoneNumber){
        otpCodeVO?.phoneNumber = phoneNumber;
        if(otpCodeVO != null){
          // return _model.editPost(mNewsFeed!,chosenImageFile);
          isResendCode = true;
        }
        // return _resendOTPCodePost()
        //     .then((value){
          isLoading = false;
        //   _notifySafety();
        //   // _sendAnalyticsData(editPostAction, {postId: mNewsFeed?.id.toString() ?? ""});
        // });
      }else{
        return _getNewOTPCode().then((value){
          isResendCode = false;
          isLoading = false;
          _notifySafety();
          // _sendAnalyticsData(addNewPostAction, null);
        });
      }
      // return _model.addNewPost(newPostDescription);
    }
    return _model.getOTP(phoneNumber, otpCode,).whenComplete(()=> _hideLoading());

  }

  Future<void> _getNewOTPCode(){
    return _model.getOTP(phoneNumber, otpCode,).whenComplete(()=> _hideLoading());
  }


  bool _resendOTPCodePost(){
    otpCodeVO?.phoneNumber = phoneNumber;
    if(otpCodeVO != null){
      // return _model.editPost(mNewsFeed!,chosenImageFile);
      return isPhoneNumber = true;
    }else {
      return isPhoneNumber = false;
      // return Future.error("Error");
    }
  }

  void onPhoneChanged(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  void onOTPCode(String otpCode){
    this.otpCode = otpCode;
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