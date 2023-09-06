import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saluswell_patient_updated/common/helperFunctions/showsnackbar.dart';

import '../../authenticationsection/Models/userModel.dart';
import '../models/timeslot_model.dart';

class TimeSlotProvider extends ChangeNotifier {
  bool isLoading = false;
  UserModel? userModel;

  makeLoadingTrue() {
    Future.delayed(Duration(milliseconds: 1)).whenComplete(() {
      isLoading = true;
      notifyListeners();
    });
  }

  makeLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  List<TimeSlot> _morningSlots = [];
  List<TimeSlot> _afternoonSlots = [];
  List<TimeSlot> _eveningSlots = [];
  List<TimeSlot> _nightSlots = [];

  List<TimeSlot> get morningSlots => _morningSlots;

  List<TimeSlot> get afternoonSlots => _afternoonSlots;

  List<TimeSlot> get eveningSlots => _eveningSlots;

  List<TimeSlot> get nightSlots => _nightSlots;

  // TimeSlotProvider() {
  //   fetchData();
  // }

  Future<void> fetchDietitianAvailability(String userId) async {
    try {
      // Fetch data from Firestore
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (documentSnapshot.exists) {
        // Parse UserModel from documentSnapshot
        UserModel userModel =
            UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

        // Clear previous data
        _morningSlots.clear();
        _afternoonSlots.clear();
        _eveningSlots.clear();
        _nightSlots.clear();

        // Convert timestamps to DateTime objects and categorize them
        List availableTimeSlots = userModel.availabletimeSlots!
            .map((timestamp) => timestamp.toDate())
            .toList();
        dp(
            msg: "available time slots in the form of date time ",
            arg: availableTimeSlots.toList().toString());
        for (DateTime time in availableTimeSlots) {
          if (time.hour >= 5 && time.hour < 12) {
            _morningSlots.add(TimeSlot(
                startTime: time, endTime: time.add(Duration(minutes: 30))));
          } else if (time.hour >= 12 && time.hour < 17) {
            _afternoonSlots.add(TimeSlot(
                startTime: time, endTime: time.add(Duration(minutes: 30))));
          } else if (time.hour >= 17 && time.hour < 22) {
            _eveningSlots.add(TimeSlot(
                startTime: time, endTime: time.add(Duration(minutes: 30))));
          } else {
            _nightSlots.add(TimeSlot(
                startTime: time, endTime: time.add(Duration(minutes: 30))));
          }
        }

        notifyListeners();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void toggleSlotSelection(TimeSlot slot) {
    slot.isSelected = !slot.isSelected;
    notifyListeners();
  }

  List<TimeSlot> getSelectedSlots() {
    List<TimeSlot> selectedSlots = [];
    selectedSlots.addAll(_morningSlots.where((slot) => slot.isSelected));
    selectedSlots.addAll(_afternoonSlots.where((slot) => slot.isSelected));
    selectedSlots.addAll(_eveningSlots.where((slot) => slot.isSelected));
    selectedSlots.addAll(_nightSlots.where((slot) => slot.isSelected));
    return selectedSlots;
  }
}
