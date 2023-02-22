import 'package:flutter/material.dart';
import 'package:wechat/resources/colors.dart';
import 'package:wechat/resources/dimens.dart';
import 'package:wechat/viewitems/active_now_account_item_view.dart';
import 'package:wechat/widgets/typical_text.dart';

class ChatAccountItemView extends StatelessWidget {
  const ChatAccountItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          // AccountImageAndActiveNowView(),
          // SizedBox(width: MARGIN_MEDIUM,),
          // AccountNameAndMessageSectionView(),
          // Spacer(),
          Column(
            children: [
              TypicalText("15 min", Colors.blue, TEXT_REGULAR),
              Spacer(),
              Icon(Icons.check_rounded,color: Colors.green,)
            ],
          )

        ],
      ),
    );
  }
}

class AccountNameAndMessageSectionView extends StatelessWidget {
  const AccountNameAndMessageSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TypicalText("Hnin Wai Oo",Colors.black,TEXT_REGULAR_1X,isFontWeight: true),
          SizedBox(height: MARGIN_MEDIUM,),
          TypicalText("You sent a video", HINT_TEXT_COLOR, TEXT_REGULAR)

        ],
      ),
    );
  }
}

