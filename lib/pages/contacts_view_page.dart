import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wechat/bloc/profile_bloc.dart';
import 'package:wechat/data/vos/chat/chat_group_vo.dart';
import 'package:wechat/data/vos/chat/contact_vo.dart';
import 'package:wechat/data/vos/user_vo.dart';
import 'package:wechat/widgets/typical_text.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../widgets/qr_view_action.dart';

class ContactsViewPage extends StatefulWidget {
  const ContactsViewPage({Key? key}) : super(key: key);

  @override
  State<ContactsViewPage> createState() => _ContactsViewPageState();
}

class _ContactsViewPageState extends State<ContactsViewPage> {

  List<ChatGroupVO> chatGroups = [
    ChatGroupVO(
        groupImage: "assets/images/chat_add_new_contact_icon.svg",
        groupName: "Add New",

    ),
    ChatGroupVO(
        groupImage: "assets/images/chat_group_one.svg",
        groupName: "Smiles",

    ),
    ChatGroupVO(
        groupImage: "assets/images/chat_group_two_icon.svg",
        groupName: "Hello",
    ),
  ];


  List<String> list = [
    'Makhaylay',
    'Aye Aye',
    'Hnin Wai',
    'Baby'
    'Kitty',
    'Chit Chit',
    'Mg Mg',
    'Ei San',
    'Thet Myat',
    'Di Di',
    'Frozen',
    'Gu Gu',
    'Hi',
    'Ionic',
    'Ju Ji',
    'Kyi Kyi',
    'Lovey',
    'Ni Mon',
    'Maw Maw',
    'Oo',
    'Popular',
    'quri',
    'Riri',
    'Su Su',
    'Uncle',
    'Vitamin',
    'Wi Wi',
    'Xo xo',
    'Yin Win'
  ];

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  int selectedIndex = 0;
  bool _seeAction = false;



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProfileBloc(),
      child: Selector<ProfileBloc,List<ContactVO>?>(
          selector: (context,bloc) => bloc.contactList,
          builder: (context, contactsList, child) =>
         Scaffold(

          backgroundColor: PRIMARY_BACKGROUND_COLOR,
          appBar: AppBar(
            backgroundColor: PRIMARY_APP_BAR_COLOR,
            leading: Center(
                child: TypicalText(
                  "Contacts",
                  PRIMARY_COLOR,
                  TEXT_HEADING_2x,
                  isFontWeight: true,
                )),
            leadingWidth: 100,
            actions: [
              Container(
                margin: EdgeInsets.only(right: MARGIN_MEDIUM_2),
                child: GestureDetector(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const QRViewExample(),
                    ));

                  },
                  child: SvgPicture.asset("assets/images/chat_add_new_contact_icon.svg"),
                ),
              )

              // Container(
              //   margin: const EdgeInsets.all(8),
              //   child: ElevatedButton(
              //       onPressed: () async {
              //         Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => const QRViewExample(),
              //         ));
              //       },
              //       child: FutureBuilder(
              //         future: controller?.getFlashStatus(),
              //         builder: (context, snapshot) {
              //           return Text('Flash: ${snapshot.data}');
              //         },
              //       )),
              // ),

            ],
          ),

          body: Column(
            children: [
              // Container(
              //     height: 70,
              //     margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              //     child: ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: chatGroups.length,
              //         scrollDirection: Axis.horizontal,
              //         // physics: NeverScrollableScrollPhysics(),
              //         itemBuilder: (BuildContext context, int index) {
              //           return ChatGroupSectionView(
              //             groupImage: chatGroups[index].groupImage??"",
              //             groupName: chatGroups[index].groupName??"",
              //
              //           );
              //         }
              //     )
              // ),

              Container(
                width: double.infinity,
                // color: Color.fromRGBO(198,207,214,0.1),
                margin: EdgeInsets.symmetric(vertical: MARGIN_MEDIUM,horizontal: MARGIN_MEDIUM_2),
                decoration: BoxDecoration(
                  color:
                  Color.fromRGBO(147,151,220,0.1),
                  borderRadius: BorderRadius.circular(MARGIN_SMALL)
                ),
                child: Row(
                  children: [
                    Icon(Icons.search,color: PRIMARY_COLOR,),

                    SizedBox(width: MARGIN_MEDIUM,),
                    Container(
                      width: MediaQuery.of(context).size.width/1.5,
                      child: TextField(
                        controller: _textController,
                        onSubmitted: (text) {
                          setState(() {
                            _seeAction = true;

                            debugPrint(_textController.text);

                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // filled: true,
                            // fillColor: Color.fromRGBO(147,150,220,0.1),
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: TEXT_REGULAR)),
                      ),
                    ),

                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          TextEditingController().clear();
                          _seeAction = false;
                          _textController.clear();
                        });
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
                          child: Icon(
                            Icons.close,
                            color: PRIMARY_HINT_COLOR,
                          )

                      ),
                    ),
                    // Visibility(
                    //   visible: _seeAction,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       setState(() {
                    //         TextEditingController().clear();
                    //         _seeAction = false;
                    //         _textController.clear();
                    //       });
                    //     },
                    //     child: Padding(
                    //         padding: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
                    //         child: Icon(
                    //           Icons.close,
                    //           color: PRIMARY_HINT_COLOR,
                    //         )
                    //
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),


              Container(
                margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChatGroupSectionView(
                      groupImage: "assets/images/chat_create_group.png",
                      groupName: "Add User",
                      isColorBg: PRIMARY_COLOR,
                      isColorText: Colors.white,
                      imageHeight: 35,
                      imageWidth: 30,
                    ),
                    ChatGroupSectionView(
                      groupImage: "assets/images/chat_group_one.png",
                      groupName: "Smiles",
                      isColorBg: Colors.white,
                      isColorText: PRIMARY_COLOR,
                      imageHeight: 50,
                      imageWidth: 45,
                    ),
                    ChatGroupSectionView(
                      groupImage: "assets/images/chat_group_two.png",
                      groupName: "Hello",
                      isColorBg: Colors.white,
                      isColorText: PRIMARY_COLOR,
                      imageHeight: 50,
                      imageWidth: 45,
                    )
                  ],
                ),
              ),

              Expanded(
                child: AlphabetScrollView(
                  // list: contactsList!.map((e) => AlphaModel(e.userName??"")).toList(),
                  list: list.map((e) => AlphaModel(e)).toList(),
                  // isAlphabetsFiltered: false,
                  alignment: LetterAlignment.right,
                  itemExtent: 50,
                  unselectedTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black
                  ),
                  selectedTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                  ),
                  overlayWidget: (value) => Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 50,
                        color: Colors.red,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$value'.toUpperCase(),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  itemBuilder: (_, k, id) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child:

                      ListTile(
                        title: Text('$id'),
                        // subtitle: Text('Secondary text'),
                        leading: Container(
                          margin: EdgeInsets.symmetric(vertical: MARGIN_SMALL),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg"),
                            maxRadius: 30,
                          ),
                        ),)
                      //   // trailing: Radio<bool>(
                      //   //   value: false,
                      //   //   groupValue: selectedIndex != k,
                      //   //   onChanged: (value) {
                      //   //     setState(() {
                      //   //       selectedIndex = k;
                      //   //     });
                      //   //   },
                      //   // ),
                      // ),

                      // (contactsList != null)?
                      // ListView.separated(
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemCount: contactsList.length,
                      //   separatorBuilder: (_, __) => const Divider(),
                      //   itemBuilder: (context, int index) {
                      //     return
                      //     // Container(
                      //     //   height: 40,
                      //     //   margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2,vertical: MARGIN_SMALL),
                      //     //   child: Row(
                      //     //     children: [
                      //     //       CircleAvatar(
                      //     //         backgroundImage: NetworkImage("https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg"),
                      //     //         maxRadius: 25,
                      //     //       ),
                      //     //       SizedBox(width: MARGIN_MEDIUM,),
                      //     //       TypicalText(contactsList[index].userName??"", PRIMARY_COLOR, TEXT_REGULAR)
                      //     //     ],
                      //     //   ),
                      //     // );
                      //       TypicalText(contactsList[index].userName??"", PRIMARY_COLOR, TEXT_REGULAR);
                      //
                      //   },
                      // )
                      //     :
                      //     Container(
                      //       height: 90,
                      //       color: Colors.blue,
                      //     )
                    );
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class ChatGroupSectionView extends StatelessWidget {
  String groupImage;
  String groupName;
  Color isColorBg;
  Color isColorText;
  double imageHeight;
  double imageWidth;
  ChatGroupSectionView({
    required this.groupImage,
    required this.groupName,
    required this.isColorBg,
    required this.isColorText,
    required this.imageHeight,
    required this.imageWidth
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_SMALL,),
      height: 90,
      width: 80,
      decoration: BoxDecoration(
        color: isColorBg,
        // isGroupCreate == false ? Colors.white : PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_SMALL)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(groupImage,height: imageHeight,width: imageWidth,fit: BoxFit.cover,),
          // SvgPicture.asset("assets/images/chat_create_new_contact_icon.svg"),
          SizedBox(height: MARGIN_SMALL,),
          TypicalText(
              groupName,
              isColorText,
              // isGroupCreate == false ? PRIMARY_COLOR :  Colors.white,
              TEXT_REGULAR)
        ],
      ),
    );
  }
}


