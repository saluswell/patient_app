import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/appcolors.dart';
import '../models/timeslot_model.dart';
import '../providers/timeslot_provider.dart';

class TimeSlotGrid extends StatelessWidget {
  final String title;
  final List<TimeSlot> slots;

  TimeSlotGrid({required this.title, required this.slots});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: AppColors.blackcolor),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
            ),
            itemCount: slots.length,
            itemBuilder: (context, index) {
              TimeSlot slot = slots[index];

              return GestureDetector(
                onTap: () =>
                    Provider.of<TimeSlotProvider>(context, listen: false)
                        .toggleSlotSelection(slot),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.darkAppColor,
                        width: 1.0,
                      ),
                      color: slot.isSelected
                          ? AppColors.darkAppColor
                          : AppColors.whitecolor,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(

                          //'${DateFormat.jm().format(time)}',
                          '${DateFormat('h:mm a').format(slot.startTime)} - ${DateFormat('h:mm a').format(slot.endTime)}',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontSize: 10,
                                  color: slot.isSelected
                                      ? AppColors.whitecolor
                                      : AppColors.blackcolor,
                                  fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              );

              // return InkWell(
              //   onTap: () => Provider.of<TimeSlotProvider>(context, listen: false)
              //       .toggleSlotSelection(slot),
              //   child: Card(
              //     color: slot.isSelected ? Colors.green : Colors.white,
              //     child: Center(
              //       child: Text(
              //         '${DateFormat('h:mm a').format(slot.startTime)} - ${DateFormat('h:mm a').format(slot.endTime)}',
              //         style: TextStyle(fontSize: 16),
              //       ),
              //     ),
              //   ),
              // );
            },
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     List<TimeSlot> selectedSlots =
        //         Provider.of<TimeSlotProvider>(context, listen: false)
        //             .getSelectedSlots();
        //     // Send selectedSlots to Firestore through API call
        //     print('Selected Slots: $selectedSlots');
        //   },
        //   child: Text('Submit Selected Slots'),
        // ),
      ],
    );
  }
}
