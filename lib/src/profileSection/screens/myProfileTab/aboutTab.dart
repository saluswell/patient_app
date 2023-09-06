import 'package:flutter/material.dart';

import '../../../../common/utils/appcolors.dart';
import '../../../../common/utils/themes.dart';
import '../../../authenticationsection/Models/userModelDietitian.dart';
import '../../widgets/text_details_widget.dart';

class AboutUserProfileTabScreen extends StatelessWidget {
  final UserModelDietitian userModel;

  const AboutUserProfileTabScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Details",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 17,
                          color: AppColors.blackcolor,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextDetailsWidget(
                  staticText: "First Name",
                  dynamicText:
                      userModel.personalInformationModel!.firstName.toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextDetailsWidget(
                  staticText: "Last Name",
                  dynamicText:
                      userModel.personalInformationModel!.lastName.toString(),
                ),
                SizedBox(
                  height: 10,
                ),

                TextDetailsWidget(
                  staticText: "Country",
                  dynamicText:
                      userModel.personalInformationModel!.country.toString(),
                ),
                SizedBox(
                  height: 10,
                ),

                TextDetailsWidget(
                  staticText: "City",
                  dynamicText:
                      userModel.personalInformationModel!.city.toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextDetailsWidget(
                  staticText: "Address",
                  dynamicText:
                      userModel.personalInformationModel!.adress.toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextDetailsWidget(
                  staticText: "Business Contact",
                  dynamicText: userModel
                      .personalInformationModel!.businessContact
                      .toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Professional Details",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 17,
                          color: AppColors.blackcolor,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextDetailsWidget(
                  staticText: "Professional Id Number",
                  dynamicText: userModel
                      .professionalInformationModel!.professionalIdNumber
                      .toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextDetailsWidget(
                  staticText: "Qualifications",
                  dynamicText: userModel
                      .professionalInformationModel!.qualfications
                      .toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextDetailsWidget(
                  staticText: "Area Of Focus",
                  dynamicText: userModel
                      .professionalInformationModel!.areaOfFocus
                      .toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextDetailsWidget(
                  staticText: "Languages Spoken",
                  dynamicText: userModel
                      .professionalInformationModel!.languageSpoken
                      .toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextDetailsWidget(
                  staticText: "Professional Approach",
                  dynamicText: userModel
                      .professionalInformationModel!.professionalApproach
                      .toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextDetailsWidget(
                  staticText: "Experience",
                  dynamicText: userModel
                          .professionalInformationModel!.yearofExperience
                          .toString() +
                      " Years",
                ),
                SizedBox(
                  height: 30,
                ),

                // TabBar(
                //     labelStyle: fontW4S12(context)!.copyWith(
                //         color: AppColors.lightwhitecolor,
                //         fontWeight: FontWeight.w600,
                //         fontSize: 12),
                //     indicatorPadding: EdgeInsets.only(),
                //     indicatorWeight: 2,
                //     indicatorSize: TabBarIndicatorSize.label,
                //     indicatorColor: AppColors.appcolor,
                //     unselectedLabelColor: AppColors.lightdarktextcolor,
                //     padding: EdgeInsets.only(),
                //     tabs: [
                //       Tab(
                //         text: "Personal",
                //       ),
                //       Tab(
                //         text: "Professional",
                //       ),
                //       // Tab(
                //       //   text: "Banking",
                //       // )
                //     ]),
                // Expanded(
                //   child: TabBarView(children: [
                //     PersonalInformation(),
                //     ProfessionalInformation(),
                //     //  BankingInformation(),
                //     // ReviewListTabScreen(),
                //     // AboutUserProfileTabScreen()
                //   ]),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
