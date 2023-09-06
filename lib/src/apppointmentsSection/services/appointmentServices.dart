import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/utils/firebaseUtils.dart';
import '../models/appointmentModel.dart';
import '../models/paymentPlanModel.dart';
import '../models/timeSlotModel.dart';

class AppointmentServices {
  /// stream timeslots
  Stream<List<TimeSlotModel>> streamTimeSlots(String userID, String date) {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.timeSlots)
        .doc(userID)
        .collection(FirebaseUtils.dates)
        .doc(date)
        .collection("timeslotdetails")
        // .where("dateofslot", isEqualTo: date)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) =>
                TimeSlotModel.fromJson(singleDoc.data(), singleDoc.id))
            .toList());
  }

  ///stream payment plans for dietitian and nutritionists
  Stream<List<PayementPlansModel>> streamPaymentPlans() {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.feeplans)
        .doc("U10WbRR5lCfXDEOSwTtR")
        .collection(FirebaseUtils.DietatiansFeesPlan)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => PayementPlansModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///Create Appointment
  Future createAppointment(AppointmentModel appointmentModel) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(FirebaseUtils.appointments)
        .doc(appointmentModel.appointmentId);
    return await docRef.set(appointmentModel.toJson(docRef.id));
  }

  /// stream appointments
  Stream<List<AppointmentModel>> streamAllAppointments(
      String appointmentStatus) {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.appointments)
        .where("patientID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("appointmentStatus", isEqualTo: appointmentStatus)
        //  .orderBy("combineDateTime", descending: false)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => AppointmentModel.fromJson(singleDoc.data()))
            .toList());
  }

  /// future pending appointments
  Future<List<AppointmentModel>> futurependingAppointments() async {
    //  print(myID);
    List<AppointmentModel> dataList = [];
    var snapData = await FirebaseFirestore.instance
        .collection(FirebaseUtils.appointments)
        .where('appointmentStatus', isEqualTo: "pending")
        .get();

    for (var singleDoc in snapData.docs) {
      dataList.add(AppointmentModel.fromJson(singleDoc.data()));
    }

    return dataList;
  }

  /// future progress appointments
  Future<List<AppointmentModel>> futureprogressAppointments() async {
    //  print(myID);
    List<AppointmentModel> dataList = [];
    var snapData = await FirebaseFirestore.instance
        .collection(FirebaseUtils.appointments)
        .where('appointmentStatus', isEqualTo: "progress")
        // .where('driverId', isEqualTo: UserService.userId)
        .get();

    for (var singleDoc in snapData.docs) {
      dataList.add(AppointmentModel.fromJson(singleDoc.data()));
    }

    return dataList;
  }

  /// future completed appointments
  Future<List<AppointmentModel>> futurecompletedAppointments() async {
    //  print(myID);
    List<AppointmentModel> dataList = [];
    var snapData = await FirebaseFirestore.instance
        .collection(FirebaseUtils.appointments)
        .where('appointmentStatus', isEqualTo: "completed")
        // .where('driverId', isEqualTo: UserService.userId)
        .get();

    for (var singleDoc in snapData.docs) {
      dataList.add(AppointmentModel.fromJson(singleDoc.data()));
    }

    return dataList;
  }
}
