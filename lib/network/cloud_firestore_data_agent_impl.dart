// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:social_media_app/data/vos/news_feed_vo.dart';
// import 'package:social_media_app/data/vos/user_vo.dart';
// import 'package:social_media_app/network/wechat_data_agent.dart';
//
// /// News Feed Collection
// const newsFeedCollection = "newsfeed";
// const fileUploadRef = "uploads";
// const userCollection = "users";
//
// class CloudFireStoreDataAgentImpl extends SocialDataAgent {
//
//   /// Storage
// final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//
// ///Auth
// FirebaseAuth auth = FirebaseAuth.instance;
//
//   @override
//   Future<void> addNewPost(NewsFeedVO newPost) {
//     return _fireStore
//         .collection(newsFeedCollection)
//         .doc(newPost.id.toString())
//         .set(newPost.toJson());
//   }
//
//   @override
//   Future<void> deletePost(int postId) {
//     return _fireStore
//         .collection(newsFeedCollection)
//         .doc(postId.toString())
//         .delete();
//   }
//
//   @override
//   Stream<List<NewsFeedVO>?> getNewsFeed() {
//     //snapshots => querySnapShot => querySnapShot.docs => List<QueryDocumentSnapShot> => data()
//     // => List<Map<String, dynamic>> => NewsFeedVO.fromJson => List<NewsFeedVO>
//     return _fireStore
//         .collection(newsFeedCollection)
//         .snapshots()
//         .map((querySnapShot){
//        return querySnapShot.docs.map<NewsFeedVO>((document){
//          return NewsFeedVO.fromJson(document.data());
//        }).toList();
//     });
//   }
//
//   @override
//   Stream<NewsFeedVO> getNewsFeedById(int newsfeedId) {
//     return _fireStore
//         .collection(newsFeedCollection)
//         .doc(newsfeedId.toString())
//         .get()
//         .asStream()
//         .where((documentSnapShot) => documentSnapShot.data() != null)
//         .map((documentSnapShot) => NewsFeedVO.fromJson(documentSnapShot.data()!));
//   }
//
//   @override
//   Future<String> uploadFileToFirebase(File image) {
//     return FirebaseStorage.instance
//         .ref(fileUploadRef)
//         .child("${DateTime.now().millisecondsSinceEpoch}")
//         .putFile(image)
//         .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
//   }
//
//   @override
//   Future registerNewUser(UserVO newUser) {
//     return auth
//         .createUserWithEmailAndPassword(
//         email: newUser.email??"", password: newUser.password??"")
//         .then((credential) =>
//     credential.user?..updateDisplayName(newUser.userName))
//         .then((user){
//       newUser.id = user?.uid ??"";
//       _addNewUser(newUser);
//     });
//   }
//
//   Future<void> _addNewUser(UserVO newUser){
//     return _fireStore
//         .collection(userCollection)
//         .doc(newUser.id.toString())
//         .set(newUser.toJson());
//   }
//
//   @override
//   Future login(String email, String password) {
//     return auth.signInWithEmailAndPassword(email: email, password: password);
//   }
//
//   @override
//   UserVO getLoggedInUser() {
//     return UserVO(
//         id: auth.currentUser?.uid,
//         email: auth.currentUser?.email,
//         userName: auth.currentUser?.displayName
//     );
//   }
//
//   @override
//   bool isLoggedIn() {
//     return auth.currentUser != null;
//   }
//
//   @override
//   Future logOut() {
//     return auth.signOut();
//   }
//
// }

import 'dart:io';
// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:wechat/network/wechat_data_agent.dart';
import '../data/vos/chat/contact_vo.dart';
import '../data/vos/news_feed_vo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/vos/otp_code_vo.dart';
import '../data/vos/user_vo.dart';

///Database Paths
const newsFeedCollection = "newsfeed";
const fileUploadRef = "uploads";
const userCollection = "user";
const otpCodeCollection = "otp";
const contactsCollection = "contacts";

class CloudFireStoreDataAgentImpl extends WeChatDataAgent {

  static final CloudFireStoreDataAgentImpl _singleton =
  CloudFireStoreDataAgentImpl._internal();

  factory CloudFireStoreDataAgentImpl(){
    return _singleton;
  }

  CloudFireStoreDataAgentImpl._internal();

  /// Database
  // var databaseRef = FirebaseDatabase.instance.ref();

  /// Storage
  // var firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  ///Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  // @override
  // Stream<List<NewsFeedVO>> getNewsFeed() {
  //   return databaseRef.child(newsFeedPath).onValue.map((event) {
  //     return (event.snapshot.value as Map<String, dynamic>)
  //         .values
  //         .map<NewsFeedVO>((element) {
  //
  //       return NewsFeedVO.fromJson(Map<String, dynamic>.from(element));
  //     }).toList();
  //     // return event.snapshot.value.map<NewsFeedVO>((element){
  //     //   return NewsFeedVO.fromJson(Map<String, dynamic>.from(element));
  //     // }).toList();
  //
  //   });
  // }

