import 'package:flutter/material.dart';
import 'package:wechat/resources/colors.dart';
import 'package:wechat/resources/dimens.dart';
import 'package:wechat/widgets/typical_text.dart';

class ButtonColorFullBackground extends StatelessWidget {

  String btnText;
  double marginValue;
  ButtonColorFullBackground({required this.btnText,required this.marginValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: marginValue,vertical: MARGIN_CARD_MEDIUM_2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_SMALL),
        color: PRIMARY_COLOR
      ),
      child: TypicalText(btnText,Colors.white,TEXT_REGULAR_1X,isFontWeight: true,),
    );
  }
}
