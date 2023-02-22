import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wechat/pages/create_moment_to_post_view_page.dart';
import 'package:wechat/resources/colors.dart';
import 'package:wechat/resources/dimens.dart';
import 'package:wechat/widgets/typical_text.dart';
import '../bloc/news_feed_bloc.dart';
import '../data/vos/news_feed_vo.dart';
import '../viewitems/news_feed_item_view.dart';

class NewsfeedForMomentsViewPage extends StatefulWidget {
  const NewsfeedForMomentsViewPage({Key? key}) : super(key: key);

  @override
  State<NewsfeedForMomentsViewPage> createState() => _NewsfeedForMomentsViewPageState();
}

class _NewsfeedForMomentsViewPageState extends State<NewsfeedForMomentsViewPage> {

  List<NewsFeedVO>? newsFeedList = [];

  NewsFeedVO newsFeedVO = NewsFeedVO(
      id: 15786,
      description : "Pink roses represent innocent romantic love, and make a good choice for teen romance or the early phases of a romantic relationship. Pink roses represent a beautiful, fresh love and a pureness of emotion",
      profilePicture : "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg",
      userName: "Hnin Wai",
      postImage: [
        "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg",
        "https://www.shutterstock.com/image-photo/woman-long-red-dress-back-260nw-1790638613.jpg",
        "https://www.shutterstock.com/image-photo/woman-long-red-dress-back-260nw-1790638613.jpg"
      ],
      postDate: "15 min"
  );

  @override
  void initState(){
    super.initState();
    newsFeedList?.add(newsFeedVO);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsFeedBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_BACKGROUND_COLOR,
          leading: Center(
              child: TypicalText("Moment", PRIMARY_COLOR, TEXT_HEADING_2x,isFontWeight: true,)
          ),
          leadingWidth: 100,

          actions: [
            GestureDetector(
              onTap: (){
                _navigateToCreateMomentScreen(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: SvgPicture.asset("assets/images/add_moment.svg")
              ),
            )
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Selector<NewsFeedBloc,List<NewsFeedVO>?>(
                selector: (context,bloc) => bloc.newsFeed,
                builder: (context, newsFeedList, child) =>
                    // Center(child: TypicalText("text", Colors.black, 16))
                    // ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount:
                    //     newsFeedList?.length,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return NewsFeedItemView(
                    //         newsFeedVO: newsFeedList?[index],
                    //       );
                    //     }),

                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: newsFeedList?.length??0,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, int index) {
                    return
                      NewsFeedItemView(
                                newsFeedVO: newsFeedList?[index],
                        onTapDelete: (newsFeedId){
                          var bloc = Provider.of<NewsFeedBloc>(context,listen: false);
                          bloc.onTapDeletePost(newsFeedId);
                        },
                        onTapEdit: (newsFeedId){
                          Future.delayed(const Duration(milliseconds: 1000))
                              .then((value){
                            _navigateToEditMomentScreen(context,newsFeedId);
                          });
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
              )
            ],
          ),
        ),

      ),
    );
  }

  Future<dynamic> _navigateToEditMomentScreen(BuildContext context, int newsfeedId) {
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => CreateMomentToPostViewPage(
            newsfeedId: newsfeedId
        )
    )
    );
  }

  Future<dynamic> _navigateToCreateMomentScreen(BuildContext context) {
    return Navigator.push(context, MaterialPageRoute(
        builder: (context) => CreateMomentToPostViewPage()
    )
    );
  }
}
