import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wechat/data/vos/user_vo.dart';
import '../data/vos/chat/contact_vo.dart';
import '../models/authentication_model.dart';
import '../models/authentication_model_impl.dart';

class ProfileBloc extends ChangeNotifier {
  /// State
  String userName = "";
  String phoneNumber = "";
  String birthDate = "";
  String genderType = "";
  String profilePicture = "";
  bool isDisposed = false;
  UserVO? userVO;
  List<ContactVO>? contactList = [];

  String? scanId;

  /// UserVO
  UserVO? loggedInUser;

  ///Model
  final AuthenticationModel _model = AuthenticationModelImpl();


  ProfileBloc(){

    loggedInUser = _model.getLoggedInUser();

    userName = loggedInUser?.userName??"";
    phoneNumber = loggedInUser?.phoneNumber??"";
    debugPrint("phoneNumber=>${userVO?.phoneNumber}");
    birthDate = loggedInUser?.birthDate??"";
    debugPrint("birthDate=>${loggedInUser?.birthDate}");
    genderType = loggedInUser?.gender??"";
    debugPrint("UserID=>${loggedInUser?.id}");
    profilePicture = "https://t3.ftcdn.net/jpg/03/55/66/32/360_F_355663236_ILrh4JIqDWc9OwvEiTUClmsJRrdIpucx.jpg";

    // _model.getContactList().listen((contacts_List) {
    //   contact_list = contacts_List;
    //   if(!isDisposed){
    //     notifyListeners();
    //   }
    // });
    // _notifySafety();

    _model.getContactList().listen((event) {
      contactList = event;
      debugPrint("ContactList=>${contactList}");
    });
    _notifySafety();

  }
  //String email,String phoneNumber,String otpCode, String userName, String password,String birthDate, String gender



  void onScanChanged(String scan_id) {
    this.scanId = scan_id;
    debugPrint("ScannerId=>${scanId}");

  }

  Future<void> getScanUser(String scan_id) async {
    debugPrint("Scanner=>${scan_id}");

    if(scanId == scan_id){
      debugPrint("Scanner==>${scan_id}");

      _model.getUserScanId(scanId.toString()).listen((scanUser) {
        // userVO = scanUser;
        getScanUserContact(scanUser.id??"",scanUser.email??"",scanUser.userName??"");
        debugPrint("ScannerscanUser=>${scanUser}");

        _notifySafety();
      }).onError((error){
        debugPrint("ScannerError=>${error}");

      });
    }

  }

  Future<void> getScanUserContact(String userId, String userEmail, String userName){
    return _model.addNewContact(
      // loggedInUser?.id??"",
      // loggedInUser?.email??"",
      // loggedInUser?.userName??"",
      userId, userEmail, userName

    );
  }


  // void saveToContact(List<UserVO?>? contactsList) {
  //   mBookModel.savedBooksToLibrary(contactsList??[]);
  //   notifySafely();
  // }

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