import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wechat/widgets/typical_text.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class WelcomeAndHiImageView extends StatelessWidget {
  String image_one;
  String image_two;
  String textState;
  WelcomeAndHiImageView({required this.image_one, required this.image_two, required this.textState});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SvgPicture.asset(image_one),
        SizedBox(height: MARGIN_SMALL,),

        TypicalText(textState, PRIMARY_COLOR, TEXT_REGULAR),
        SizedBox(height: MARGIN_MEDIUM_2,),

        Center(child: SvgPicture.asset(image_two)),
      ],
    );
  }
}
