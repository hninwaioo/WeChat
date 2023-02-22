import 'package:firebase_storage/firebase_storage.dart';
import 'package:wechat/data/vos/chat/chat_message_vo.dart';

import 'package:wechat/data/vos/user_vo.dart';
import 'package:wechat/models/authentication_model.dart';
import 'package:wechat/network/message_chat_agent.dart';

import '../network/real_time_database_data_agent_impl.dart';
import 'authentication_model_impl.dart';
import 'chat_model.dart';

class ChatModelImpl extends ChatModel {

  static final ChatModelImpl _singleton = ChatModelImpl._internal();
  var firebaseStorage = FirebaseStorage.instance;

  factory ChatModelImpl(){
    return _singleton;
  }
  ChatModelImpl._internal();
  MessageChatAgent mDataAgent = RealtimeDatabaseDataAgentImpl();

  AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  @override
  Future<void> addNewMessageTwoUsers(UserVO? currentUser, UserVO? otherUser, String description, file) {
    // TODO: implement addNewMessageTwoUsers
    throw UnimplementedError();
  }

  @override
  Stream<List<ChatMessageVO>?> getMessageForUserChat(UserVO? otherUser, UserVO? loginUser) {
    // TODO: implement getMessageForUserChat
    throw UnimplementedError();
  }


}
