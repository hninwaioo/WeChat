import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat/data/vos/chat/chat_message_vo.dart';
import 'package:wechat/data/vos/user_vo.dart';
import 'package:wechat/models/social_model.dart';
import 'package:wechat/models/social_model_impl.dart';
import '../models/authentication_model.dart';
import '../models/authentication_model_impl.dart';
import '../models/chat_model.dart';
import '../models/chat_model_impl.dart';

class MessageChatBloc extends ChangeNotifier {
  /// State
  UserVO? currentUser;
  UserVO? contactUser;
  String message = "";
  File? file;
  List<ChatMessageVO>? messageList;
  bool isDisposed = false;

  ///Model
  final AuthenticationModel _model = AuthenticationModelImpl();
  final ChatModel _chatModel = ChatModelImpl();

  MessageChatBloc(UserVO? otherUser, UserVO? loginUser){
    currentUser = loginUser;
    this.contactUser = otherUser;

    _notifySafety();

    if(currentUser != null && this.contactUser != null){
      _chatModel.getMessageForUserChat(currentUser, this.contactUser)
          .listen((messageList){
            messageList!.sort((a,b) => int.parse(a.timeStamp ?? "")
                .compareTo(int.parse(b.timeStamp ??"")));
            this.messageList = messageList;
            _notifySafety();
      });
    }

  }

  Future<void> onTapSendMessage(){
    print(message);

    if(message.isEmpty ?? false){
      return Future.error("error");
    }else {
      return _addNewMessage().then((value) =>
          _chatModel.getMessageForUserChat(contactUser, currentUser)
          .listen((event) {
            messageList!.sort((a,b) => int.parse(a.timeStamp ??"")
                .compareTo(int.parse(b.timeStamp ?? ""))
            );
            this.messageList = messageList;
            _notifySafety();
          })
      );
    }
  }

  Future<void> _addNewMessage() async {
    if(message != null){
      return _chatModel.addNewMessageTwoUsers(currentUser, contactUser, message, file);
    }
    return Future.error("Error");
  }


  void _notifySafety(){
    if(!isDisposed){
      notifyListeners();
    }
  }
  @override
  void dispose(){
    super.dispose();
    isDisposed = true;
  }
}