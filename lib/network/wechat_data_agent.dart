import 'dart:io';

import 'package:wechat/data/vos/chat/contact_vo.dart';

import '../data/vos/news_feed_vo.dart';
import '../data/vos/otp_code_vo.dart';
import '../data/vos/user_vo.dart';


// import '../data/vos/user_vo.dart';

abstract class WeChatDataAgent {
  Stream<List<NewsFeedVO>?> getNewsFeed();
  Future<void> addNewPost(NewsFeedVO newPost);
  Future<void> deletePost(int postId);
  Stream<NewsFeedVO> getNewsFeedById(int newsfeedId);
  Future<String> uploadFileToFirebase(File image);

  Stream<UserVO> getUserScanId(String scanId);
  Stream<List<ContactVO>?> getContactsList();
  Future<void> addNewContact(ContactVO newContact);



  /// Authentication

  Future getOTP(OTPCodeVO otpCodeVO);
  Future registerNewUser(UserVO newUser);
  Future login(String email, String phoneNumber, String password);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future logOut();

}