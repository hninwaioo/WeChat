import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wechat/resources/colors.dart';
import 'package:wechat/resources/dimens.dart';
import 'package:wechat/widgets/typical_text.dart';

class ActiveNowAccountItemView extends StatelessWidget {
  const ActiveNowAccountItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountImageAndActiveNowView(),

        SizedBox(height: MARGIN_SMALL,),
        Container(
          width: 65,
          alignment: Alignment.bottomCenter,
          child: TypicalText("Hnin Wai", HINT_TEXT_COLOR,TEXT_REGULAR,isCenterText: true,),
        )
      ],
    );
  }
}

class AccountImageAndActiveNowView extends StatelessWidget {
  const AccountImageAndActiveNowView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 45,
          height: 45,
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg"),
            radius: 100,
          ),
        ),
        Positioned(
          bottom: 0.0,
            right: 0.0,
            child: SvgPicture.asset("assets/images/active_now_icon.svg")
        ),
      ],
    );
  }
}



