import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saluswell_patient_updated/src/apppointmentsSection/screens/selectAppointmentPaymentPlan.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/helperFunctions/showsnackbar.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';
import '../../authenticationsection/services/userServices.dart';
import '../providers/appointmentProvider.dart';
import '../providers/timeslot_provider.dart';
import '../services/appointmentServices.dart';
import '../widgets/timeslot_grid.dart';

class CreateAppointmentScreen extends StatefulWidget {
  final UserModelDietitian? userDietitanModeluser;

  CreateAppointmentScreen({Key? key, required this.userDietitanModeluser})
      : super(key: key);

  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  AppointmentServices appointmentServices = AppointmentServices();
  UserServices userServices = UserServices();

  @override
  void initState() {
    context.read<TimeSlotProvider>().fetchDietitianAvailability(
        widget.userDietitanModeluser!.userId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppointmentProvider, TimeSlotProvider>(
        builder: (context, appointmentProvider, timeSlotProvider, __) {
      return Scaffold(
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: InkWell(
                  onTap: () {
                    if (appointmentProvider.datePickerController.selectedDate ==
                        null) {
                      showSnackBarMessage(
                          backgroundcolor: AppColors.redcolor,
                          context: context,
                          content: "Please Select Date of appointment");
                    } else if (timeSlotProvider.getSelectedSlots().isEmpty) {
                      showSnackBarMessage(
                          backgroundcolor: AppColors.redcolor,
                          context: context,
                          content: "Please Select time Slot to continue");
                    } else if (timeSlotProvider.getSelectedSlots().length > 1) {
                      showSnackBarMessage(
                          backgroundcolor: AppColors.redcolor,
                          context: context,
                          content: "You Can Select only 1 slot at a time");
                    } else {
                      //  appointmentProvider.getDateTimeandSetDateTimeCombine(date, time);
                      toNext(
                          context: context,
                          widget: SelectAppointmentPaymentPlan(
                            userModelDietitian: widget.userDietitanModeluser!,
                          ));
                      // toNext(
                      //     context: context,
                      //     widget: ConfirmAppointment(
                      //         userDietitanModelusers:
                      //             widget.userDietitanModeluser));
                    }
                  },
                  child: Container(
                    height: 60,
                    color: AppColors.whitecolor,
                    child: Card(
                      color: AppColors.appcolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      child: Center(
                        child: Text(
                          "Confirm Slot",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 16,
                              color: AppColors.whitecolor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          appBar: AppBar(
            elevation: 3,
            backgroundColor: AppColors.whitecolor,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.blackcolor,
              ),
            ),
            title: Text(
              "Select DateTime",
              style: fontW5S12(context)!.copyWith(
                  fontSize: 16,
                  color: AppColors.blackcolor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please Select Date of Appointment",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 15,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  color: AppColors.whitecolor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SfDateRangePicker(
                      headerStyle: DateRangePickerHeaderStyle(
                          backgroundColor: AppColors.appcolor.withOpacity(0.9),
                          textAlign: TextAlign.center,
                          textStyle: fontW4S12(context)!.copyWith(
                              fontSize: 17, color: AppColors.whitecolor)),
                      headerHeight: 50,

                      controller: appointmentProvider.datePickerController,
                      enablePastDates: false,
                      enableMultiView: false,
                      confirmText: "ok",

                      // showActionButtons: true,

                      showNavigationArrow: true,
                      minDate: DateTime.now(),
                      viewSpacing: 20,

                      // monthViewSettings:
                      //     DateRangePickerMonthViewSettings(firstDayOfWeek: 1),

                      onSelectionChanged:
                          appointmentProvider.onSelectionChanged,
                      navigationDirection:
                          DateRangePickerNavigationDirection.horizontal,
                      selectionMode: DateRangePickerSelectionMode.single,
                      startRangeSelectionColor: AppColors.appcolor,
                      endRangeSelectionColor: AppColors.appcolor,
                      todayHighlightColor: AppColors.appcolor,

                      //showActionButtons: true,
                      //allowViewNavigation: false,
                      view: DateRangePickerView.month,
                      selectionRadius: 17,
                      rangeSelectionColor: AppColors.appcolor.withOpacity(0.3),
                      selectionShape: DateRangePickerSelectionShape.rectangle,
                      selectionColor: AppColors.appcolor,
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                        // showWeekNumber: true,
                        enableSwipeSelection: false,
                        weekNumberStyle: DateRangePickerWeekNumberStyle(
                            textStyle: TextStyle(color: AppColors.redcolor)),
                        firstDayOfWeek: 1,
                        showTrailingAndLeadingDates: true,
                        dayFormat: 'EE',
                        viewHeaderStyle: DateRangePickerViewHeaderStyle(

                            //    backgroundColor: Color(0xFF7fcd91),
                            textStyle: TextStyle(
                                color: AppColors.blackcolor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 5)),

                        //  numberOfWeeksInView: 1
                      ),
                      toggleDaySelection: true,

                      //showTodayButton: true,
                      //   showActionButtons: ,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Text(appointmentProvider.timeSlotModel == null
              //     ? " value"
              //     : appointmentProvider.timeSlotModel!.startTime!
              //         .toDate()
              //         .toString()),

              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appointmentProvider.datePickerController.selectedDate ==
                              null
                          ? "Please Select Date"
                          : appointmentProvider
                              .datePickerController.selectedDate!
                              .format(DateTimeFormats.american)
                              .toString()
                              .replaceAll("12:00 am", ""),
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 14,
                          color: AppColors.blackcolor.withOpacity(0.6),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (timeSlotProvider.morningSlots.isNotEmpty) ...[
                TimeSlotGrid(
                  title: 'Morning',
                  slots: Provider.of<TimeSlotProvider>(context).morningSlots,
                ),
              ],
              if (timeSlotProvider.afternoonSlots.isNotEmpty) ...[
                TimeSlotGrid(
                  title: 'Afternoon',
                  slots: Provider.of<TimeSlotProvider>(context).afternoonSlots,
                ),
              ],
              if (timeSlotProvider.eveningSlots.isNotEmpty) ...[
                TimeSlotGrid(
                  title: 'Evening',
                  slots: Provider.of<TimeSlotProvider>(context).eveningSlots,
                ),
              ],

              if (timeSlotProvider.nightSlots.isNotEmpty) ...[
                TimeSlotGrid(
                  title: 'Night',
                  slots: Provider.of<TimeSlotProvider>(context).nightSlots,
                ),
              ],

              // ? Text("No Slots Available")
              // :
              // StreamProvider.value(
              //     value: userServices.fetchUserRecord(
              //       widget.userDietitanModeluser!.userId.toString(),
              //     ),
              //     initialData: UserModel(),
              //     builder: (context, child) {
              //       UserModel model = context.watch<UserModel>();
              //       return model.userId == null
              //           ? Center(child: const CircularProgressIndicator())
              //           : model.availabletimeSlots == null
              //               ? Center(
              //                   child: Padding(
              //                   padding: const EdgeInsets.only(top: 80),
              //                   child: Text(
              //                     "No Slots Available",
              //                     style: TextStyle(
              //                         fontSize: 13,
              //                         fontWeight: FontWeight.w600),
              //                   ),
              //                 ))
              //               : Container(
              //                   height: 70,
              //                   child: ListView.builder(
              //                       itemCount: model.availabletimeSlots!.length,
              //                       shrinkWrap: true,
              //                       scrollDirection: Axis.horizontal,
              //                       padding: EdgeInsets.only(top: 5),
              //                       itemBuilder: ((context, index) {
              //                         return Padding(
              //                             padding: EdgeInsets.only(bottom: 12),
              //                             child: AccessoriesWidget(
              //                               onTap: (value) {
              //                                 appointmentProvider
              //                                     .addOrRemoveAvailableTimeSlots(
              //                                         context, value);
              //                                 appointmentProvider.timeslot =
              //                                     model.availabletimeSlots![
              //                                         index];
              //                                 print(DateTime.parse(
              //                                         model.availabletimeSlots![
              //                                             index])
              //                                     .toString());
              //                                 // Text(DateTime.parse(model
              //                                 //         .availabletimeSlots![index])
              //                                 //     .toString());
              //                                 //   print(time);
              //                                 // appointmentProvider.startingSelectedTime=
              //                               },
              //                               text: model
              //                                   .availabletimeSlots![index],
              //                               //  color: AppColors.appcolor,
              //                               color: appointmentProvider
              //                                       .availableSlots
              //                                       .contains(model
              //                                               .availabletimeSlots![
              //                                           index])
              //                                   ? AppColors.appcolor
              //                                   : Colors.grey,
              //                             ));
              //                       })),
              //                 );
              //     }),

              SizedBox(
                height: 30,
              ),
              // Text(
              //   "if you want to book a slot of 30 minutes selecy 1 slot and if  you want to book slot of 60 minutes selecy 2 slots ",
              //   style: fontW5S12(context)!.copyWith(
              //       fontSize: 15,
              //       color: AppColors.blackcolor,
              //       fontWeight: FontWeight.w500),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 12),
              //   child: RichText(
              //       textAlign: TextAlign.center,
              //       text: TextSpan(
              //           style: fontW5S12(context)!.copyWith(
              //               fontSize: 13,
              //               color: AppColors.blackcolor
              //                   .withOpacity(0.7),
              //               fontWeight: FontWeight.w500),
              //           text:
              //               "if you want to book a slot of 30 minutes select 1 slot and if  you want to book slot of 60 minutes select 2 slots ")),
              // ),

              // Consumer<AppointmentProvider>(
              //     builder: (context, appointmentProvider, __) {
              //       return Wrap(
              //         direction: Axis.horizontal,
              //         //  runAlignment: WrapAlignment.end,
              //         children: [
              //
              //
              //           "11:30 - 12:00 AM",
              //         ]
              //             .map((e) => AccessoriesWidget(
              //           onTap: (value) {
              //             appointmentProvider.addOrRemoveAvailableTimeSlots(
              //                 context, value);
              //           },
              //           text: e,
              //           color:
              //           appointmentProvider.availableSlots.contains(e)
              //               ? AppColors.appcolor
              //               : Colors.grey,
              //         ))
              //             .toList(),
              //       );
              //    }),
              // StreamProvider.value(
              //     value: userServices.fetchUserRecord(
              //       widget.userDietitanModeluser!.userId.toString(),
              //     ),
              //     initialData: UserModel(),
              //     builder: (context, child) {
              //       UserModel model = context.watch<UserModel>();
              //       return model.userId!.isEmpty
              //           ? Padding(
              //               padding: const EdgeInsets.only(top: 20),
              //               child: Column(
              //                 children: [
              //                   //   Lottie.
              //                   // Lottie.network(
              //                   //   // height: 50,
              //                   //   // width: 50,
              //                   //     'https://assets9.lottiefiles.com/temporary_files/PH5YkW.json'),
              //                   Padding(
              //                     padding: const EdgeInsets.only(
              //                         right: 20, top: 40),
              //                     child: Text(
              //                       "No Slots Available",
              //                       style: fontW5S12(context)!.copyWith(
              //                           fontSize: 14,
              //                           color:
              //                               AppColors.lightdarktextcolor,
              //                           fontWeight: FontWeight.w700),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             )
              //           // ? const Center(
              //           //     child: Padding(
              //           //     padding: EdgeInsets.only(top: 100),
              //           //     child: Text(
              //           //         "No Timeslot Found to this Date! \n + Add Slot Time to this date",
              //           //         style: TextStyle(
              //           //             // fontFamily: 'Gilroy',
              //           //             color: AppColors.blackcolor,
              //           //             // decoration: TextDecoration.underline,
              //           //             fontWeight: FontWeight.w700,
              //           //             fontFamily: 'Axiforma',
              //           //             fontSize: 13)),
              //           //   ))
              //           : model.userId == null
              //               ? const SpinKitPouringHourGlass(
              //                   size: 30,
              //                   color: AppColors.appcolor,
              //                 )
              //               : Expanded(
              //                   flex: 4,
              //                   child: ListView.builder(
              //                       itemCount:
              //                           model.availabletimeSlots!.length,
              //                       shrinkWrap: true,
              //                       scrollDirection: Axis.horizontal,
              //                       padding: EdgeInsets.only(top: 5),
              //                       itemBuilder: ((context, index) {
              //                         return Padding(
              //                             padding:
              //                                 EdgeInsets.only(bottom: 12),
              //                             child: InkWell(
              //                                 onTap: () {
              //                                   setState(() {
              //                                     appointmentProvider
              //                                             .selectedIndex =
              //                                         index;
              //
              //                                     // appointmentProvider
              //                                     //         .timeSlotModel =
              //                                     //     timeSlotList[index];
              //                                   });
              //                                 },
              //                                 child: AccessoriesWidget(
              //                                   onTap: (value) {
              //                                     appointmentProvider
              //                                         .addOrRemoveAvailableTimeSlots(
              //                                             context, value);
              //                                   },
              //                                   text: "12",
              //                                   // color: appointmentProvider
              //                                   //         .availableSlots
              //                                   //         .contains(12)
              //                                   //     ? AppColors.appcolor
              //                                   //     : Colors.grey,
              //                                 )));
              //                       })),
              //                 );
              //     }),
              const SizedBox(
                height: 80,
              )
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       "Please Select Time of Appointment",
              //       style: fontW5S12(context)!.copyWith(
              //           fontSize: 15,
              //           color: AppColors.blackcolor,
              //           fontWeight: FontWeight.w500),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // DateTimeTileWidget(
              //   selectedTime: appointmentProvider.startingSelectedTime == null
              //       ? "Please Select Appointment Time"
              //       : appointmentProvider.startingSelectedTime!.format(context),
              //   selectTime: () {
              //     _selectStartingTime(context, appointmentProvider);
              //   },
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       "Review Appointment Date & Time",
              //       style: fontW5S12(context)!.copyWith(
              //           fontSize: 15,
              //           color: AppColors.blackcolor,
              //           fontWeight: FontWeight.w500),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "DateTime",
              //         style: fontW5S12(context)!.copyWith(
              //             fontSize: 14,
              //             color: AppColors.blackcolor,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       Text(
              //         appointmentProvider.datePickerController.selectedDate ==
              //                     null ||
              //                 appointmentProvider.startingSelectedTime == null
              //             ? "Please Select Date"
              //             : appointmentProvider.combineDateTime!
              //                 .format(DateTimeFormats.american)
              //                 .toString(),
              //         style: fontW5S12(context)!.copyWith(
              //             fontSize: 14,
              //             color: AppColors.blackcolor.withOpacity(0.6),
              //             fontWeight: FontWeight.w500),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          )));
    });
  }
}

_selectStartingTime(
    BuildContext context, AppointmentProvider carProvider) async {
  final TimeOfDay? timeOfDay = await showTimePicker(
    context: context,
    builder: (context, child) {
      return Theme(
          data: ThemeData(
            dialogBackgroundColor: AppColors.whitecolor,
            colorScheme: ColorScheme.dark(
              primary: AppColors.whitecolor,
              onPrimary: secondryColor(context),
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
            ),
          ),
          child: child!);
    },
    initialTime: const TimeOfDay(hour: 12, minute: 00),
    initialEntryMode: TimePickerEntryMode.dial,
  );
  if (timeOfDay != null && timeOfDay != carProvider.startingSelectedTime) {
    carProvider.updateStartingTime(timeOfDay);
  }
}
