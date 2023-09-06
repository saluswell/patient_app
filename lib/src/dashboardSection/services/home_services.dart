import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/utils/firebaseUtils.dart';
import '../../../common/utils/textutils.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';

class HomeServices {
  Stream<List<UserModelDietitian>> streamAllDietitans() {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .where("UserType", isEqualTo: TextUtils.Dietitian)
        .where("PersonalInformationModel.title", isEqualTo: "Dietitian")
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => UserModelDietitian.fromJson(singleDoc.data()))
            .toList());
  }

  Stream<List<UserModelDietitian>> streamAllFitnessTrainers() {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.users)
        .where("UserType", isEqualTo: TextUtils.Dietitian)
        .where("PersonalInformationModel.title", isEqualTo: "Fitness Trainer")
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => UserModelDietitian.fromJson(singleDoc.data()))
            .toList());
  }
}
