import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/helperFunctions/getUserIDhelper.dart';
import '../../../common/utils/firebaseUtils.dart';
import '../models/medical_record_model.dart';

class MedicalRecordServices {
  ///Create Medial  Record
  Future createMedicalRecord(MedicalRecordModel medicalRecordModel) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(FirebaseUtils.medicalRecords)
        .doc();
    return await docRef.set(medicalRecordModel.toJson(docRef.id));
  }

  /// stream medical records
  Stream<List<MedicalRecordModel>> streamMedicalRecords(
      String dietitianID, String appointmentID) {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.medicalRecords)
        // .doc()
        .where("patientID", isEqualTo: getUserID())
        .where("dietitianID", isEqualTo: dietitianID)
        .where("appointmentID", isEqualTo: appointmentID)

        // .where("appointmentStatus", isEqualTo: appointmentStatus)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => MedicalRecordModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///delete medical record
  Future deleteMedicalRecord(String recordID) async {
    return await FirebaseFirestore.instance
        .collection(FirebaseUtils.medicalRecords)
        .doc(recordID)
        .delete();
  }
}
