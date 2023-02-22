import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wechat/pages/first_wechat_view_page.dart';
import 'package:wechat/pages/wechat_home_navigation_view_page.dart';
import 'package:wechat/models/authentication_model_impl.dart';

import 'fcm/fcm_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FCMService().listenForMessages();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final _authenticationModel = AuthenticationModelImpl();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        primarySwatch: Colors.blueGrey,
      ),
      home: (_authenticationModel.isLoggedIn())
        ?
      WeChatHomeNavigationViewPage()
          :
      FirstWeChatViewPage()
    );
  }
}

