import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:saluswell_patient_updated/common/keys/stripe_keys.dart';
import 'package:saluswell_patient_updated/src/apppointmentsSection/providers/timeslot_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';
import '../../authenticationsection/providers/savUserDetailsProvider.dart';
import '../../dashboardSection/providers/bottom_navbar_provider.dart';
import '../../dashboardSection/screens/bottomNavScreen.dart';
import '../../notificationSection/models/notificationModel.dart';
import '../../notificationSection/services/notification.dart';
import '../../notificationSection/services/notificationFirebaseServices.dart';
import '../../notificationSection/services/notification_handler.dart';
import '../../payementSection/models/paymentModel.dart';
import '../../payementSection/services/paymentServices.dart';
import '../models/appointmentModel.dart';
import '../models/paymentPlanModel.dart';
import '../models/timeSlotModel.dart';
import '../services/appointmentServices.dart';

enum AppointmentEnum { pending, progress, completed, cancelled }

class AppointmentProvider extends ChangeNotifier {
  NotificationHandler notificationHandler = NotificationHandler();

  ///variables
  Timer? countdownTimer;
  Duration? myDuration;
  int? daysvar;
  int? hoursvar;
  int? minutesvar;
  int? secondsvar;

  int? selectedIndex;
  int? selectedIndexforPaymentPlan;
  List<dynamic> availableSlots = [];

  num? pricevar;

  var bottomnavprovier =
      Provider.of<BottomNavProvider>(navstate.currentState!.context);

  String? timeslot;

  ///saving models

  TimeSlotModel? timeSlotModel;
  PayementPlansModel? payementPlansModelvar;

  // DateRangePickerController datePickerControllerfortimeslot =
  //     DateRangePickerController();

  /// services
  AppointmentServices appointmentServices = AppointmentServices();
  PaymentServices paymentServices = PaymentServices();
  NotificationServices notificationServices = NotificationServices();
  NotificationFirebaseServices notificationFirebaseServices =
      NotificationFirebaseServices();

  List<dynamic> acessoriesList = [];
  TimeOfDay? startingSelectedTime;
  TimeOfDay? endingSelectedTime;
  DateRangePickerController datePickerController = DateRangePickerController();

  // DateRangePickerController datePickerControllerfortimeslot = DateRangePickerController();
  TextEditingController patientNoteController = TextEditingController();
  Map<String, dynamic>? paymentIntentData;

  List<AppointmentModel> pendingAppointmentList = [];
  List<AppointmentModel> progressAppointmentList = [];
  List<AppointmentModel> completedAppointmentList = [];

  UserModelDietitian? userModelDietitian;

  void saveDietitianUserDetails(UserModelDietitian? userModelDietitians) {
    userModelDietitian = userModelDietitians;
    notifyListeners();
  }

  UserModelDietitian? getUserDetails() => userModelDietitian;

  var currentUserModel =
      Provider.of<UserProvider>(navstate.currentState!.context)
          .getUserDetails();

  DateTime? combineDateTimes;

  bool isLoading = false;

  updateDayHoursMinutes(DateTime combineDateTime) {
    daysvar = combineDateTime
        .subtract(Duration(
            days: DateTime.now().day,
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
            seconds: DateTime.now().second,
            milliseconds: 0,
            microseconds: 0))
        .day;
    hoursvar = combineDateTime
        .subtract(Duration(
            days: DateTime.now().day,
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
            seconds: DateTime.now().second,
            milliseconds: 0,
            microseconds: 0))
        .hour;
    minutesvar = combineDateTime
        .subtract(Duration(
            days: DateTime.now().day,
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
            seconds: DateTime.now().second,
            milliseconds: 0,
            microseconds: 0))
        .minute;
    secondsvar = combineDateTime
        .subtract(Duration(
            days: DateTime.now().day,
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
            seconds: DateTime.now().second,
            milliseconds: 0,
            microseconds: 0))
        .second;

    updateDuration();
    notifyListeners();
  }

