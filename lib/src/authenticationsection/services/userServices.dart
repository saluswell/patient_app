import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/utils/firebaseUtils.dart';
import '../Models/userModel.dart';
import '../Models/userModelDietitian.dart';

class UserServices {
  static String? userId;
  static UserModel? tempUser;
  static UserModelDietitian? tempUserDietitian;

  ///Create User
  Future createUser(UserModel userModel) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .doc(userModel.userId);
    return await docRef.set(userModel.toJson(docRef.id));
  }

  ///Fetch User Record
  Stream<UserModel> fetchUserRecord(String userID) {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .doc(userID)
        .snapshots()
        .map((userData) => UserModel.fromJson(userData.data()!));
  }

  ///Update user record with Image

  Future updateUserDetailswithImage(UserModel userModel) async {
    return await FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "userName": userModel.userName,
      "profilePicture": userModel.profilePicture,
    }, SetOptions(merge: true));
  }

  ///Update user record with Image

  Future updateUserDetailsWithoutImage(UserModel userModel) async {
    return await FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "userName": userModel.userName,
    }, SetOptions(merge: true));
  }

  Future updateUserSubscriptionDetails(UserModel userModel) async {
    return await FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "planName": userModel.planName,
      "planStatus": userModel.planStatus,
      "planPrice": userModel.planPrice,
      "subscriptionID": userModel.subscriptionID,
      "customerID": userModel.customerID,
      "currency": userModel.currency,
    }, SetOptions(merge: true));
  }
}
