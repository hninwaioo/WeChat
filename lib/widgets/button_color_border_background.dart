import 'package:flutter/material.dart';
import 'package:wechat/resources/colors.dart';
import 'package:wechat/widgets/typical_text.dart';
import '../resources/dimens.dart';

class ButtonColorBorderBackground extends StatelessWidget {
  String btnText;
  double marginValue;

  ButtonColorBorderBackground({required this.btnText, required this.marginValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: marginValue,vertical: MARGIN_CARD_MEDIUM_2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MARGIN_SMALL),
          border: Border.all(color: PRIMARY_COLOR, width: 1
          ),
      ),
      child: TypicalText(btnText, PRIMARY_COLOR, TEXT_REGULAR_1X,isFontWeight: true),
    );
  }
}