  @override
  Stream<List<NewsFeedVO>?> getNewsFeed() {
    //snapshots => querySnapShot => querySnapShot.docs => List<QueryDocumentSnapShot> => data()
    // => List<Map<String, dynamic>> => NewsFeedVO.fromJson => List<NewsFeedVO>
    return _fireStore
        .collection(newsFeedCollection)
        .snapshots()
        .map((querySnapShot){
      return querySnapShot.docs.map<NewsFeedVO>((document){
        return NewsFeedVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<void> addNewPost(NewsFeedVO newPost) {
    return _fireStore
        .collection(newsFeedCollection)
        .doc(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return _fireStore
        .collection(newsFeedCollection)
        .doc(postId.toString())
        .delete();  }

  @override
  Stream<NewsFeedVO> getNewsFeedById(int newsfeedId) {
    return _fireStore
        .collection(newsFeedCollection)
        .doc(newsfeedId.toString())
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) => NewsFeedVO.fromJson(documentSnapShot.data()!));
  }

  @override
  Future<String> uploadFileToFirebase(File imageFile) {
    return
      // addPostImageList(imagelist);
      FirebaseStorage.instance
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(imageFile)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  Future<String> addPostImageList(List<File> imageFile) async {

    var imageString = "";
    imageFile.forEach((image) {
      FirebaseStorage.instance
          .ref(fileUploadRef)
          .child("${DateTime.now().millisecondsSinceEpoch}")
          .putFile(image)
          .then((taskSnapshot) {
            taskSnapshot.ref.getDownloadURL();
            imageString = taskSnapshot.ref.getDownloadURL().toString();

      });
    });

    return imageString;

  }

  @override
  Future getOTP(OTPCodeVO otpCodeVO) {
    // return auth.createUserWithEmailAndPassword(phoneNumber);
    // return databaseRef
    //     .child(otpCodePath)
    //     .child(otpCodeVO.id.toString())
    //     .set(otpCodeVO.toJson());

    return _fireStore
        .collection(otpCodeCollection)
        .doc(otpCodeVO.id.toString())
        .set(otpCodeVO.toJson());

    // return FirebaseAuth.instance.verifyPhoneNumber (
    //   phoneNumber: '+95959102403',
    //   verificationCompleted: (PhoneAuthCredential credential) async{
    //     await auth.signInWithCredential(credential);
    //
    //   },
    //   verificationFailed: (FirebaseAuthException e) {
    //     if (e.code == 'invalid-phone-number') {
    //       print('The provided phone number is not valid.');
    //     }
    //   },
    //   codeSent: (String verificationId, int? resendToken) async{
    //     // Update the UI - wait for the user to enter the SMS code
    //     String smsCode = 'xxxx';
    //
    //     // Create a PhoneAuthCredential with the code
    //     PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    //
    //     // Sign the user in (or link) with the credential
    //     await auth.signInWithCredential(credential);
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //
    //   },
    // );
  }

  @override
  Future registerNewUser(UserVO newUser) {
    return auth
        .createUserWithEmailAndPassword(
        email: newUser.email??"", password: newUser.password??"")
        .then((credential) =>
    credential.user?..updateDisplayName(newUser.userName))
        .then((user){
      newUser.id = user?.uid ??"";
      debugPrint("newUser===>${newUser}");
      _addNewUser(newUser);
    });
  }

  Future<void> _addNewUser(UserVO newUser){
    return _fireStore
        .collection(userCollection)
        .doc(newUser.id.toString())
        .set(newUser.toJson());
  }

  @override
  Future login(String email, String phoneNumber, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  UserVO getLoggedInUser() {
    return UserVO(
        id: auth.currentUser?.uid,
        phoneNumber: auth.currentUser?.phoneNumber,
        userName: auth.currentUser?.displayName
    );
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Future logOut() {
    return auth.signOut();
  }

  @override
  Stream<UserVO> getUserScanId(String scanId) {
    return _fireStore
        .collection(userCollection)
        .doc(scanId.toString())
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) => UserVO.fromJson(documentSnapShot.data()!));
  }

  @override
  Stream<List<ContactVO>?> getContactsList() {
    //snapshots => querySnapShot => querySnapShot.docs => List<QueryDocumentSnapShot> => data()
    // => List<Map<String, dynamic>> => NewsFeedVO.fromJson => List<NewsFeedVO>
    return _fireStore
        .collection(contactsCollection)
        .snapshots()
        .map((querySnapShot){
      return querySnapShot.docs.map<ContactVO>((document){
        return ContactVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Future<void> addNewContact(ContactVO newContact) {
    return _fireStore
        .collection(contactsCollection)
        .doc(newContact.id.toString())
        .set(newContact.toJson());
  }
}