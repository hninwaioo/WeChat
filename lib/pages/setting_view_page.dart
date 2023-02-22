import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/pages/welcome_to_login_view_page.dart';
import '../bloc/login_bloc.dart';
import '../resources/dimens.dart';
import '../widgets/button_color_full_background.dart';

class SettingViewPage extends StatefulWidget {
  const SettingViewPage({Key? key}) : super(key: key);

  @override
  State<SettingViewPage> createState() => _SettingViewPageState();
}

class _SettingViewPageState extends State<SettingViewPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginBloc(),
      child: Center(
          child:  Consumer<LoginBloc>(
            builder: (context, bloc, child) =>
                GestureDetector(
                  onTap: (){
                    bloc.onTapLogout().then((_){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=> WelcomeToLoginViewPage()),
                      );
                    });
                  },
                  child: ButtonColorFullBackground(
                    btnText: "LogOut",
                    marginValue: MARGIN_XLARGE,
                  ),
                ),
          )),
    );
  }
}
