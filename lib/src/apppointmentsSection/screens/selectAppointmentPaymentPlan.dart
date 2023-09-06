import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/helperFunctions/showsnackbar.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';
import '../models/paymentPlanModel.dart';
import '../providers/appointmentProvider.dart';
import '../services/appointmentServices.dart';
import '../widgets/paymentPlanWidget.dart';
import 'confirmBookings.dart';

class SelectAppointmentPaymentPlan extends StatefulWidget {
  final UserModelDietitian userModelDietitian;

  const SelectAppointmentPaymentPlan(
      {Key? key, required this.userModelDietitian})
      : super(key: key);

  @override
  State<SelectAppointmentPaymentPlan> createState() =>
      _SelectAppointmentPaymentPlanState();
}

class _SelectAppointmentPaymentPlanState
    extends State<SelectAppointmentPaymentPlan> {
  AppointmentServices appointmentServices = AppointmentServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Consumer<AppointmentProvider>(
                builder: (context, appointmentProvider, __) {
              return InkWell(
                onTap: () {
                  if (appointmentProvider.selectedIndexforPaymentPlan == null) {
                    showSnackBarMessage(
                        backgroundcolor: AppColors.redcolor,
                        context: context,
                        content: "Please Select Payment Plan  to continue");
                  } else {
                    toNext(
                        context: context,
                        widget: ConfirmAppointment(
                            userDietitanModelusers:
                                widget.userModelDietitian!));
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
                        "Confirm Payment Plan",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 16,
                            color: AppColors.whitecolor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              );
            }),
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
          "Select Payment Plan",
          style: fontW5S12(context)!.copyWith(
              fontSize: 16,
              color: AppColors.blackcolor,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            StreamProvider.value(
                value: appointmentServices.streamPaymentPlans(),
                initialData: [PayementPlansModel()],
                builder: (context, child) {
                  List<PayementPlansModel> paymentPlanList =
                      context.watch<List<PayementPlansModel>>();
                  return paymentPlanList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //   Lottie.
                              // Lottie.network(
                              //   // height: 50,
                              //   // width: 50,
                              //     'https://assets9.lottiefiles.com/temporary_files/PH5YkW.json'),
                              Center(
                                child: Text(
                                  "No Payment Plans Found!",
                                  style: fontW5S12(context)!.copyWith(
                                      fontSize: 14,
                                      color: AppColors.lightdarktextcolor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        )
                      : paymentPlanList[0].visitPrice == null
                          ? const SpinKitPouringHourGlass(
                              size: 30,
                              color: AppColors.appcolor,
                            )
                          : Expanded(
                              // flex: 5,
                              child: ListView.builder(
                                  itemCount: paymentPlanList.length,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 5),
                                  itemBuilder: ((context, index) {
                                    return Consumer<AppointmentProvider>(
                                        builder:
                                            (context, appointmentProvider, __) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            appointmentProvider
                                                    .selectedIndexforPaymentPlan =
                                                index;
                                            appointmentProvider
                                                    .payementPlansModelvar =
                                                paymentPlanList[index];
                                          });
                                        },
                                        child: PaymentPlanWidget(
                                          payementPlansModel:
                                              paymentPlanList[index],
                                          Index: index,
                                        ),
                                      );
                                    });
                                  })));
                }),
            const SizedBox(
              height: 120,
            )
          ],
        ),
      ),
    );
  }
}
