import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/resources/colors.dart';
import 'package:wechat/resources/dimens.dart';
import 'package:wechat/resources/strings.dart';
import 'package:wechat/utils/extensions.dart';
import 'package:wechat/widgets/button_color_full_background.dart';
import 'package:wechat/widgets/typical_text.dart';
import '../bloc/login_bloc.dart';
import '../widgets/back_button_action.dart';
import '../widgets/loading_view.dart';
import '../widgets/welcome_and_hi_image_view.dart';
import 'newsfeed_for_moments_view_page.dart';

class WelcomeToLoginViewPage extends StatelessWidget {
  const WelcomeToLoginViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child:  Selector<LoginBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) =>
         Stack(
          children:[
            Scaffold(
            backgroundColor: PRIMARY_BACKGROUND_COLOR,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: PRIMARY_BACKGROUND_COLOR,
              leading: BackButtonAction(),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MARGIN_MEDIUM,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: WelcomeAndHiImageView(
                      image_one: "assets/images/welcome_icon.svg",
                      image_two: "assets/images/login_illustration.svg",
                      textState: LOGIN_TO_CONTINUE,
                    ),
                  ),
                  SizedBox(
                    height: MARGIN_MEDIUM,
                  ),
                  EnterPhoneNumberAndPasswordSectionView(),
                  SizedBox(
                    height: MARGIN_MEDIUM_2,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_LARGE),
                        child: TypicalText(
                          FORGOT_PASSWORD,
                          PRIMARY_COLOR,
                          TEXT_REGULAR_1X,
                          isFontWeight: true,
                        )),
                  ),
                  SizedBox(
                    height: MARGIN_XXLARGE,
                  ),
                  Center(
                      child:  Consumer<LoginBloc>(
                        builder: (context, bloc, child) =>
                         GestureDetector(
                           onTap: (){
                             bloc.onTapLogin()
                                 .then((_){
                               navigateToScreen(
                                   context, const NewsfeedForMomentsViewPage());
                               // Navigator.pop(context);

                             }).catchError((error) => showSnackBarWithMessage(
                                 context, error.toString()
                             ));
                           },
                           child: ButtonColorFullBackground(
                             btnText: LOGIN,
                             marginValue: MARGIN_XLARGE,
                           ),
                         ),
                      )),
                  SizedBox(
                    height: MARGIN_XXLARGE,
                  )
                ],
              ),
            ),
          ),

            Visibility(
                visible: isLoading,
                child: Container(
                    color: Colors.black12,
                    child: Center(
                      child: LoadingView(),
                    )
                )
            )
          ]
        ),
      ),
    );
  }
}

class EnterPhoneNumberAndPasswordSectionView extends StatefulWidget {
  const EnterPhoneNumberAndPasswordSectionView({Key? key}) : super(key: key);

  @override
  State<EnterPhoneNumberAndPasswordSectionView> createState() =>
      _EnterPhoneNumberAndPasswordSectionViewState();
}

class _EnterPhoneNumberAndPasswordSectionViewState
    extends State<EnterPhoneNumberAndPasswordSectionView> {
  TextEditingController phoneNumberInput = TextEditingController();
  String textPhoneNumber = "";
  TextEditingController passwordInput = TextEditingController();
  String textPassword = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_LARGE),
      child: Column(
        children: [
          Container(
            child: Consumer<LoginBloc>(
              builder: (context, bloc, child) =>
                  TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      // controller: TextEditingController(
                      //     text: '',
                      // ),

                      onChanged: (text) {
                        bloc.onPhoneNumberChanged(text);
                      },
                      decoration: InputDecoration(
                        hintText: ENTER_YOUR_PHONE_NUMBER,
                        labelText: ENTER_YOUR_PHONE_NUMBER,
                      ))
            ),
          ),
          Container(
            child: Consumer<LoginBloc>(
              builder: (context, bloc, child) =>
                  TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      // controller: TextEditingController(
                      //     text: '',
                      // ),

                      onChanged: (text) {
                        bloc.onEmailChanged(text);
                      },
                      decoration: InputDecoration(
                        hintText: ENTER_YOUR_EMAIL,
                        labelText: ENTER_YOUR_EMAIL,
                      ))
            ),
          ),
          Container(
              child: Consumer<LoginBloc>(
            builder: (context, bloc, child) =>
                TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    // controller: TextEditingController(
                    //     text: '',
                    // ),

                    onChanged: (text) {
                      bloc.onPasswordChanged(text);
                    },
                    decoration: InputDecoration(
                      hintText: ENTER_YOUR_PASSWORD,
                      labelText: ENTER_YOUR_PASSWORD,
                    ))
              )),
        ],
      ),
    );
  }
}
