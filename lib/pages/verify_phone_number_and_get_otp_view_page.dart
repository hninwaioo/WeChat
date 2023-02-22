import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:wechat/bloc/get_otp_bloc.dart';
import 'package:wechat/pages/signup_data_view_page.dart';
import 'package:wechat/widgets/button_color_full_background.dart';
import '../bloc/register_bloc.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/back_button_action.dart';
import '../widgets/label_and_text_field_view.dart';
import '../widgets/typical_text.dart';
import '../widgets/welcome_and_hi_image_view.dart';
import '../utils/extensions.dart';

class VerifyPhoneNumberAndGetOTPViewPage extends StatefulWidget {
  const VerifyPhoneNumberAndGetOTPViewPage({Key? key}) : super(key: key);

  @override
  State<VerifyPhoneNumberAndGetOTPViewPage> createState() => _VerifyPhoneNumberAndGetOTPViewPageState();
}

class _VerifyPhoneNumberAndGetOTPViewPageState extends State<VerifyPhoneNumberAndGetOTPViewPage> {

  String _phoneNumber = "";
  bool isEnabledVerify = false;
  @override
  void initState(){
    super.initState();
    isEnabledVerify = false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => OTPCodeBloc(),
      
      child: Scaffold(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: PRIMARY_BACKGROUND_COLOR,
          leading: BackButtonAction(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(height: MARGIN_MEDIUM,),

              Container(
              margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: WelcomeAndHiImageView(
                image_one: "assets/images/hi_icon.svg",
                image_two: "assets/images/otp_page_logo.svg",
                textState: LOGIN_TO_CONTINUE,
              ),
            ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1.6,
                    child:
                    Consumer<OTPCodeBloc>(
                      builder: (context,bloc,child) =>
                          LabelAndTextFieldView(
                              label: ENTER_YOUR_PHONE_NUMBER,
                              hint: ENTER_YOUR_PHONE_NUMBER,
                              isNumberType: true,
                              onChanged: (phoneNumber){
                                bloc.onPhoneChanged(phoneNumber);
                                _phoneNumber = phoneNumber;
                                debugPrint("PhoneNumber===>${_phoneNumber}");
                              }),
                    ),
                  ),
                  Spacer(),

                  Consumer<OTPCodeBloc>(
                    builder: (context, bloc, child) =>
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              bloc.onTapGetOTP()
                                  .then((value) {

                                debugPrint("PhoneNumberError=>${bloc.isPhoneNumberError}");
                                debugPrint("isResendCode=>${bloc.isResendCode}");
                                debugPrint("isPhoneNumber=>${bloc.isPhoneNumber}");

                                isEnabledVerify = true;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text("OTP Code => 1234"))
                                );
                              })
                                  .catchError((error) =>
                              //     showSnackBarWithMessage(
                              //     context, error.toString()
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(error.toString()))
                              ));

                            });
                          },
                            child: ButtonColorFullBackground(btnText: GET_OTP,marginValue: MARGIN_MEDIUM_2,)
                        ),
                  )
                ],
              ),
              ),
              SizedBox(height: MARGIN_MEDIUM,),

              Container(
                margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: PhoneNumberErrorView()
              ),
              SizedBox(height: MARGIN_MEDIUM_LARGE,),
              GetOTPCodeSectionView(phoneNumber: _phoneNumber,isEnabledVerify: isEnabledVerify),
              SizedBox(height: MARGIN_MEDIUM_LARGE,),
          ],
        ),
      ),
    ));
  }
}

class PhoneNumberErrorView extends StatelessWidget {
  const PhoneNumberErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OTPCodeBloc>(
      builder: (context, bloc, child) =>
          Visibility(
            visible: bloc.isPhoneNumberError,
            child: TypicalText("Phone number should not be empty!", Colors.red, TEXT_REGULAR,isFontWeight: true),
          ),
    );
  }
}

class DontGetOtpResendCodeSectionView extends StatelessWidget {
  Function onTapResendOTP;
  DontGetOtpResendCodeSectionView({required this.onTapResendOTP});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TypicalText(DONT_RECEIVE_THE_OTP, HINT_TEXT_COLOR, TEXT_REGULAR),
            SizedBox(width: MARGIN_SMALL,),
            GestureDetector(
              onTap: (){
                onTapResendOTP();
              },
                child: TypicalText(RESEND_CODE, PRIMARY_COLOR, TEXT_REGULAR_1X,isFontWeight: true,)
            )
          ],
        ),
      );

  }
}

class GetOTPCodeSectionView extends StatefulWidget {
  String phoneNumber;
  bool isEnabledVerify;
  GetOTPCodeSectionView({required this.phoneNumber, required this.isEnabledVerify});

  @override
  State<GetOTPCodeSectionView> createState() => _GetOTPCodeSectionViewState();
}

