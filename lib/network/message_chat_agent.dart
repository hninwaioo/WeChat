import 'package:wechat/data/vos/chat/chat_message_vo.dart';
import 'package:wechat/data/vos/user_vo.dart';

abstract class MessageChatAgent {
  Stream<List<ChatMessageVO>?> getMessageForUserChat(UserVO? currentUser, UserVO? contactUser);

}