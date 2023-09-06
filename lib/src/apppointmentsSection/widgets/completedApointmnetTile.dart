import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/cacheNetworkImageWidget.dart';
import '../models/appointmentModel.dart';
import '../providers/appointmentProvider.dart';
import '../screens/appointment_details_screen.dart';

class CompletedAppointmentsTileWidget extends StatefulWidget {
  final AppointmentModel appointmentModel;

  const CompletedAppointmentsTileWidget({
    Key? key,
    required this.appointmentModel,
  }) : super(key: key);

  @override
  State<CompletedAppointmentsTileWidget> createState() =>
      _CompletedAppointmentsTileWidgetState();
}

class _CompletedAppointmentsTileWidgetState
    extends State<CompletedAppointmentsTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CacheNetworkImageWidget(
                height: 52,
                width: 52,
                imgUrl: widget.appointmentModel.dietitianProfilePic.toString(),
                radius: 7),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.appointmentModel.dietitianName}",
                  style: fontW5S12(context)!.copyWith(
                      fontSize: 14,
                      color: AppColors.blackcolor,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      widget.appointmentModel.appointmentDateTime!
                          .toDate()
                          .format(DateTimeFormats.american)
                          .toString()
                          .replaceAll("12:00 am", ""),
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 13,
                          color: AppColors.lightdarktextcolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  DateFormat('h:mm a').format(
                      widget.appointmentModel.combineDateTime!.toDate()),
                  // DateTime.parse(widget.appointmentModel.timeslot.toString())
                  //     .format(DateTimeFormats.american)
                  //     .toString()
                  //     .substring(17)
                  //     .toUpperCase()
                  //     .toString(),
                  style: fontW5S12(context)!.copyWith(
                      fontSize: 13,
                      color: AppColors.appcolor,
                      fontWeight: FontWeight.w500),
                ),
                // Text(
                //   "${appointmentModel.from!.toDate().format(DateTimeFormats.american).toString().replaceAll("January 1, 2022", "")}  - ${appointmentModel.to!.toDate().format(DateTimeFormats.american).toString().replaceAll("January 1, 2022", "")}",
                //   style: fontW5S12(context)!.copyWith(
                //       fontSize: 13,
                //       color: AppColors.appcolor,
                //       fontWeight: FontWeight.w500),
                // ),
              ],
            )
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 7,
            ),
            Consumer<AppointmentProvider>(
                builder: (context, appointmentProvider, __) {
              return InkWell(
                onTap: () {
                  //     appointmentProvider.startTimer();
                  setState(() {
                    appointmentProvider.daysvar = widget
                        .appointmentModel.combineDateTime!
                        .toDate()
                        .subtract(Duration(
                            days: DateTime.now().day,
                            hours: DateTime.now().hour,
                            minutes: DateTime.now().minute,
                            seconds: DateTime.now().second,
                            milliseconds: 0,
                            microseconds: 0))
                        .day;

                    appointmentProvider.hoursvar = widget
                        .appointmentModel.combineDateTime!
                        .toDate()
                        .subtract(Duration(
                            days: DateTime.now().day,
                            hours: DateTime.now().hour,
                            minutes: DateTime.now().minute,
                            seconds: DateTime.now().second,
                            milliseconds: 0,
                            microseconds: 0))
                        .hour;

                    appointmentProvider.minutesvar = widget
                        .appointmentModel.combineDateTime!
                        .toDate()
                        .subtract(Duration(
                            days: DateTime.now().day,
                            hours: DateTime.now().hour,
                            minutes: DateTime.now().minute,
                            seconds: DateTime.now().second,
                            milliseconds: 0,
                            microseconds: 0))
                        .minute;

                    appointmentProvider.secondsvar = widget
                        .appointmentModel.combineDateTime!
                        .toDate()
                        .subtract(Duration(
                            days: DateTime.now().day,
                            hours: DateTime.now().hour,
                            minutes: DateTime.now().minute,
                            seconds: DateTime.now().second,
                            milliseconds: 0,
                            microseconds: 0))
                        .second;
                  });

                  toNext(
                      context: context,
                      widget: AppointmentDetailsScreen(
                        appointmentModel: widget.appointmentModel,
                      ));
                },
                child: Container(
                  height: 40,
                  width: 95,
                  decoration: BoxDecoration(
                      color: AppColors.appcolor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      "View Details",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 12,
                          color: AppColors.whitecolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              );
            })
          ],
        )
      ],
    );
  }
}
