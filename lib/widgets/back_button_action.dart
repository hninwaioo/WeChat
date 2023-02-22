import 'package:flutter/material.dart';
import 'package:wechat/resources/colors.dart';
import 'package:wechat/resources/dimens.dart';

class BackButtonAction extends StatelessWidget {
  const BackButtonAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2,vertical: MARGIN_MEDIUM),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.keyboard_backspace_outlined, color: PRIMARY_COLOR,size: MARGIN_XLARGE,),
      ),
    );
  }
}
