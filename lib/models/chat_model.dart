import 'dart:io';

import '../data/vos/chat/chat_message_vo.dart';
import '../data/vos/user_vo.dart';

abstract class ChatModel {

  Stream<List<ChatMessageVO>?> getMessageForUserChat(UserVO? otherUser, UserVO? loginUser);
  Future<void> addNewMessageTwoUsers(UserVO? currentUser, UserVO? otherUser,String description, File? file);

}