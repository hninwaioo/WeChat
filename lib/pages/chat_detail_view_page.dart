import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wechat/data/vos/chat/chat_message_vo.dart';
import 'package:wechat/resources/colors.dart';
import 'package:wechat/resources/dimens.dart';

class ChatDetailViewPage extends StatefulWidget {

  @override
  _ChatDetailViewPageState createState() => _ChatDetailViewPageState();
}

class _ChatDetailViewPageState extends State<ChatDetailViewPage> {
  List<ChatMessageVO> messages = [
    ChatMessageVO(messageContent: "Hello, Will", messageType: "receiver", timeStamp: DateTime.now().toString()),
    ChatMessageVO(
        messageContent: "How have you?", messageType: "receiver",timeStamp: DateTime.now().toString()),
    ChatMessageVO(
        messageContent: "Hey Kitty, I am fine. And you?",
        messageType: "sender",timeStamp: DateTime.now().toString()),
    ChatMessageVO(messageContent: "Yeah, I'm OK.", messageType: "receiver",timeStamp: DateTime.now().toString()),
    ChatMessageVO(
        messageContent: "God bless you", messageType: "sender",timeStamp: DateTime.now().toString()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Kitty",
                        style: TextStyle(
                            color: PRIMARY_COLOR,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_horiz_rounded,
                  color: PRIMARY_COLOR,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
          children:[
            Positioned.fill(
              child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType == "receiver"
                            ? Colors.grey.shade200
                            : Colors.blue[200]),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        messages[index].messageContent??"",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
          ),
            ),

            Positioned(
              bottom: 0.0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: ChatTextAndImageSectionView(),
              ),
            ),
          ]
        ),
    );
  }
}

class ChatTextAndImageSectionView extends StatelessWidget {
  const ChatTextAndImageSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2,vertical: MARGIN_MEDIUM),
              width: 190,
              child: TextFormField(

                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                ),
                onSaved: (String? value) {
                  // bloc.onEmailChanged(value ?? "");
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                // validator: (String? value) {
                //   return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                // },
              ),
            ),
            Spacer(),
            Container(
                margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2,vertical: MARGIN_MEDIUM),
                child: SvgPicture.asset("assets/images/chat_text_message_icon.svg"))
          ],
        ),
        Card(
          elevation: 1,
          child: Row(
            children: [
              SvgPicture.asset("assets/images/chat_image_icon.svg"),
              Spacer(),
              SvgPicture.asset("assets/images/chat_camera_icon.svg"),
              Spacer(),
              SvgPicture.asset("assets/images/chat_gif_file_icon.svg"),
              Spacer(),
              SvgPicture.asset("assets/images/chat_location_icon.svg"),
              Spacer(),
              SvgPicture.asset("assets/images/chat_voice_message_icon.svg"),

            ],
          ),
        )
      ],
    );
  }
}

