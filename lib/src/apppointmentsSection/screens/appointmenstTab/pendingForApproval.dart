import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/utils/firebaseUtils.dart';
import '../../models/appointmentModel.dart';
import '../../services/appointmentServices.dart';
import '../../widgets/pendingForApprovalTileWidget.dart';

class PendingForApprovalAppointmentsTab extends StatefulWidget {
  const PendingForApprovalAppointmentsTab({Key? key}) : super(key: key);

  @override
  State<PendingForApprovalAppointmentsTab> createState() =>
      _PendingForApprovalAppointmentsTabState();
}

class _PendingForApprovalAppointmentsTabState
    extends State<PendingForApprovalAppointmentsTab> {
  AppointmentServices appointmentServices = AppointmentServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            StreamProvider.value(
                value: appointmentServices
                    .streamAllAppointments(FirebaseUtils.pending),
                initialData: [AppointmentModel()],
                builder: (context, child) {
                  List<AppointmentModel> appointmentList =
                      context.watch<List<AppointmentModel>>();
                  return appointmentList.isEmpty
                      ? Text("No data found")
                      :
                      //  const SpinKitPouringHourGlass(
                      //     size: 30,
                      //     color: AppColors.appcolor,
                      //   )
                      // : appointmentList.isEmpty
                      //     ? const Center(
                      //         child: Padding(
                      //         padding: EdgeInsets.only(top: 90),
                      //         child: Text("No Pending Appointments found!",
                      //             style: TextStyle(
                      //                 // fontFamily: 'Gilroy',
                      //                 color: AppColors.blackcolor,
                      //                 // decoration: TextDecoration.underline,
                      //                 fontWeight: FontWeight.w700,
                      //                 fontFamily: 'Axiforma',
                      //                 fontSize: 13)),
                      //       ))
                      Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.only(),
                              physics: const ScrollPhysics(),

                              // physics:
                              //     const NeverScrollableScrollPhysics(),
                              itemCount: appointmentList.length,
                              itemBuilder: (_, i) {
                                //  print(dietitansList[i]..toString());

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 12),
                                  child:
                                      PendingForApprovalAppointmentsTileWidget(
                                    appointmentModel: appointmentList[i],
                                  ),
                                );
                              }));
                })
          ],
        ),
      ),
    );
  }
}