class _GetOTPCodeSectionViewState extends State<GetOTPCodeSectionView> {

  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  String _phoneNumber = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = new TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _phoneNumber = widget.phoneNumber;
    _getSignatureCode();
    // _startListeningSms();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  /// listen sms
  _startListeningSms()  {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;

        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  _onSubmitOtp(String otpCode) {
    setState(() {
      // _isLoadingButton = !_isLoadingButton;
      // print("object===>${widget.phoneNumber}");
      // if(widget.phoneNumber.isNotEmpty && widget.phoneNumber.length == 11){
      //   _verifyOtpCode(otpCode);
        print("objectLength===>${widget.phoneNumber}");
      _navigateToSignUpDataScreen(context, widget.phoneNumber, otpCode);

      // }else{
      //   print("object===>NNN");
      // }
      // _verifyOtpCode(phoneNumber, otpCode);
    });
  }

  _onClickRetry() {
    _startListeningSms();
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (widget.phoneNumber.isNotEmpty && otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        widget.isEnabledVerify = false;
        _isLoadingButton = true;
        _verifyOtpCode(otpCode);
      } else if (widget.phoneNumber.isNotEmpty && otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        widget.isEnabledVerify = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
        widget.isEnabledVerify = false;
      }
    });
  }

  _verifyOtpCode(String otpCode) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
        widget.isEnabledVerify = false;

      });
      debugPrint("OTPCODE=>${otpCode}");
        _navigateToSignUpDataScreen(context, widget.phoneNumber, otpCode);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFieldPin(
                    textController: textEditingController,
                    autoFocus: false,
                    codeLength: _otpCodeLength,
                    alignment: MainAxisAlignment.center,
                    defaultBoxSize: 46.0,
                    margin: 10,
                    selectedBoxSize: 46.0,
                    textStyle: TextStyle(fontSize: 16),
                    defaultDecoration: _pinPutDecoration.copyWith(
                        border: Border.all(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.6))),
                    selectedDecoration: _pinPutDecoration,
                    onChange: (code) {
                      // _onOtpCallBack(code,false);
                      // setState(() {
                      //   if(code.length == _otpCodeLength){
                      //     _enableButton = false;
                      //   }
                      // });
                      setState(() {
                        _otpCode = code;
                        if (widget.phoneNumber.isNotEmpty && code.length == _otpCodeLength && true) {
                          _enableButton = false;
                          widget.isEnabledVerify = false;
                          // _isLoadingButton = true;
                        } else if (widget.phoneNumber.isNotEmpty && code.length == _otpCodeLength && !false) {
                          _enableButton = true;
                          widget.isEnabledVerify = true;
                          // _isLoadingButton = false;
                        } else {
                          _enableButton = false;
                          widget.isEnabledVerify = false;
                        }
                      });
                    }),


                Consumer<OTPCodeBloc>(
                  builder: (context, bloc, child) =>
                      DontGetOtpResendCodeSectionView(
                        onTapResendOTP: (){
                          debugPrint("TestErrorOTP=>${bloc.isResendCode}");
                          bloc.onTapGetOTP();
                    // _onClickRetry();
                          (bloc.isResendCode)
                              ?
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("OTPCode ==> ${bloc.otpCode}"))
                          )
                              :

                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Please First Request OTP Code Using Number!"))
                          );
                        },

                      ),
                ),

                SizedBox(height: MARGIN_XXLARGE,),

                SizedBox(
                  height: 45,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: widget.isEnabledVerify
                        ?
                        PRIMARY_COLOR
                        :
                        Colors.grey,

                        textStyle: const TextStyle(fontSize: TEXT_REGULAR)
                    ),
                    onPressed: widget.isEnabledVerify
                      ? () {
                      _navigateToSignUpDataScreen(context, widget.phoneNumber, _otpCode);
                      debugPrint("PhoneNumber=>${widget.phoneNumber+","+_otpCode}");
                    }
                    : null,
                    child: const Text('Verify'),
                  ),
                ),
                // Container(
                //   width: 120,
                //   height: 50,
                //   child: Material(  //Wrap with Material
                //     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8.0) ),
                //     elevation: 1.0,
                //     color: PRIMARY_COLOR,
                //     clipBehavior: Clip.antiAlias, // Add This
                //     child: MaterialButton(
                //       minWidth: 200.0,
                //       height: 35,
                //       color: PRIMARY_COLOR,
                //       disabledColor: Colors.grey,
                //       child:
                //       // _setUpButtonChild(),
                //
                //       new Text('Verify',
                //           style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                //       onPressed: widget.isEnabledVerify
                //      ?
                //       _onSubmitOtp(_otpCode)
                //       // _navigateToSignUpDataScreen(context, widget.phoneNumber, _otpCode)
                //           : null,
                //     ),
                //   ),
                // ),

              ],
            ),
          ),
        ),
    );
  }

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        "Verify",
        style: TextStyle(color: Colors.white),
      );
    }
  }

  Future<dynamic> _navigateToSignUpDataScreen(BuildContext context, String phoneNumber, String otpCode) {
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => SignUpDataViewPage(phoneNumber: phoneNumber, otpCode: otpCode,)
    )
    );
  }

}



