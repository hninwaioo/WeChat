import '../data/vos/chat/contact_vo.dart';
import '../data/vos/user_vo.dart';

abstract class AuthenticationModel {
  Future<void> getOTP(String phoneNumber, String otpCode);

  Future<void> login(String email, String phoneNumber, String password);

  Future<void> register(String email, String phoneNumber, String otpCode, String userName, String password, String birthDate, String gender);

  bool isLoggedIn();

  UserVO getLoggedInUser();

  Future<void> logOut();

  /// Contact
  Stream<UserVO> getUserScanId(String scanId);

  void savedToContacts(List<UserVO?> usersList);

  Stream<List<ContactVO>?> getContactList();

  Future<void> addNewContact(String userId,String email,String userName);

}