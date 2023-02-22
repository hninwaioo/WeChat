import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/vos/news_feed_vo.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../widgets/typical_text.dart';

class NewsFeedItemView extends StatelessWidget {
  NewsFeedVO? newsFeedVO;
  final Function(int) onTapDelete;
  final Function(int) onTapEdit;
  NewsFeedItemView({required this.newsFeedVO, required this.onTapDelete, required this.onTapEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2,vertical: MARGIN_MEDIUM_2),
          child: Row(
            children: [
              ProfileImageView(
                  profileImage:
                  // "https://w0.peakpx.com/wallpaper/224/824/HD-wallpaper-beauty-red-model-rose-girl-hand-flower-face-woman.jpg"
                  newsFeedVO?.profilePicture

              ),
              SizedBox(width: MARGIN_MEDIUM_2,),
              NameLocationAndTimeAgoView(
                  userName:
                  // "Hnin Wai"
              newsFeedVO?.userName,
              ),
              Spacer(),
              // Icon(Icons.more_horiz_rounded, size: MARGIN_MEDIUM_LARGE,color: PRIMARY_COLOR,)
              MoreButtonView(
                onTapDelete: (){
                  onTapDelete(newsFeedVO?.id ??0 );
                },
                onTapEdit: (){
                  onTapEdit(newsFeedVO?.id ??0 );
                },
              )            ],
          ),
        ),

        SizedBox(height: MARGIN_MEDIUM_2,),

        Container(
          margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: PostImageAndDescriptionView(
            postImageList: newsFeedVO?.postImage??[],
            // "https://cf.ltkcdn.net/life-with-pets/find-your-pet/images/std-xs/321177-340x227-cat-love.jpg",
            // newsFeedVO?.postImage,
            postDescription:
            // "Cats have very soft coats of fur, which makes them look like soft rugs, and once you pet them, you don't want to stop because they are so soft. My pet cat loves to play with my family and me. My pet cat is the most attached to the person who gives him or her treats. All my friends and relatives also love my pet cat "
            newsFeedVO?.description,
          ),
        ),

        SizedBox(height: MARGIN_MEDIUM_2,),
        SeeCommentAndLikeView(),
        SizedBox(height: MARGIN_MEDIUM_LARGE,),

      ],
    );
  }
}

class ProfileImageView extends StatelessWidget {

  String? profileImage;
  ProfileImageView({required this.profileImage});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      child: CircleAvatar(
        backgroundImage: NetworkImage(profileImage??""),
        radius: 100,
      ),
    );
  }
}

class NameLocationAndTimeAgoView extends StatelessWidget {
  String? userName;
  NameLocationAndTimeAgoView({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   children: [
          //     TypicalText(userName ?? "", Colors.black, TEXT_REGULAR_1X,isFontWeight: true,),
          //     TypicalText("  -  ", PRIMARY_HINT_COLOR, TEXT_REGULAR),
          //     TypicalText("1 hours", PRIMARY_HINT_COLOR, TEXT_REGULAR_SMALL)
          //   ],
          // ),
          TypicalText(userName ?? "", Colors.black, TEXT_REGULAR_1X,isFontWeight: true,),

          TypicalText("15 min", PRIMARY_HINT_COLOR, TEXT_REGULAR_SMALL)
        ],
      ),
    );
  }
}

class PostImageAndDescriptionView extends StatelessWidget {
  List<String>? postImageList;
  String? postDescription;
  PostImageAndDescriptionView({required this.postImageList, required this.postDescription});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          child: (postImageList!.isNotEmpty)
              ?
          ImageListSectionView(postImageList: postImageList)
              :
          null,
        ),


        SizedBox(height: MARGIN_MEDIUM_2,),

        TypicalText(postDescription??"", Colors.black, TEXT_REGULAR)

      ],
    );
  }
}

class ImageListSectionView extends StatelessWidget {
  List<String>? postImageList;
  ImageListSectionView({
    required this.postImageList,
  });

  @override
  Widget build(BuildContext context) {
    return

      // ListView.builder(
      //   itemCount: 1,
      //   // mainListVO?.books?.length,
      //   physics: NeverScrollableScrollPhysics(),
      //   shrinkWrap: true,
      //   itemBuilder: (BuildContext context, int index) {
      //     return
      //     //   BooksListHorizontalSectionView(
      //     //   booksList: mainListVO?.books??[],
      //     // );
      //       ClipRRect(
      //         borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
      //         child:  Image.network(
      //           postImageList?[index]??"",
      //           fit:BoxFit.cover,
      //           height: 180,
      //           width: double.infinity,
      //         )
      //     );
      //   });

    //   ClipRRect(
    //     borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
    //     child:  Image.network(
    //       postImage??"",
    //       fit:BoxFit.cover,
    //       height: 180,
    //       width: double.infinity,
    //     )
    // );



      Container(
        child: (postImageList!=null)
            ?
        GridView.builder(

          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.65,
            crossAxisCount: 2,
            // postImageList?.length??,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
          ),
          itemCount: postImageList?.length,
          itemBuilder: (BuildContext context, int index) {
            return
              ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),

                child:  Image.network(
                  postImageList?[index]??"",
                  fit:BoxFit.cover,
                  height: 180,
                  width: double.infinity,
                )
            );
          },
        )
            :
            null
      );
  }
}

class SeeCommentAndLikeView extends StatelessWidget {
  const SeeCommentAndLikeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        children: [
          Row(
            children: [
              Icon(Icons.favorite_outline,color: PRIMARY_COLOR,),
              TypicalText("4", PRIMARY_COLOR, TEXT_REGULAR),
            ],
          ),
          Spacer(),
          Row(
            children: [
              SvgPicture.asset("assets/images/comment_icon.svg",width: 20,height: 25),
              // SizedBox(width: MARGIN_SMALL,),
              TypicalText("3", PRIMARY_COLOR, TEXT_REGULAR),
            ],
          ),
          SizedBox(width: MARGIN_MEDIUM),
          SvgPicture.asset("assets/images/save_moment.svg",width: 16,height: 20,)
        ],
      ),
    );
  }
}

class MoreButtonView extends StatelessWidget {
  final Function onTapDelete;
  final Function onTapEdit;

  MoreButtonView({
    required this.onTapDelete,
    required this.onTapEdit
  });

  @override
  Widget build(BuildContext context) {
    return
      PopupMenuButton(
        icon: Icon(Icons.more_horiz_rounded, color: PRIMARY_HINT_COLOR,),
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: (){
              onTapEdit();
            },
            child: Text("Edit"),
            value: 1,
          ),
          PopupMenuItem(
            onTap: (){
              onTapDelete();
            },
            child: Text("Delete"),
            value: 1,
          ),
        ],
      );
  }
}
