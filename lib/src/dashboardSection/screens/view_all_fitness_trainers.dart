import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';
import '../services/home_services.dart';
import '../widgets/fitness_trianers_card_widget.dart';
import 'doctorDetails.dart';

class ViewAllFitnessTrainers extends StatefulWidget {
  const ViewAllFitnessTrainers({Key? key}) : super(key: key);

  @override
  State<ViewAllFitnessTrainers> createState() => _ViewAllFitnessTrainersState();
}

class _ViewAllFitnessTrainersState extends State<ViewAllFitnessTrainers> {
  HomeServices homeServices = HomeServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appcolor,
        centerTitle: true,
        title: Text(
          "All Fitness Trainers",
          style: fontW5S12(context)!.copyWith(
              fontSize: 17,
              color: AppColors.whitecolor,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          StreamProvider.value(
              value: homeServices.streamAllFitnessTrainers(),
              initialData: [UserModelDietitian()],
              builder: (context, child) {
                List<UserModelDietitian> dietitansList =
                    context.watch<List<UserModelDietitian>>();
                return dietitansList.isEmpty
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.only(top: 90),
                        child: Text("No Fitness Trainers found!",
                            style: TextStyle(
                                // fontFamily: 'Gilroy',
                                color: AppColors.blackcolor,
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Axiforma',
                                fontSize: 13)),
                      ))
                    : dietitansList[0].userId == null
                        ? const SpinKitPouringHourGlass(
                            size: 30,
                            color: AppColors.appcolor,
                          )
                        : Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.only(),
                                physics: const ScrollPhysics(),

                                // physics:
                                //     const NeverScrollableScrollPhysics(),
                                itemCount: dietitansList.length,
                                itemBuilder: (_, i) {
                                  //  print(dietitansList[i]..toString());
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: InkWell(
                                      onTap: () {
                                        toNext(
                                            context: context,
                                            widget: DoctorDetails(
                                              userModel: dietitansList[i],
                                            ));
                                      },
                                      child: FitnessTrainerCardWidget(
                                        userModel: dietitansList[i],
                                      ),
                                    ),
                                  );
                                }),
                          );
              }),
        ],
      ),
    );
  }
}
