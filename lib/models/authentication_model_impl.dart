import 'package:wechat/data/vos/chat/contact_vo.dart';
import 'package:wechat/data/vos/otp_code_vo.dart';
import '../data/vos/user_vo.dart';
import '../network/cloud_firestore_data_agent_impl.dart';
// import '../network/real_time_database_data_agent_impl.dart';
import '../network/wechat_data_agent.dart';
import 'authentication_model.dart';

class AuthenticationModelImpl extends AuthenticationModel {
  static final AuthenticationModelImpl _singleton = AuthenticationModelImpl._internal();

  factory AuthenticationModelImpl(){
    return _singleton;
  }
  AuthenticationModelImpl._internal();

  // WeChatDataAgent mDataAgent = RealtimeDatabaseDataAgentImpl();
  WeChatDataAgent mDataAgent = CloudFireStoreDataAgentImpl();

  @override
  Future<void> getOTP(String phoneNumber, String otpCode) {
    // return mDataAgent.getOTP(phoneNumber, otpCode);
    return craftOTPCodeVO(phoneNumber, otpCode)
        .then((code) => mDataAgent.getOTP(code));
  }

  Future<OTPCodeVO> craftOTPCodeVO(String phoneNumber,String otpCode){
    var currentMilliseconds = DateTime.now().microsecondsSinceEpoch;

    var otp_code = OTPCodeVO(
      id: currentMilliseconds,
      phoneNumber: phoneNumber,
      otpCode: "1234",
    );
    return Future.value(otp_code);
  }

  @override
  Future<void> login(String email,String phoneNumber, String password) {
    return mDataAgent.login(email, phoneNumber, password);
  }

  @override
  Future<void> register(String email, String phoneNumber, String otpCode, String userName, String password, String birthDate, String gender) {
    return craftUserVO(email, phoneNumber, otpCode, userName, password, birthDate, gender)
        .then((user) => mDataAgent.registerNewUser(user));
  }

  Future<UserVO> craftUserVO(String email,String phoneNumber,String otpCode, String userName, String password,String birthDate, String gender){
    var newUser = UserVO(
      id: "",
      phoneNumber: phoneNumber,
      email: email,
      otpCode: otpCode,
      userName: userName,
      password: password,
      birthDate: birthDate,
      gender: gender
    );
    return Future.value(newUser);
  }

  @override
  UserVO getLoggedInUser() {
    return mDataAgent.getLoggedInUser();
  }

  @override
  bool isLoggedIn() {
    return mDataAgent.isLoggedIn();
  }

  @override
  Future<void> logOut() {
    return mDataAgent.logOut();
  }

  @override
  void savedToContacts(List<UserVO?> usersList) {
    // mBookDao.savedAllBooks(usersList);
  }

  @override
  Stream<UserVO> getUserScanId(String scanId) {
    return mDataAgent.getUserScanId(scanId);
  }

  @override
  Stream<List<ContactVO>?> getContactList() {
    return mDataAgent.getContactsList();
  }

  @override
  Future<void> addNewContact(String userId,String email,String userName) {
    var currentMilliseconds = DateTime.now().microsecondsSinceEpoch;
    var newContact = ContactVO(
        id: currentMilliseconds,
        userId: userId,
        email: email,
      userName: userName,

    );
    return mDataAgent.addNewContact(newContact);
  }
}