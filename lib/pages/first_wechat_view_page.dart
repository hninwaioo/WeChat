import 'package:flutter/material.dart';
import 'package:wechat/pages/welcome_to_login_view_page.dart';
import 'package:wechat/resources/colors.dart';
import 'package:wechat/resources/dimens.dart';
import 'package:wechat/resources/strings.dart';
import 'package:wechat/widgets/button_color_border_background.dart';
import 'package:wechat/widgets/button_color_full_background.dart';
import 'package:wechat/widgets/typical_text.dart';

import 'verify_phone_number_and_get_otp_view_page.dart';

class FirstWeChatViewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
                child: Image.asset("assets/images/wechat_logo.png")
            ),
          ),

          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                child: SignUpAndLoginSectionView(
                  onTapSignUp: (){
                    debugPrint("Sign UP");
                    _navigateToGetOTPScreen(context);
                  },
                  onTapLogin: (){
                    debugPrint("Login");
                    _navigateToLoginScreen(context);
                  },
                )

            ),
    ]
          )
        ],
      ),
    );
  }

  Future<dynamic> _navigateToLoginScreen(BuildContext context) {
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => WelcomeToLoginViewPage()
    )
    );
  }

  Future<dynamic> _navigateToGetOTPScreen(BuildContext context) {
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => VerifyPhoneNumberAndGetOTPViewPage()
    )
    );
  }
}

class SignUpAndLoginSectionView extends StatelessWidget {

  Function onTapSignUp;
  Function onTapLogin;
  SignUpAndLoginSectionView({required this.onTapSignUp, required this.onTapLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_LARGE, vertical: MARGIN_XXLARGE),
      child: Column(
        children: [
          TypicalText(TEXT_YOUR_FRIENDS_AND_SHARE_MOMENTS,PRIMARY_COLOR,TEXT_REGULAR_2x,isFontWeight: true),
          SizedBox(height: MARGIN_MEDIUM,),
          TypicalText(MESSAGING_WITH_SOCIAL_ELEMENTS,PRIMARY_COLOR,TEXT_REGULAR_SMALL,isFontWeight: false,isCenterText: true,),
          SizedBox(height: MARGIN_MEDIUM_2,),

          Row(
            children: [
              GestureDetector(
                onTap: (){
                  onTapSignUp();
                },
                  child: ButtonColorBorderBackground(btnText: SIGN_UP,marginValue: MARGIN_MEDIUM_LARGE,)
              ),
              Spacer(),

              GestureDetector(
                onTap: (){
                  onTapLogin();
                },
                  child: ButtonColorFullBackground(btnText: LOGIN,marginValue: MARGIN_XLARGE,)
              )
            ],
          )
        ],
      ),
    );
  }
}



