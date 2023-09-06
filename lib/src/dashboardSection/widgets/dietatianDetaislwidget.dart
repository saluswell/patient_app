import 'package:flutter/material.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/cacheNetworkImageWidget.dart';
import '../../authenticationsection/Models/userModelDietitian.dart';

class PopularDietitiansWidget extends StatelessWidget {
  final UserModelDietitian userModel;

  const PopularDietitiansWidget({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 150,
          width: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CacheNetworkImageWidget(
                              height: 45,
                              width: 45,
                              imgUrl: userModel.profilePicture.toString(),
                              radius: 7),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userModel.userName.toString(),
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 15,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                userModel.personalInformationModel!.title
                                    .toString(),
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 12,
                                    color: AppColors.lightdarktextcolor,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                userModel
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
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite,
                                color: AppColors.appcolor,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Experience",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 11,
                                color: AppColors.blackcolor,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            userModel.professionalInformationModel!
                                    .yearofExperience
                                    .toString() +
                                " Years",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 11,
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
                                fontSize: 11,
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
                                    fontSize: 11,
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
                                fontSize: 11,
                                color: AppColors.blackcolor,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "1 hour",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 11,
                                color: AppColors.lightdarktextcolor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
