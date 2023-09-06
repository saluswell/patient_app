import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/cacheNetworkImageWidget.dart';
import '../../apppointmentsSection/screens/createAppointmentScreen.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';
import '../../chatSection/screens/messages.dart';
import '../../profileSection/screens/myProfileTab/aboutTab.dart';
import '../../profileSection/screens/myProfileTab/reviewsTab.dart';

class DoctorDetails extends StatelessWidget {
  final UserModelDietitian userModel;

  DoctorDetails({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: InkWell(
                onTap: () {
                  toNext(
                      context: context,
                      widget: CreateAppointmentScreen(
                        userDietitanModeluser: userModel,
                      ));
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
                        "Book Appointment",
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
          leading: IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.blackcolor,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  //Navigator.maybePop(context);
                },
                icon: const Icon(
                  Icons.share,
                  color: AppColors.blackcolor,
                )),
            IconButton(
                onPressed: () {
                  toNext(
                      context: context,
                      widget: MessagesView(
                          image: userModel!.profilePicture.toString(),
                          receiverID: userModel.userId.toString(),
                          myID: FirebaseAuth.instance.currentUser!.uid,
                          name: userModel.userName.toString()));
                  // Navigator.maybePop(context);
                },
                icon: const Icon(
                  Icons.chat,
                  color: AppColors.blackcolor,
                )),
          ],
          backgroundColor: AppColors.whitecolor,
          elevation: 4,
          toolbarHeight: 50,
          centerTitle: true,
          title: Text(
            "Dr ${userModel!.userName}",
            style: fontW5S12(context)!.copyWith(
                fontSize: 17,
                color: AppColors.blackcolor,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: AppColors.appcolor),
                            borderRadius: BorderRadius.circular(13)),
                        child: CacheNetworkImageWidget(
                            height: 75,
                            width: 75,
                            imgUrl: userModel!.profilePicture.toString(),
                            radius: 7),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${userModel!.userName}",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 15,
                                color: AppColors.blackcolor,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            userModel!.userType.toString(),
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 12,
                                color: AppColors.lightdarktextcolor,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            userModel!
                                .professionalInformationModel!.qualfications
                                .toString(),
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 12,
                                color: AppColors.lightdarktextcolor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       RatingBarWidget(
                  //         itemCount: 5,
                  //         starSize: 18,
                  //         onRatingUpdate: (double) {},
                  //       ),
                  //       const SizedBox(
                  //         width: 4,
                  //       ),
                  //       Text(
                  //         "(4.7)",
                  //         style: fontW5S12(context)!.copyWith(
                  //             fontSize: 14,
                  //             color: AppColors.blackcolor,
                  //             fontWeight: FontWeight.w500),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Experience",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 13,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "${userModel!.professionalInformationModel!.yearofExperience} Years",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 12,
                            color: AppColors.lightdarktextcolor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: AppColors.lightdarktextcolor,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reviews",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 13,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 13,
                            color: Colors.amber,
                          ),
                          Text(
                            " 5(42)",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 12,
                                color: AppColors.lightdarktextcolor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: AppColors.lightdarktextcolor,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Response",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 13,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "1 hour",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 12,
                            color: AppColors.lightdarktextcolor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TabBar(
                labelStyle: fontW4S12(context)!.copyWith(
                    color: AppColors.lightwhitecolor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
                indicatorPadding: const EdgeInsets.only(),
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: AppColors.appcolor,
                unselectedLabelColor: AppColors.lightdarktextcolor,
                padding: const EdgeInsets.only(),
                tabs: const [
                  Tab(
                    text: "Reviews(14)",
                  ),
                  Tab(
                    text: "About",
                  )
                ]),
            Expanded(
              child: TabBarView(children: [
                ReviewListTabScreen(),
                AboutUserProfileTabScreen(
                  userModel: userModel,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
