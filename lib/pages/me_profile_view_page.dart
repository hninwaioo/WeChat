import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wechat/bloc/profile_bloc.dart';
import 'package:wechat/data/vos/news_feed_vo.dart';
import 'package:wechat/data/vos/user_vo.dart';
// import 'package:wechat/data/vos/user_vo.dart';
import 'package:wechat/resources/strings.dart';
import 'package:wechat/viewitems/news_feed_item_view.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../widgets/dialog_for_edit_account_view.dart';
import '../widgets/typical_text.dart';

class MeProfileViewPage extends StatefulWidget {
  const MeProfileViewPage({Key? key}) : super(key: key);

  @override
  State<MeProfileViewPage> createState() => _MeProfileViewPageState();
}

class _MeProfileViewPageState extends State<MeProfileViewPage> {
  List<NewsFeedVO>? newsFeedListSave = [];

  NewsFeedVO newsFeedVO = NewsFeedVO(
      id: 15786,
      description : "Pink roses represent innocent romantic love, and make a good choice for teen romance or the early phases of a romantic relationship. Pink roses represent a beautiful, fresh love and a pureness of emotion",
      profilePicture :
      "https://media.allure.com/photos/5a26c1d8753d0c2eea9df033/3:4/w_1262,h_1683,c_limit/mostbeautiful.jpg",
      // "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg",
      userName: "Hnin Wai",
      postImage: [
        "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg",
        "https://www.shutterstock.com/image-photo/woman-long-red-dress-back-260nw-1790638613.jpg",
        // "https://www.shutterstock.com/image-photo/woman-long-red-dress-back-260nw-1790638613.jpg"
      ],
      postDate: "15 min"
  );
  @override
  void initState(){
    super.initState();
    newsFeedListSave?.add(newsFeedVO);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProfileBloc(),
      child:  Selector<ProfileBloc,UserVO>(
          selector: (context,bloc) => bloc.loggedInUser!,
          builder: (context, newsFeedList, child) =>
         Scaffold(
          backgroundColor: PRIMARY_BACKGROUND_COLOR,
          appBar: AppBar(
            backgroundColor: PRIMARY_APP_BAR_COLOR,
            leading: Center(
                child: TypicalText("Me", PRIMARY_COLOR, TEXT_HEADING_2x,isFontWeight: true,)
            ),
            leadingWidth: 100,
            actions: [
              GestureDetector(
                onTap: (){
                  // _navigateToCreateMomentScreen(context);
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0)), //this right here
                                child: Container(
                                    height: 450,
                                    child: DialogForEditAccountView()
                                ),
                              );
                            });
                      },
                        child: SvgPicture.asset("assets/images/edit_icon.svg")
                    )
                ),
              )
            ],
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(MARGIN_MEDIUM_2),
                  padding: EdgeInsets.all(MARGIN_MEDIUM_2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
                    color: PRIMARY_COLOR
                  ),

                  child: Row(
                    children: [
                      ProfileImageScanAndChangeSectionView(),
                      SizedBox(width: MARGIN_MEDIUM_LARGE,),
                      AccountNameAndPhoneAndBirthAndGenderSectionView(),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: Text(
                    BOOKMARKED_MOMENTS,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: PRIMARY_COLOR,
                        fontSize: TEXT_REGULAR_1X
                    ),),
                ),

                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: newsFeedListSave?.length??0,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, int index) {
                    return
                      NewsFeedItemView(
                        newsFeedVO: newsFeedListSave?[index],
                        onTapDelete: (newsFeedId){
                          // var bloc = Provider.of<NewsFeedBloc>(context,listen: false);
                          // bloc.onTapDeletePost(newsFeedId);
                        },
                        onTapEdit: (newsFeedId){
                          // Future.delayed(const Duration(milliseconds: 1000))
                          //     .then((value){
                          //   _navigateToEditMomentScreen(context,newsFeedId);
                          // });
                        },
                      );
                    // NewsFeedItemView(
                    //   newsFeedVO: newsFeedList?[index],
                    //   onTapDelete: (newsFeedId){
                    //     var bloc = Provider.of<NewsFeedBloc>(context,listen: false);
                    //     bloc.onTapDeletePost(newsFeedId);
                    //   },
                    //   onTapEdit: (newsFeedId){
                    //     Future.delayed(const Duration(milliseconds: 1000))
                    //         .then((value){
                    //       _navigateToEditPostScreen(context,newsFeedId);
                    //     });
                    //   },
                    //
                    // );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileImageScanAndChangeSectionView extends StatefulWidget {
  const ProfileImageScanAndChangeSectionView({Key? key}) : super(key: key);

  @override
  State<ProfileImageScanAndChangeSectionView> createState() => _ProfileImageScanAndChangeSectionViewState();
}

class _ProfileImageScanAndChangeSectionViewState extends State<ProfileImageScanAndChangeSectionView> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileBloc>(
      builder: (context, bloc,child) =>
       Container(
        height: 100,
        width: 100,
        child: Stack(
          children: [
            Container(
              width: 90,
              height: 90,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://media.allure.com/photos/5a26c1d8753d0c2eea9df033/3:4/w_1262,h_1683,c_limit/mostbeautiful.jpg"),
                    // "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg"),
                radius: 100,
              ),
            ),

            Positioned(
                bottom: 3,
                left: 1,
                child: SvgPicture.asset("assets/images/upload_new_profile_photo_icon.svg")
            ),
            //
            Positioned(
                bottom: -1,
                right: -2,
                child: GestureDetector(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0)), //this right here
                            child:
                            Container(
                              height: 300,
                              child: Center(
                                child: QrImage(
                                      data: bloc.loggedInUser?.id??"",
                                      version: QrVersions.auto,
                                      size: 220,
                                      gapless: false,
                                    ),
                              ),
                            ),
                          );
                        });
                  },
                    child: Image.asset("assets/images/profile_qr_icon.png",width: 50,)
                )
            ),

          ],
        ),
      ),
    );
  }

}

class AccountNameAndPhoneAndBirthAndGenderSectionView extends StatelessWidget {
  const AccountNameAndPhoneAndBirthAndGenderSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Consumer<ProfileBloc>(
      builder: (context, bloc,child) =>
       Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TypicalText(bloc.loggedInUser?.userName??"", Colors.white, TEXT_REGULAR_1X,isFontWeight: true,),
          AccountDataSectionView(
              accountDataText: "09259102403",
              // bloc.phoneNumber,
              dataImage: "assets/images/profile_phone_icon.svg"
          ),
          AccountDataSectionView(
              accountDataText: "28/11/1998",
              // bloc.birthDate,
              dataImage: "assets/images/profile_date_icon.svg"
          ),
          AccountDataSectionView(
              accountDataText: "Female",
              // bloc.genderType,
              dataImage: "assets/images/profile_gender_icon.svg"
          ),
        ],
      ),
    );
  }
}

class AccountDataSectionView extends StatelessWidget {
  String accountDataText;
  String dataImage;
  AccountDataSectionView({required this.accountDataText, required this.dataImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MARGIN_MEDIUM),
      child: Row(
        children: [
          SvgPicture.asset(dataImage),
          SizedBox(width: MARGIN_SMALL,),
          TypicalText(accountDataText, Colors.white, TEXT_REGULAR)
        ],
      ),
    );
  }
}



