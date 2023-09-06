import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/dateFromatter.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/cacheNetworkImageWidget.dart';
import '../models/articleModel.dart';
import '../providers/healthzoneProvider.dart';
import '../services/articleServices.dart';

class HealthZoneScreen extends StatefulWidget {
  const HealthZoneScreen({Key? key}) : super(key: key);

  @override
  State<HealthZoneScreen> createState() => _HealthZoneScreenState();
}

class _HealthZoneScreenState extends State<HealthZoneScreen> {
  ArticleServices articleServices = ArticleServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Education",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 18,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Consumer<HealthZonProvider>(
                builder: (context, healthZoneProvider, __) {
              return TabBar(
                  labelStyle: fontW4S12(context)!.copyWith(
                      color: AppColors.lightwhitecolor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12),
                  indicatorPadding: EdgeInsets.only(),
                  indicatorWeight: 2,
                  isScrollable: true,
                  onTap: (index) {
                    if (index == 0) {
                      setState(() {
                        healthZoneProvider.currentCategory = "Meal Plan";
                      });
                    } else if (index == 1) {
                      setState(() {
                        healthZoneProvider.currentCategory = "Recipe";
                      });
                    } else if (index == 2) {
                      setState(() {
                        healthZoneProvider.currentCategory = "Health Tip";
                      });
                    } else if (index == 3) {
                      setState(() {
                        healthZoneProvider.currentCategory = "Diet Plan";
                      });
                    }
                  },
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.whitecolor,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                      color: AppColors.appcolor),
                  indicatorColor: AppColors.appcolor,
                  unselectedLabelColor: AppColors.lightdarktextcolor,
                  padding: EdgeInsets.only(right: 30, left: 15),
                  tabs: [
                    Consumer<HealthZonProvider>(
                        builder: (context, resourceProvider, __) {
                      return const Tab(
                        text: "Meal Plan",
                      );
                    }),
                    Consumer<HealthZonProvider>(
                        builder: (context, resourceProvider, __) {
                      return const Tab(
                        text: "Recipe",
                      );
                    }),
                    Consumer<HealthZonProvider>(
                        builder: (context, resourceProvider, __) {
                      return const Tab(
                        text: "Health Tip",
                      );
                    }),
                    Consumer<HealthZonProvider>(
                        builder: (context, resourceProvider, __) {
                      return const Tab(
                        text: "Diet Plan",
                      );
                    })
                  ]);
            }),

            // Consumer<HealthZonProvider>(builder: (context, health, __) {
            //   return Text(health.currentCategory ?? "");
            // }),
            // Padding(
            //   padding: const EdgeInsets.only(left: 12),
            //   child: Container(
            //     height: 45,
            //     child: ListView.builder(
            //         itemCount: 12,
            //         shrinkWrap: true,
            //         //padding: const EdgeInsets.only(top: 20),
            //         scrollDirection: Axis.horizontal,
            //         itemBuilder: ((context, index) {
            //           return Padding(
            //             padding: const EdgeInsets.only(right: 5),
            //             child: CategoryWidget(),
            //           );
            //         })),
            //   ),
            // ),

            Consumer<HealthZonProvider>(
                builder: (context, healthzoneProvider, __) {
              return StreamProvider.value(
                  value: articleServices.streamArticles(
                      true, healthzoneProvider.currentCategory.toString()),
                  initialData: [ArticleModel()],
                  builder: (context, child) {
                    List<ArticleModel> articelList =
                        context.watch<List<ArticleModel>>();
                    return articelList.isEmpty
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.only(top: 220),
                            child: Text("No Completed Appointments found!",
                                style: TextStyle(
                                    // fontFamily: 'Gilroy',
                                    color: AppColors.blackcolor,
                                    // decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Axiforma',
                                    fontSize: 13)),
                          ))
                        : articelList[0].articleId == null
                            ? const SpinKitPouringHourGlass(
                                size: 30,
                                color: AppColors.appcolor,
                              )
                            : Expanded(
                                child: ListView.builder(
                                    itemCount: articelList.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(top: 20),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Container(
                                          child: Card(
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              children: [
                                                CacheNetworkImageWidget(
                                                    imgUrl: articelList[index]
                                                        .articleImage
                                                        .toString(),
                                                    width: double.infinity,
                                                    height: 130,
                                                    radius: 13),
                                                // Container(
                                                //   height: 130,
                                                //   decoration: BoxDecoration(
                                                //       borderRadius:
                                                //           BorderRadius.only(
                                                //               topLeft: Radius
                                                //                   .circular(13),
                                                //               topRight: Radius
                                                //                   .circular(
                                                //                       13)),
                                                //       image: DecorationImage(
                                                //           fit: BoxFit.cover,
                                                //           image: AssetImage(
                                                //               Res.dietimage))),
                                                // ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              articelList[index]
                                                                  .articleTitle
                                                                  .toString(),
                                                              style: fontW5S12(
                                                                      context)!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16,
                                                                      color: AppColors
                                                                          .blackcolor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              DateFormatter.dateFormatter(
                                                                  articelList[
                                                                          index]
                                                                      .dateCreated!
                                                                      .toDate()),
                                                              style: fontW5S12(
                                                                      context)!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: AppColors
                                                                          .lightdarktextcolor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              color: AppColors
                                                                  .appcolor,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                              );
                  });
            })
          ],
        ),
      ),
    );
  }
}
