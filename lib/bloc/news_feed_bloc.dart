import 'package:flutter/material.dart';

import '../data/vos/news_feed_vo.dart';
import '../models/social_model.dart';
import '../models/social_model_impl.dart';

class NewsFeedBloc extends ChangeNotifier {
  List<NewsFeedVO>? newsFeed;
  final SocialModel _socialModel = SocialModelImpl();
  // final AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  bool isDisposed = false;

  NewsFeedBloc(){
    _socialModel.getNewsFeed().listen((newsFeedList) {
      newsFeed = newsFeedList;
      if(!isDisposed){
        notifyListeners();
      }
    });
    // _sendAnalyticsData();
  }

  // void _sendAnalyticsData() async {
  //   await FirebaseAnalyticsTracker().logEvent(homeScreenReached, null);
  // }
  void onTapDeletePost(int postId) async {
    await _socialModel.deletePost(postId);
  }

  // Future onTapLogout(){
  //   return _mAuthenticationModel.logOut();
  // }

  @override
  void dispose(){
    super.dispose();
    isDisposed = true;
  }
}