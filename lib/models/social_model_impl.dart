import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:wechat/models/authentication_model.dart';
import 'package:wechat/models/authentication_model_impl.dart';
import 'package:wechat/models/social_model.dart';

import '../data/vos/news_feed_vo.dart';
import '../network/cloud_firestore_data_agent_impl.dart';
// import '../network/real_time_database_data_agent_impl.dart';
import '../network/wechat_data_agent.dart';

// const fileUploadRef = "uploads";

class SocialModelImpl extends SocialModel {
  static final SocialModelImpl _singleton = SocialModelImpl._internal();
  var firebaseStorage = FirebaseStorage.instance;

  factory SocialModelImpl(){
    return _singleton;
  }
  SocialModelImpl._internal();
  // WeChatDataAgent mDataAgent = RealtimeDatabaseDataAgentImpl();
  WeChatDataAgent mDataAgent = CloudFireStoreDataAgentImpl();

  AuthenticationModel _authenticationModel = AuthenticationModelImpl();


  @override
  Stream<List<NewsFeedVO>?> getNewsFeed() {
    return mDataAgent.getNewsFeed();
  }

  @override
  Future<void> addNewPost(String description, List<File>? imageFile) async{
    // var currentMilliseconds = DateTime.now().microsecondsSinceEpoch;
    // var newPost = NewsFeedVO(
    //     id: currentMilliseconds,
    //     description: description,
    //     profilePicture: "https://media.allure.com/photos/5a26c1d8753d0c2eea9df033/3:4/w_1262,h_1683,c_limit/mostbeautiful.jpg",
    //     userName: "Kitty",
    //     postImage:[],
    //   postDate: ""
    // );
    // return mDataAgent.addNewPost(newPost);
    if(imageFile != null){

      if(imageFile.length != 0){
        for(int i = 0; i< imageFile.length; i++){
          await mDataAgent.uploadFileToFirebase(imageFile[i]).then((downloadUrl){
            List<String>? listFile = [];
            listFile.add(downloadUrl);

            // if(listFile.length == imageFile.length){
            //   return craftNewsFeedVO(description, listFile)
            //       .then((newPost) => mDataAgent.addNewPost(newPost));
            // }
            return craftNewsFeedVO(description, listFile)
                .then((newPost) => mDataAgent.addNewPost(newPost));
          });
        }
      }
      // return AddPost(description,imageFile);
      //   return mDataAgent
      //       .uploadFileToFirebase(imageFile)
      //       .then((downloadUrl){
      //
      //     List<String>? listFile = [];
      //     listFile.add(downloadUrl);
      //     craftNewsFeedVO(description, listFile)
      //         .then((newPost) => mDataAgent.addNewPost(newPost));
      //   });

          // craftNewsFeedVO(description, downloadUrl)
          // .then((newPost) => mDataAgent.addNewPost(newPost));
    }else {
      return craftNewsFeedVO(description, [])
          .then((newPost) => mDataAgent.addNewPost(newPost));
    }

  }

  // Future<void> AddPost(String description,List<File> imageFile) async {
  //
  //   imageFile.forEach((element) {
  //     mDataAgent
  //         .uploadFileToFirebase(element)
  //         .then((downloadUrl){
  //
  //       List<String>? listFile = [];
  //       listFile.add(downloadUrl);
  //       craftNewsFeedVO(description, listFile)
  //           .then((newPost) => mDataAgent.addNewPost(newPost));
  //     });
  //   });
  //
  // }

  Future<NewsFeedVO> craftNewsFeedVO(String description, List<String> imageUrl){
    var currentMilliseconds = DateTime.now().microsecondsSinceEpoch;
    var newPost = NewsFeedVO(
        id: currentMilliseconds,
        description: description,
        profilePicture: "https://media.allure.com/photos/5a26c1d8753d0c2eea9df033/3:4/w_1262,h_1683,c_limit/mostbeautiful.jpg",
        userName: _authenticationModel.getLoggedInUser().userName,
        postImage: imageUrl,
        postDate: DateTime.now().toString()
    );
    return Future.value(newPost);
  }

  @override
  Future<void> deletePost(int postId){
    return mDataAgent.deletePost(postId);
  }

  @override
  Future<void> editPost(NewsFeedVO newsfeed, List<File>? imageFile) {
    return mDataAgent.addNewPost(newsfeed);
  }

  @override
  Stream<NewsFeedVO> getNewsFeedById(int newsfeedId) {
    return mDataAgent.getNewsFeedById(newsfeedId);
  }

  @override
  Future<String> uploadFileToFirebase(File image){
    return firebaseStorage
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }


}