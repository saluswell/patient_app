import 'dart:async';

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/getUserIDhelper.dart';
import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/firebaseUtils.dart';
import '../../../common/utils/themes.dart';
import '../../../res.dart';
import '../../VideoCallingSection/screens/zego_simple_join_video_call.dart';
import '../../chatSection/screens/messages.dart';
import '../../medicalRecordSection/screens/medical_record_list_screen.dart';
import '../../reviewsSection/screens/givereviewScreen.dart';
import '../models/appointmentModel.dart';
import '../providers/appointmentProvider.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final AppointmentModel appointmentModel;

  const AppointmentDetailsScreen({Key? key, required this.appointmentModel})
      : super(key: key);

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  // int? daysvar;
  // int? hoursvar;
  // int? minutesvar;
  // int? secondsvar;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      updateValues();
    });

    super.initState();
  }

  updateValues() {
    //if (DateTime.now()
    //.isBefore(widget.appointmentModel.combineDateTime!.toDate())) {
    context.read<AppointmentProvider>().updateDayHoursMinutes(
        widget.appointmentModel.combineDateTime!.toDate());
    // } else {
    //   context.read<AppointmentProvider>().stopTimer();
    // }
  }

  @override
  void dispose() {
    // print("stop timer");
    context.read<AppointmentProvider>().stopTimer();
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appointmentProvider = Provider.of<AppointmentProvider>(context);
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days =
        strDigits(appointmentProvider.myDuration!.inDays.remainder(31));

    // Step 7
    final hours =
        strDigits(appointmentProvider.myDuration!.inHours.remainder(24));
    final minutes =
        strDigits(appointmentProvider.myDuration!.inMinutes.remainder(60));
    final seconds =
        strDigits(appointmentProvider.myDuration!.inSeconds.remainder(60));
    return Scaffold(
      floatingActionButton: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.appointmentModel.appointmentStatus ==
                FirebaseUtils.progress)
              // if (widget.appointmentModel.appointmentStatus ==
              //     FirebaseUtils.completed &&
              //     widget.appointmentModel.isReviewGivenByDietitian == false)
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: InkWell(
                  onTap: () async {
                    if (DateTime.now().isAfter(
                        widget.appointmentModel.combineDateTime!.toDate())) {
                      toNext(
                          context: context,
                          widget: ZegoSimpleJoinVideoCallPage(
                            dietitanID:
                                widget.appointmentModel.dietitianId.toString(),
                            myUserID:
                                widget.appointmentModel.patientId.toString(),
                            callID:
                                widget.appointmentModel.patientId.toString(),
                          ));
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppColors.whitecolor,
                              title: Text(
                                "you are early here for appointment",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w600),
                              ),
                              content: Text(
                                "Appointment will begin on  your specified time",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 15,
                                    color: AppColors.blackcolor,
                                    overflow: TextOverflow.visible,
                                    fontWeight: FontWeight.w400),
                              ),
                              actions: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: AppColors.appcolor),
                                    child: Center(
                                      child: Text(
                                        "ok",
                                        style: fontW5S12(context)!.copyWith(
                                            fontSize: 16,
                                            color: AppColors.whitecolor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    }

                    // toNext(
                    //     context: context,
                    //     widget: HomeSignalling(
                    //       dietitanID: appointmentModel.dietitianId.toString(),
                    //       myUserID: appointmentModel.patientId.toString(),
                    //     ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.appcolor,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    height: 60,
                    child: Center(
                      child: Text(
                        "Join Video",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 16,
                            color: AppColors.whitecolor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            if (widget.appointmentModel.appointmentStatus ==
                    FirebaseUtils.completed &&
                widget.appointmentModel.isReviewGivenByPatient == false)
              Padding(
                padding: const EdgeInsets.only(left: 29),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          toNext(
                              context: context,
                              widget: GiveReviewScreen(
                                appointmentModelNew: widget.appointmentModel,
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.appcolor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          height: 60,
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Give Review",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 16,
                                    color: AppColors.whitecolor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.whitecolor,
        elevation: 4,
        centerTitle: true,
        title: Text(
          "Appointment Details",
          style: fontW5S12(context)!.copyWith(
              fontSize: 16,
              color: AppColors.blackcolor,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.maybePop(context);
              appointmentProvider.stopTimer();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.blackcolor,
            )),
        actions: [
          IconButton(
              onPressed: () {
                if (DateTime.now().isAfter(
                    widget.appointmentModel.combineDateTime!.toDate())) {
                  toNext(
                      context: context,
                      widget: MessagesView(
                        name: widget.appointmentModel.dietitianName.toString(),
                        myID: getUserID(),
                        image: widget.appointmentModel.dietitianProfilePic
                            .toString(),
                        receiverID:
                            widget.appointmentModel.dietitianId.toString(),
                      ));
                  // toNext(
                  //     context: context,
                  //     widget: ZegoSimpleJoinVideoCallPage(
                  //       dietitanID:
                  //       widget.appointmentModel.dietitianId.toString(),
                  //       myUserID:
                  //       widget.appointmentModel.patientId.toString(),
                  //       callID: widget.appointmentModel.patientId.toString(),
                  //     ));
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.whitecolor,
                          title: Text(
                            "you are early here for message",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 14,
                                color: AppColors.blackcolor,
                                fontWeight: FontWeight.w600),
                          ),
                          content: Text(
                            "Message option will open on  your specified appointment time",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 15,
                                color: AppColors.blackcolor,
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.w400),
                          ),
                          actions: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: AppColors.appcolor),
                                child: Center(
                                  child: Text(
                                    "ok",
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 16,
                                        color: AppColors.whitecolor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      });
                }
              },
              icon: const Icon(
                Icons.chat,
                color: AppColors.appcolor,
              )),
          const SizedBox(
            width: 5,
          ),
          InkWell(
              onTap: () {
                toNext(
                    context: context,
                    widget: MedicalRecordListScreen(
                      appointmentModel: widget.appointmentModel,
                    ));
              },
              child: Image.asset(
                Res.medicaladd,
                height: 23,
                width: 23,
              )),
          const SizedBox(
            width: 12,
          )

          // PopupMenuButton(
          //
          //     // enabled: true,
          //     icon: const Icon(
          //       Icons.more_vert_outlined,
          //       color: AppColors.appcolor,
          //     ),
          //     onSelected: (select) async {
          //       print("print");
          //       if (select == 0) {
          //         await Future.delayed(const Duration(milliseconds: 10));
          //         //  toNext(context: context, widget: HomeSignalling());
          //         //    print("hello");
          //       }
          //     },
          //
          //     // icon: IconButton(
          //     //     onPressed: () {}, icon: Icon(Icons.more_vert_outlined,color: AppColors.appcolor,)),
          //     color: AppColors.whitecolor,
          //     itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          //           PopupMenuItem(
          //             enabled: false,
          //             value: 0,
          //             // onTap: () async {
          //             //   //  print("soap tapped");
          //             //   await Future.delayed(const Duration(milliseconds: 10));
          //             //   toNext(context: context, widget: HomeSignalling());
          //             // },
          //             child: Text(
          //               "Soap Notes",
          //               style: fontW5S12(context)!.copyWith(
          //                   fontSize: 14,
          //                   color: AppColors.blackcolor,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //           PopupMenuItem(
          //             value: 1,
          //             // onTap: (){
          //             //   toNext(context: context, widget: AddSoapNote());
          //             // },
          //             child: Text(
          //               "Meal Plans",
          //               style: fontW5S12(context)!.copyWith(
          //                   fontSize: 14,
          //                   color: AppColors.blackcolor,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //           PopupMenuItem(
          //             value: 2,
          //             // onTap: (){
          //             //   toNext(context: context, widget: AddSoapNote());
          //             // },
          //
          //             child: Text(
          //               "Care Plan",
          //               style: fontW5S12(context)!.copyWith(
          //                   fontSize: 14,
          //                   color: AppColors.blackcolor,
          //                   fontWeight: FontWeight.w500),
          //             ),
          //           ),
          //         ])
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          // Text(widget.appointmentModel.combineDateTime!
          //     .toDate()
          //     .subtract(Duration(
          //         days: DateTime.now().day,
          //         hours: DateTime.now().hour,
          //         minutes: DateTime.now().minute,
          //         seconds: DateTime.now().second,
          //         milliseconds: 0,
          //         microseconds: 0))
          //     .day
          //     .toString()),
          // Text(widget.appointmentModel.combineDateTime!
          //     .toDate()
          //     .subtract(Duration(
          //         days: DateTime.now().day,
          //         hours: DateTime.now().hour,
          //         minutes: DateTime.now().minute,
          //         seconds: DateTime.now().second,
          //         milliseconds: 0,
          //         microseconds: 0))
          //     .hour
          //     .toString()),
          // Text(widget.appointmentModel.combineDateTime!
          //     .toDate()
          //     .subtract(Duration(
          //         days: DateTime.now().day,
          //         hours: DateTime.now().hour,
          //         minutes: DateTime.now().minute,
          //         seconds: DateTime.now().second,
          //         milliseconds: 0,
          //         microseconds: 0))
          //     .minute
          //     .toString()),
          // Text(widget.appointmentModel.combineDateTime!
          //     .toDate()
          //     .subtract(Duration(
          //         days: DateTime.now().day,
          //         hours: DateTime.now().hour,
          //         minutes: DateTime.now().minute,
          //         seconds: DateTime.now().second,
          //         milliseconds: 0,
          //         microseconds: 0))
          //     .second
          //     .toString()),

          // Text(
          //   '$days : $hours : $minutes : $seconds',
          //   style: const TextStyle(
          //       fontWeight: FontWeight.bold, color: Colors.black, fontSize: 32),
          // ),r
          // ElevatedButton(
          //   onPressed: appointmentProvider.startTimer,
          //   child: const Text(
          //     'Start',
          //     style: TextStyle(
          //       fontSize: 30,
          //     ),
          //   ),
          // ),
          DateTime.now()
                  .isBefore(widget.appointmentModel.combineDateTime!.toDate())
              ? Text(
                  "Appointment will begin in : ",
                  style: fontW5S12(context)!.copyWith(
                      fontSize: 16,
                      color: AppColors.blackcolor,
                      fontWeight: FontWeight.w600),
                )
              : Text(
                  "",
                  style: fontW5S12(context)!.copyWith(
                      fontSize: 1,
                      color: AppColors.redcolor,
                      fontWeight: FontWeight.w600),
                ),
          const SizedBox(
            height: 10,
          ),
          if (widget.appointmentModel.appointmentStatus ==
              FirebaseUtils.progress)
            DateTime.now()
                    .isBefore(widget.appointmentModel.combineDateTime!.toDate())
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              days,
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 20,
                                  color: AppColors.blackcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Days",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.appcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              hours,
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 20,
                                  color: AppColors.blackcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Hours",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.appcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              minutes,
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 20,
                                  color: AppColors.blackcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Minutes",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.appcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              seconds,
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 20,
                                  color: AppColors.blackcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Seconds",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.appcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "00",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 20,
                                  color: AppColors.redcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Days",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.appcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "00",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 20,
                                  color: AppColors.redcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Hours",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.appcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "00",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 20,
                                  color: AppColors.redcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Minutes",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.appcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "00",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 20,
                                  color: AppColors.redcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Seconds",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.appcolor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          // Align(
          //   alignment: Alignment.center,
          //   child: StreamBuilder<int>(
          //       stream: timmer.rawTime,
          //       initialData: 0,
          //       builder: (contxt, snap) {
          //         //
          //         final displayTime = StopWatchTimer.getDisplayTime(
          //           snap.data ?? 0,
          //           minute: true,
          //           second: true,
          //           hours: true,
          //           milliSecond: false,
          //         );
          //         return Text(
          //           displayTime,
          //           textAlign: TextAlign.center,
          //           style: fontW5S12(context)!
          //               .copyWith(color: AppColors.blackcolor),
          //         );
          //       }),
          // ),
          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Appointment DateTime",
                  style: fontW5S12(context)!.copyWith(
                      fontSize: 13,
                      color: AppColors.blackcolor,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.appointmentModel.combineDateTime!
                      .toDate()
                      .format(DateTimeFormats.american)
                      .toString()
                      .replaceAll("12:00 am", ""),
                  style: fontW5S12(context)!.copyWith(
                      fontSize: 13,
                      color: AppColors.blackcolor.withOpacity(0.6),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              height: 150,
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                    side:
                        const BorderSide(width: 2, color: AppColors.appcolor)),
                color: AppColors.lightwhitecolor,
                elevation: 4,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.appointmentModel.payementPlansModel!.visitType
                          .toString(),
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 17,
                          color: AppColors.blackcolor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 15,
                                color: AppColors.blackcolor.withOpacity(0.6),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "\$${widget.appointmentModel.payementPlansModel!.visitPrice}",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 15,
                                color: AppColors.appcolor.withOpacity(0.9),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Time Duration",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 15,
                                color: AppColors.blackcolor.withOpacity(0.6),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.appointmentModel.payementPlansModel!
                                        .timeDuration ==
                                    null
                                ? "60"
                                : "${widget.appointmentModel.payementPlansModel!.timeDuration} Minutes",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 15,
                                color: AppColors.appcolor.withOpacity(0.9),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
