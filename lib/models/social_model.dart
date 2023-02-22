import 'dart:io';

import 'package:wechat/data/vos/chat/chat_message_vo.dart';
import 'package:wechat/data/vos/user_vo.dart';

import '../data/vos/news_feed_vo.dart';

abstract class SocialModel {
  Stream<List<NewsFeedVO>?> getNewsFeed();
  Future<void> addNewPost(String description, List<File>? imageFile);
  Future<void> deletePost(int postId);
  Future<void> editPost(NewsFeedVO newsFeed, List<File>? imageFile);
  Stream<NewsFeedVO> getNewsFeedById(int newsfeedId);
}