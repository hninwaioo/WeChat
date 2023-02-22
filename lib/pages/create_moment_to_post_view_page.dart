import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/resources/colors.dart';
import 'package:wechat/resources/dimens.dart';
import 'package:wechat/widgets/button_color_full_background.dart';
import 'package:wechat/widgets/typical_text.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../bloc/add_new_post_bloc.dart';
import '../viewitems/news_feed_item_view.dart';
import '../widgets/loading_view.dart';

class CreateMomentToPostViewPage extends StatefulWidget {
  final int? newsfeedId;

  const CreateMomentToPostViewPage({Key? key, this.newsfeedId})
      : super(key: key);

  @override
  State<CreateMomentToPostViewPage> createState() =>
      _CreateMomentToPostViewPageState();
}

class _CreateMomentToPostViewPageState
    extends State<CreateMomentToPostViewPage> {
  File? chosenImageFile;
  List<File> imageFileList = [];
  @override
  void initState() {
    super.initState();
    // imageFileList.add(chosenImageFile??File(""));
  }

  void onImageChosen(File imageFile) {
    chosenImageFile = imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AddNewPostBloc(newsfeedId: widget.newsfeedId),
        child: Selector<AddNewPostBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(children: [
            Scaffold(
                appBar: AppBar(
                  backgroundColor: PRIMARY_BACKGROUND_COLOR,
                  leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close_sharp,
                        size: 32,
                        color: PRIMARY_COLOR,
                      )),
                  title: Center(
                      child: TypicalText(
                          "New Moment", PRIMARY_COLOR, TEXT_REGULAR_2x,
                          isFontWeight: true)),
                  actions: [
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM_2,
                            vertical: MARGIN_MEDIUM),
                        padding: EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM,
                            vertical: MARGIN_CARD_MEDIUM_2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                            color: PRIMARY_COLOR),
                        child: Consumer<AddNewPostBloc>(
                            builder: (context,bloc,child) =>
                                GestureDetector(
                                    onTap: (){
                                      bloc.onTapAddNewPost().then((value){
                                        Navigator.pop(context);
                                      });
                                      },
                                    child: TypicalText("Create", Colors.white, TEXT_REGULAR)
                                )
                        )
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MARGIN_MEDIUM_LARGE,
                      ),
                      Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                          child: ProfileImageAndNameSectionView()),
                      AddNewPostTextFieldView(),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      Container(
                          height: 190,
                          width: double.infinity,
                          color: Colors.white70,
                          child: AddImagePostView(
                            chosenImageFileList: imageFileList,
                          ))
                    ],
                  ),
                ),

                floatingActionButton: Consumer<AddNewPostBloc>(
                    builder: (context, bloc, child) =>
                   Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                            color: PRIMARY_COLOR,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10.0)),
                    margin: const EdgeInsets.fromLTRB(0, 0, 16, 16),
                    width: 70,
                    height: 70,
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusColor: Colors.white54,
                      backgroundColor: Colors.white,
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        debugPrint("Image=>Picker");
                        final XFile? image =
                            await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          if (image != null) {
                            print("ImageFile===>${image}");
                            bloc.onImageChosen(File(image.path));
                            print("ImageFilePath===>${File(image.path)}");

                            imageFileList.add(File(image.path));
                            print("ImageListFile===>${imageFileList}");
                          }
                        });
                        // var result = await FilePicker.platform.pickFiles(allowMultiple: true);
                        //
                        // if (result != null) {
                        //   List<File> files = result.paths.map((path) => File(path??"")).toList();
                        // } else {
                        //   // User canceled the picker
                        // }
                      },
                      child: const Icon(
                        Icons.add,
                        color: PRIMARY_COLOR,
                        size: 35,
                      ),
                    ),
                  ),
                )),

            Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black12,
                  child: const Center(
                    child: LoadingView(),
                  ),
                )
            )
          ]),
        ));
  }
}

class ProfileImageAndNameSectionView extends StatelessWidget {
  const ProfileImageAndNameSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
        builder: (context, bloc, child)=>
       Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ProfileImageView(
              profileImage:
                  "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg"
                  ),
          SizedBox(
            width: MARGIN_MEDIUM_2,
          ),
          TypicalText(
            bloc.userName??"",
            PRIMARY_COLOR,
            TEXT_REGULAR_1X,
            isFontWeight: true,
          )
        ],
      ),
    );
  }
}

class AddNewPostTextFieldView extends StatelessWidget {
  const AddNewPostTextFieldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewPostBloc>(
      builder: (context, bloc, child) =>
       Container(
        margin: EdgeInsets.only(
            left: MARGIN_MEDIUM_LARGE,
            right: MARGIN_MEDIUM_LARGE,
            bottom: MARGIN_MEDIUM_LARGE),
        height: 200,
        // ADD_NEW_POST_TEXTFIELD_HEIGHT,
        child: TextField(
          maxLines: 24,
          controller: TextEditingController(text: bloc.newPostDescription),
          onChanged: (text) {
            bloc.onNewPostTextChanged(text);
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "What's on your mind?",
              hintStyle: TextStyle(fontSize: TEXT_REGULAR_2x)),
        ),
      ),
    );
  }
}

class AddImagePostView extends StatefulWidget {
  List<File>? chosenImageFileList;
  AddImagePostView({required this.chosenImageFileList});

  @override
  State<AddImagePostView> createState() => _AddImagePostViewState();
}

class _AddImagePostViewState extends State<AddImagePostView> {
  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //     child: (widget.chosenImageFile == null)
        //         ?
        //     SizedBox(
        //       height: 300,
        //       child: Image.network("https://www.namepros.com/attachments/empty-png.89209/"),
        //     )
        //      :
        //     SizedBox(
        //       height: 300,
        //       child: Image.file(
        //         widget.chosenImageFile ?? File(""),
        //         fit: BoxFit.cover,
        //       ),
        //     )
        // );

        (widget.chosenImageFileList != null)
            ? GridView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.65,
                  crossAxisCount: 2,
                  // widget.chosenImageFileList?.length??1,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                itemCount: widget.chosenImageFileList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      child: Image.file(
                        widget.chosenImageFileList?[index] ?? File(""),
                        fit: BoxFit.cover,
                        height: 180,
                        width: double.infinity,
                      ));
                },
              )
            : Container(
                color: Colors.red,
                height: 100,
              );
  }
}
