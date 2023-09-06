
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/button_widget.dart';
import '../providers/appointmentProvider.dart';
import '../widgets/accessories_widget.dart';
import '../widgets/dateTimeTileWidget.dart';

class CreateAppointmentSlot extends StatefulWidget {
  const CreateAppointmentSlot({Key? key}) : super(key: key);

  @override
  State<CreateAppointmentSlot> createState() => _CreateAppointmentSlotState();
}

class _CreateAppointmentSlotState extends State<CreateAppointmentSlot> {
  

 

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, __) {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.appcolor,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create Slot",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 23,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.maybePop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 95,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: AppColors.redcolor.withOpacity(0.1)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.close,
                              size: 20,
                              color: AppColors.redcolor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Cancel",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.redcolor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Available Days",
                  style: fontW5S12(context)!.copyWith(
                      fontSize: 15,
                      color: AppColors.blackcolor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Consumer<AppointmentProvider>(
                  builder: (context, appointmentProvider, __) {
                return Wrap(
                  direction: Axis.horizontal,
                  //  runAlignment: WrapAlignment.end,
                  children: [
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday",
                    "Sunday"
                  ]
                      .map((e) => AccessoriesWidget(
                            onTap: (value) {
                              appointmentProvider.addOrRemoveAccessory(
                                  context, value);
                            },
                            text: e,
                            color: appointmentProvider.acessoriesList
                                    .contains(e)
                                ? AppColors.appcolor
                                : AppColors.lightdarktextcolor.withOpacity(0.7),
                          ))
                      .toList(),
                );
              }),
            ),
            SizedBox(
              height: 25,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Available Time",
                  style: fontW5S12(context)!.copyWith(
                      fontSize: 15,
                      color: AppColors.blackcolor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "From",
                  style: fontW5S12(context)!.copyWith(
                      fontSize: 12,
                      color: AppColors.blackcolor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            DateTimeTileWidget(
              selectedTime: appointmentProvider.startingSelectedTime == null
                  ? "Starting Time"
                  : appointmentProvider.startingSelectedTime
                      .toString()
                      .substring(10, 15),
              selectTime: () {
                _selectStartingTime(context, appointmentProvider);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "To",
                  style: fontW5S12(context)!.copyWith(
                      fontSize: 12,
                      color: AppColors.blackcolor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            DateTimeTileWidget(
              selectedTime: appointmentProvider.endingSelectedTime == null
                  ? "Ending Time"
                  : appointmentProvider.endingSelectedTime
                      .toString()
                      .substring(10, 15),
              selectTime: () {
                _selectEndingTime(context, appointmentProvider);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Spacer(),
            CommonButtonWidget(
                horizontalPadding: 8,
                backgroundcolor: AppColors.appcolor,
                text: "Create",
                textfont: 16,
                onTap: () {
                  // toNext(
                  //     context: context,
                  //     widget: PersonalInformationScreen());
                }),
            SizedBox(
              height: 15,
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Card(
            //     elevation: 4,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(13)),
            //     color: AppColors.whitecolor,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: SfDateRangePicker(
            //         headerStyle: DateRangePickerHeaderStyle(
            //             backgroundColor: AppColors.appcolor.withOpacity(0.9),
            //             textAlign: TextAlign.center,
            //             textStyle: fontW4S12(context)!
            //                 .copyWith(fontSize: 17, color: AppColors.whitecolor)),
            //         headerHeight: 50,
            //
            //         controller: _datePickerController,
            //         enablePastDates: false,
            //         enableMultiView: false,
            //
            //         showNavigationArrow: true,
            //         minDate: DateTime.now(),
            //         viewSpacing: 20,
            //
            //         // monthViewSettings:
            //         //     DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
            //         onSelectionChanged: _onSelectionChanged,
            //         navigationDirection:
            //             DateRangePickerNavigationDirection.horizontal,
            //         selectionMode: DateRangePickerSelectionMode.range,
            //         startRangeSelectionColor: AppColors.appcolor,
            //         endRangeSelectionColor: AppColors.appcolor,
            //         todayHighlightColor: AppColors.appcolor,
            //
            //         //showActionButtons: true,
            //         //allowViewNavigation: false,
            //         view: DateRangePickerView.month,
            //         selectionRadius: 17,
            //         rangeSelectionColor: AppColors.appcolor.withOpacity(0.3),
            //         selectionShape: DateRangePickerSelectionShape.rectangle,
            //         selectionColor: AppColors.appcolor,
            //         monthViewSettings: const DateRangePickerMonthViewSettings(
            //
            //           // showWeekNumber: true,
            //           enableSwipeSelection: false,
            //           weekNumberStyle: DateRangePickerWeekNumberStyle(
            //               textStyle: TextStyle(color: AppColors.redcolor)),
            //           firstDayOfWeek: 1,
            //           showTrailingAndLeadingDates: true,
            //           dayFormat: 'EE',
            //           viewHeaderStyle: DateRangePickerViewHeaderStyle(
            //
            //               //    backgroundColor: Color(0xFF7fcd91),
            //               textStyle: TextStyle(
            //                   color: AppColors.blackcolor,
            //                   fontWeight: FontWeight.w500,
            //                   fontSize: 14,
            //                   letterSpacing: 5)),
            //
            //           //  numberOfWeeksInView: 1
            //         ),
            //         toggleDaySelection: true,
            //
            //
            //         //showTodayButton: true,
            //         //   showActionButtons: ,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    });
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

_selectEndingTime(BuildContext context, AppointmentProvider carProvider) async {
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
  if (timeOfDay != null && timeOfDay != carProvider.endingSelectedTime) {
    carProvider.updateEndingTime(timeOfDay);
  }
}
}
