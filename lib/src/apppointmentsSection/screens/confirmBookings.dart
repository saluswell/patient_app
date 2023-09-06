import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:saluswell_patient_updated/src/apppointmentsSection/providers/timeslot_provider.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/textfield_widget.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';
import '../../authenticationsection/providers/savUserDetailsProvider.dart';
import '../../authenticationsection/widgets/accessories_widget.dart';
import '../providers/appointmentProvider.dart';

class ConfirmAppointment extends StatefulWidget {
  UserModelDietitian? userDietitanModelusers;

  ConfirmAppointment({Key? key, required this.userDietitanModelusers})
      : super(key: key);

  @override
  State<ConfirmAppointment> createState() => _ConfirmAppointmentState();
}

class _ConfirmAppointmentState extends State<ConfirmAppointment> {
  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<UserProvider>(context);
    return Consumer2<AppointmentProvider, TimeSlotProvider>(
        builder: (context, appointmentProvider, timeSlotProvider, __) {
      return LoadingOverlay(
        isLoading: appointmentProvider.isLoading,
        progressIndicator: const SpinKitPouringHourGlass(
          size: 30,
          color: AppColors.appcolor,
        ),
        child: Scaffold(
          floatingActionButton: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: InkWell(
                    onTap: () async {
                      await appointmentProvider
                          .getDateTimeandSetDateTimeCombine();
                      appointmentProvider.saveDietitianUserDetails(
                          widget.userDietitanModelusers);
                      await appointmentProvider.makePayment();
                      //   toNext(context: context, widget: ConfirmAppointment());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.appcolor,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      height: 60,
                      child: Center(
                        child: Text(
                          "Confirm & Pay",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 16,
                              color: AppColors.whitecolor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
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
              "Confirm Appointment",
              style: fontW5S12(context)!.copyWith(
                  fontSize: 16,
                  color: AppColors.blackcolor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Review Appointment Details",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 15,
                          color: AppColors.blackcolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Appointment Date",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 15,
                          color: AppColors.appcolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 14,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(appointmentProvider
                          .datePickerController.selectedDate!
                          .format(DateTimeFormats.american)
                          .replaceAll("12:00 am", "")),

                      // Text(
                      //   appointmentProvider.datePickerController.selectedDate ==
                      //           null
                      //       ? "Please Select Date"
                      //       : appointmentProvider.combineDateTime!
                      //           .format(DateTimeFormats.american)
                      //           .toString(),
                      //   style: fontW5S12(context)!.copyWith(
                      //       fontSize: 14,
                      //       color: AppColors.blackcolor.withOpacity(0.6),
                      //       fontWeight: FontWeight.w500),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Selected Time Slot",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 15,
                          color: AppColors.appcolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    // decoration: BoxDecoration(
                    //     border: Border.all(
                    //   width: 2,
                    // )),
                    height: 70,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: const BorderSide(
                              width: 1.5, color: AppColors.appcolor)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 60,
                                  child: ListView.builder(
                                      itemCount: timeSlotProvider
                                          .getSelectedSlots()
                                          .length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.only(top: 5),
                                      itemBuilder: ((context, index) {
                                        return Padding(
                                            padding: EdgeInsets.only(bottom: 0),
                                            child: AccessoriesWidget(
                                                onTap: (value) {
                                                  // appointmentProvider
                                                  //     .addOrRemoveAvailableTimeSlots(
                                                  //         context, value);
                                                },
                                                // text: DateFormat('h:mm a')
                                                //     .format(timeSlotProvider
                                                //         .getSelectedSlots()[
                                                //             index]
                                                //         .startTime),
                                                text: timeSlotProvider
                                                    .getSelectedSlots()[index]
                                                    .startTime
                                                    .toString(),
                                                //  color: AppColors.appcolor,
                                                color: AppColors.darkAppColor));
                                      })),
                                ),

                                // Row(
                                //   children: [
                                //     Text(
                                //       "From :",
                                //       style: fontW5S12(context)!.copyWith(
                                //           fontSize: 15,
                                //           color:
                                //               AppColors.blackcolor.withOpacity(0.7),
                                //           fontWeight: FontWeight.w500),
                                //     ),
                                //     Text(
                                //       appointmentProvider.timeSlotModel!.startTime!
                                //           .toDate()
                                //           .format(DateTimeFormats.american)
                                //           .replaceAll("January 1, 2022", ""),
                                //       style: fontW5S12(context)!.copyWith(
                                //           fontSize: 15,
                                //           color: AppColors.blackcolor,
                                //           fontWeight: FontWeight.w500),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: [
                                //     Text(
                                //       "To   :",
                                //       style: fontW5S12(context)!.copyWith(
                                //           fontSize: 15,
                                //           color:
                                //               AppColors.blackcolor.withOpacity(0.7),
                                //           fontWeight: FontWeight.w500),
                                //     ),
                                //     Text(
                                //       appointmentProvider.timeSlotModel!.endTime!
                                //           .toDate()
                                //           .format(DateTimeFormats.american)
                                //           .replaceAll("January 1, 2022", ""),
                                //       style: fontW5S12(context)!.copyWith(
                                //           fontSize: 15,
                                //           color: AppColors.blackcolor,
                                //           fontWeight: FontWeight.w500),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Patient Details",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 15,
                          color: AppColors.appcolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Patient Name",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 14,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(currentUser.getUserDetails()!.userName.toString()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gender",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 14,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text("Male"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextFieldWidget(
                      controller: appointmentProvider.patientNoteController,
                      textFieldHeight: 80,
                      toppadding: 12,
                      maxLengt: 150,
                      enabled: true,
                      maxlines: 4,
                      hintText: "Add any Note for Dietitian(Optional)",
                      textInputType: TextInputType.text),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Dietitian Details",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 15,
                          color: AppColors.appcolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dietitian Name",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 14,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(widget.userDietitanModelusers!.userName.toString()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gender",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 14,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text("Male"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Selected Payment Plan",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 15,
                          color: AppColors.appcolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
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
                              BorderSide(width: 2, color: AppColors.appcolor)),
                      color: AppColors.lightwhitecolor,
                      elevation: 4,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            appointmentProvider.payementPlansModelvar!.visitType
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
                                      color:
                                          AppColors.blackcolor.withOpacity(0.6),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "\$${appointmentProvider.payementPlansModelvar!.visitPrice}",
                                  style: fontW5S12(context)!.copyWith(
                                      fontSize: 15,
                                      color:
                                          AppColors.appcolor.withOpacity(0.9),
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
                                      color:
                                          AppColors.blackcolor.withOpacity(0.6),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${appointmentProvider.payementPlansModelvar!.timeDuration} Minutes",
                                  style: fontW5S12(context)!.copyWith(
                                      fontSize: 15,
                                      color:
                                          AppColors.appcolor.withOpacity(0.9),
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
                const SizedBox(
                  height: 14,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Appointment Fees",
                //         style: fontW5S12(context)!.copyWith(
                //             fontSize: 14,
                //             color: AppColors.blackcolor,
                //             fontWeight: FontWeight.w500),
                //       ),
                //       const Text("\$150"),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 14,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "SalusWell Fees",
                //         style: fontW5S12(context)!.copyWith(
                //             fontSize: 14,
                //             color: AppColors.blackcolor,
                //             fontWeight: FontWeight.w500),
                //       ),
                //       const Text("\$10"),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 14,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Total",
                //         style: fontW5S12(context)!.copyWith(
                //             fontSize: 14,
                //             color: AppColors.blackcolor,
                //             fontWeight: FontWeight.w500),
                //       ),
                //       const Text("\$200"),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
