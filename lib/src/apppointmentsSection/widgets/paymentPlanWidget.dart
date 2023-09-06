import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../models/paymentPlanModel.dart';
import '../providers/appointmentProvider.dart';

class PaymentPlanWidget extends StatelessWidget {
  final int Index;
  final PayementPlansModel payementPlansModel;

  const PaymentPlanWidget({
    Key? key,
    required this.payementPlansModel,
    required this.Index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Consumer<AppointmentProvider>(
          builder: (context, appointmentProvider, __) {
        return SizedBox(
          height: 150,
          width: 400,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
                side: BorderSide(
                    width: 2,
                    color:
                        appointmentProvider.selectedIndexforPaymentPlan == Index
                            ? AppColors.appcolor
                            : AppColors.blackcolor.withOpacity(0.1))),
            color: AppColors.lightwhitecolor,
            elevation: 4,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  payementPlansModel.visitType.toString(),
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
                        "\$${payementPlansModel.visitPrice}",
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
                        "${payementPlansModel.timeDuration} Minutes",
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
        );
      }),
    );
  }
}