  var timeSlotProvider = Provider.of<TimeSlotProvider>(
      navstate.currentState!.context,
      listen: false);

  getDateTimeandSetDateTimeCombine() {
    var dateTime = DateTime(
        datePickerController.selectedDate!.year,
        datePickerController.selectedDate!.month,
        datePickerController.selectedDate!.day > 0
            ? datePickerController.selectedDate!.day
            : 00,
        timeSlotProvider.getSelectedSlots().first.startTime.hour,
        timeSlotProvider.getSelectedSlots().first.startTime.minute,
        //  DateTime.parse(timeslot.toString()).hour,
        // DateTime.parse(timeslot.toString()).minute,
        0,
        0,
        0);
    combineDateTimes = dateTime;
    notifyListeners();
  }

  updateDuration() {
    myDuration = Duration(
        days: daysvar!,
        hours: hoursvar!,
        minutes: minutesvar!,
        seconds: secondsvar!,
        milliseconds: 0,
        microseconds: 0);
    notifyListeners();
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    print("stop timer called");
    countdownTimer!.cancel();

    daysvar = null;
    hoursvar = null;
    minutesvar = null;
    secondsvar = null;
    notifyListeners();
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    myDuration = Duration(days: 5);
    notifyListeners();
  }

  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;

    final seconds = myDuration!.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
    notifyListeners();
  }

  makeLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  makeLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  addOrRemoveAvailableTimeSlots(context, String accessory) async {
    if (availableSlots.contains(accessory)) {
      availableSlots.remove(accessory);
      notifyListeners();
    } else {
      availableSlots.add(accessory);
      notifyListeners();
    }
  }

  addOrRemoveAccessory(context, String accessory) async {
    if (acessoriesList.contains(accessory)) {
      acessoriesList.remove(accessory);
      notifyListeners();
    } else {
      acessoriesList.add(accessory);
      notifyListeners();
    }
  }

  void onSelectionChanged(
    DateRangePickerSelectionChangedArgs args,
  ) {
    datePickerController.selectedDate;
    notifyListeners();
    //  mergeDateAndTime();

// TODO: implement your code here
  }

  updateStartingTime(val) {
    // dp(msg: "Start time", arg: val.toString());
    startingSelectedTime = val;
    notifyListeners();
    // mergeDateAndTime();
  }

  updateEndingTime(val) {
    //dp(msg: "End time", arg: val.toString());
    endingSelectedTime = val;
    notifyListeners();
  }

  // mergeDateAndTime() {
  //   var dateTime = DateTime(
  //       datePickerController.selectedDate!.year,
  //       datePickerController.selectedDate!.month,
  //       datePickerController.selectedDate!.day,
  //       startingSelectedTime!.hour,
  //       startingSelectedTime!.minute,
  //       0,
  //       0,
  //       0);
  //   combineDateTime = dateTime;
  //   notifyListeners();
  // }

  ///------------------------ stripe payment integration   -------------------------------------------
  Future<void> makePayment() async {
    convertPrice();
    try {
      paymentIntentData = await createPaymentIntent(
          pricevar.toString(), 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  //   applePay: true,
                  //    googlePay: true,
                  //  testEnv: true,
                  style: ThemeMode.light,

                  // merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  convertPrice() {
    var price = int.parse(payementPlansModelvar!.visitPrice!) * 100;

    pricevar = price;
    notifyListeners();
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) async {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(navstate.currentState!.context)
            .showSnackBar(SnackBar(content: Text("Paid successfully")));

        await paymentServices
            .createPayment(PaymentModel(
          paymentDateTime: Timestamp.now(),
          totalAmount: payementPlansModelvar!.visitPrice.toString(),
          fees: "20",
          recieverId: userModelDietitian!.userId,
          reciverName: userModelDietitian!.userName,
          recieverPic: userModelDietitian!.profilePicture,
          senderId: currentUserModel!.userId,
          senderName: currentUserModel!.userName,
          senderpic: currentUserModel!.profilePicture,
        ))
            .then((value) {
          makeLoadingFalse();

          notificationHandler.oneToOneNotificationHelper(
              docID: userModelDietitian!.userId.toString(),
              body:
                  "Patient ${currentUserModel!.userName} send you a payment for appointment",
              title: "Payment Update");
          notificationFirebaseServices.createNotification(
              NotificationModelFirebase(
                  //  senderId: currentUserModel!.userId,
                  recieverId: userModelDietitian!.userId,
                  notificationDateTime: Timestamp.now(),
                  notificationTitle: "Payment Update",
                  notificationDescription:
                      "Patient ${currentUserModel!.userName} send you a payment for appointment",
                  notificationtype: "Payment"));
          // NotificationServices().pushOneToOneNotification(
          //   title: "Payment Update",
          //   body:
          //       "Patient ${currentUserModel!.userName} send you a payment for appointment",
          //   sendTo: userModelDietitian!.userId.toString(),
          // );
        });

        await createAppointment();

        //  bottomnavprovier.updateCurrentScreen(1);

        // toNext(
        //     context: navstate.currentState!.context,
        //     widget: UpcomingAppointmenrsScreen());
      })

          //  paymentIntentData = null;
          .onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: navstate.currentState!.context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

//  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': pricevar.toString(),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${StripeKeys.secretKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent response ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  /// get pending appointments lists
  getpendingAppointments() async {
    pendingAppointmentList =
        await appointmentServices.futurependingAppointments();
  }

  /// get pending appointments lists
  getprogressAppointments() async {
    progressAppointmentList =
        await appointmentServices.futureprogressAppointments();
  }

  /// get completed appointments lists
  getcompletedAppointments() async {
    completedAppointmentList =
        await appointmentServices.futurecompletedAppointments();
  }

  ///  ---------------------- create appointment section ----------------------------------

  createAppointment() {
    makeLoadingTrue();
    appointmentServices
        .createAppointment(AppointmentModel(
            dateCreated: Timestamp.now(),
            appointmentDateTime:
                Timestamp.fromDate(datePickerController.selectedDate!),
            timeslot: timeslot,

            // appointmentDateTime: Timestamp.fromDate(combineDateTime!),
            appointmentFees: payementPlansModelvar!.visitPrice.toString(),
            appointmentStatus: "progress",
            dietitianId: userModelDietitian!.userId,
            dietitianName: userModelDietitian!.userName,
            dietitianProfilePic: userModelDietitian!.profilePicture,
            patientId: FirebaseAuth.instance.currentUser!.uid,
            patientName: currentUserModel!.userName,
            patientProfilePic: currentUserModel!.profilePicture,
            isApproveByDietitian: false,
            isReviewGivenByDietitian: false,
            isReviewGivenByPatient: false,
            combineDateTime: Timestamp.fromDate(combineDateTimes!),
            // from: timeSlotModel!.startTime,
            //to: timeSlotModel!.endTime,
            payementPlansModel: payementPlansModelvar,
            patientQuestionareModel: currentUserModel!.patientQuestionareModel,
            noteFromPatient: patientNoteController.text))
        .then((value) {
      makeLoadingFalse();
      //  startTimer();

      toNext(
          context: navstate.currentState!.context,
          widget: const BottomNavScreen(
            index: 1,
          ));
      bottomnavprovier.updateCurrentScreen(1);
      notificationHandler.oneToOneNotificationHelper(
          docID: userModelDietitian!.userId.toString(),
          body:
              "Patient ${currentUserModel!.userName} book an appointment with you",
          title: "Appointment Update");
    }).then((value) {
      notificationFirebaseServices.createNotification(NotificationModelFirebase(
          //  senderId: currentUserModel!.userId,
          recieverId: userModelDietitian!.userId,
          notificationDateTime: Timestamp.now(),
          notificationTitle: "Appointment Update",
          notificationDescription:
              "Patient ${currentUserModel!.userName} book an appointment with you",
          notificationtype: "Appointment"));
    });
  }
}
