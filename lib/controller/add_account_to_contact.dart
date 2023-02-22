import '../../data/vos/user_vo.dart';

class AddAccountToContact{
  List<UserVO?>? usersListInContact = [];

  void addBook (UserVO? user){
    usersListInContact?.add(user);
  }

  @override
  String toString() {
    return 'AddAccountToContact{usersListInContact: $usersListInContact}';
  }
}