import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:wechat/data/vos/chat/chat_message_vo.dart';
import 'package:wechat/data/vos/chat/contact_vo.dart';
import 'package:wechat/network/message_chat_agent.dart';
import 'package:wechat/network/wechat_data_agent.dart';
import '../data/vos/news_feed_vo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/vos/otp_code_vo.dart';
import '../data/vos/user_vo.dart';

///Database Paths
const newsMessagePath = "contactsAndMessages";


class RealtimeDatabaseDataAgentImpl extends MessageChatAgent {

  static final RealtimeDatabaseDataAgentImpl _singleton =
  RealtimeDatabaseDataAgentImpl._internal();

  factory RealtimeDatabaseDataAgentImpl(){
    return _singleton;
  }

  RealtimeDatabaseDataAgentImpl._internal();

  /// Database
  var databaseRef = FirebaseDatabase.instance.ref();

  /// Storage
  var firebaseStorage = FirebaseStorage.instance;

  ///Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Stream<List<ChatMessageVO>?> getMessageForUserChat(UserVO? currentUser, UserVO? otherUser) {
    return databaseRef.child(newsMessagePath).onValue.map((event) {
      return (event.snapshot.value as Map<dynamic, dynamic>)
          .values
          .map<ChatMessageVO>((element) {
        return ChatMessageVO.fromJson(Map<String, dynamic>.from(element));
      }).toList();
    });
  }

  @override
  Future<void> addNewPost(NewsFeedVO newPost) {
    return databaseRef
        .child(newsMessagePath)
        .child(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override

  @override
  Stream<NewsFeedVO> getNewsFeedById(int newsFeedId) {
    return databaseRef
        .child(newsMessagePath)
        .child(newsFeedId.toString())
        .once()
        .asStream()
        .map((event) {
      return NewsFeedVO.fromJson(
        Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>),
      );
    });
  }

  // @override
  // Future<String> uploadFileToFirebase(File image) {
  //   return firebaseStorage
  //       .ref(fileUploadRef)
  //       .child("${DateTime.now().millisecondsSinceEpoch}")
  //       .putFile(image)
  //       .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  // }
  

  

  @override
  UserVO getLoggedInUser() {
    return UserVO(
        id: auth.currentUser?.uid,
        phoneNumber: auth.currentUser?.phoneNumber,
        userName: auth.currentUser?.displayName
    );
  }


 

 

}