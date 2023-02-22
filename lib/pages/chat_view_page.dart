import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wechat/pages/chat_detail_view_page.dart';

import '../data/vos/chat/chat_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../viewitems/active_now_account_item_view.dart';
import '../viewitems/chart_account_item_view.dart';
import '../widgets/typical_text.dart';

class ChatViewPage extends StatefulWidget {
  const ChatViewPage({Key? key}) : super(key: key);

  @override
  State<ChatViewPage> createState() => _ChatViewPageState();
}

class _ChatViewPageState extends State<ChatViewPage> {

  List<ChatVO> chatUsers = [
    ChatVO(
        name: "Hnin Wai",
        messageText: "Awesome Setup",
        imageURL:
            "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg",
        time: "Now"),
    ChatVO(
        name: "Aung Aung",
        messageText: "That's Great",
        imageURL:
            "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg",
        time: "Yesterday"),
    ChatVO(
        name: "Su Su",
        messageText: "Hey where are you?",
        imageURL:
            "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg",
        time: "31 Mar"),
    ChatVO(
        name: "MA MA",
        messageText: "Busy! Call me in 20 mins",
        imageURL:
            "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg",
        time: "28 Mar"),
    ChatVO(
        name: "Kitty",
        messageText: "Thank you, It's awesome",
        imageURL:
            "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg",
        time: "23 Mar"),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_APP_BAR_COLOR,
        leading: Center(
            child: TypicalText(
          "Chat",
          PRIMARY_COLOR,
          TEXT_HEADING_2x,
          isFontWeight: true,
        )),
        leadingWidth: 100,
        actions: [
          GestureDetector(
            onTap: () {
              // _navigateToCreateMomentScreen(context);
            },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: SvgPicture.asset("assets/images/search_icon.svg")),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM),
              child:
                  TypicalText("Active Now", HINT_TEXT_COLOR, TEXT_REGULAR_1X),
            ),
            Container(
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return ActiveNowAccountItemView(
                          // newsFeedVO: newsFeedList?[index],
                          );
                    }
                    )
            ),

            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name ?? "",
                  messageText: chatUsers[index].messageText ?? "",
                  imageUrl: chatUsers[index].imageURL ?? "",
                  time: chatUsers[index].time ?? "",
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                  onTapChatDetail: (id) {
                    debugPrint("Print");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ChatDetailViewPage();
                    }));
                  },
                );
              },
            ),
          ],
        ),
        //
      ),
    );
  }
}

class ViewAccount extends StatelessWidget {
  const ViewAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActiveNowAccountSectionView(),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        ChatAccountItemListSectionView()
      ],
    );
  }
}

class ActiveNowAccountSectionView extends StatelessWidget {
  const ActiveNowAccountSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_LARGE),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            // newsFeedList?.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Text("data");
              // ActiveNowAccountItemView(
              // newsFeedVO: newsFeedList?[index],
              // );
            }));

    // Container(
    //     height: 100,
    //     child: ListView.builder(
    //         scrollDirection: Axis.horizontal,
    //         padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
    //         itemCount: 7,
    //         // movieList.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return ActiveNowAccountItemView(
    //
    //               // movieList[index],
    //               );
    //         }));
  }
}

class ChatAccountItemListSectionView extends StatelessWidget {
  const ChatAccountItemListSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        // height: 190,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            itemCount: 7,
            // movieList.length,
            itemBuilder: (BuildContext context, int index) {
              return Text("data");
              //   ChatAccountItemView(
              //
              //   // movieList[index],
              // );
            }));
  }
}

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  Function(int) onTapChatDetail;
  ConversationList(
      {required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.time,
      required this.isMessageRead,
      required this.onTapChatDetail});

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: GestureDetector(
          onTap: () {
            // widget.onTapChatDetail;
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChatDetailViewPage();
            }));
          },
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.imageUrl),
                      maxRadius: 30,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.name,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              widget.messageText,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                  fontWeight: widget.isMessageRead
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.time,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: widget.isMessageRead
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
