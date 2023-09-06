import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:saluswell_patient_updated/common/helperFunctions/navigatorHelper.dart';
import 'package:saluswell_patient_updated/common/utils/appcolors.dart';
import 'package:saluswell_patient_updated/common/widgets/button_widget.dart';
import 'package:saluswell_patient_updated/src/subscriptionSection/providers/subscription_provider.dart';
import 'package:saluswell_patient_updated/src/subscriptionSection/screens/add_card_inforamtion_screen.dart';

import '../../../common/utils/themes.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  // SubscriptionService subscriptionService = SubscriptionService();

  @override
  void initState() {
    context.read<SubscriptionProvider>().getSubscriptionProductsProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionProvider>(
        builder: (context, subscriptionProvider, __) {
      return LoadingOverlay(
        isLoading: subscriptionProvider.isLoading,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appcolor,
        ),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Subscription"),
          ),
          body: subscriptionProvider.subscriptionProductsModel == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.appcolor,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 20, bottom: 30),
                          itemCount: subscriptionProvider
                              .subscriptionProductsModel!.data!.length,
                          itemBuilder: (context, index) {
                            var data = subscriptionProvider
                                .subscriptionProductsModel!.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: Container(
                                //  height: 200,
                                //height: 170,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  color:
                                      AppColors.darkAppColor.withOpacity(0.9),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: AppColors.whitecolor),
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  elevation: 4,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(data.name.toString(),
                                          style: fontW5S12(context)!.copyWith(
                                              color: AppColors.whitecolor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17)),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text("Features",
                                          style: fontW5S12(context)!.copyWith(
                                              color: AppColors.whitecolor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 140,
                                        padding: EdgeInsets.only(left: 40),
                                        child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent: 30,
                                              crossAxisSpacing: 0.5,

                                              mainAxisSpacing: 5,
                                              crossAxisCount:
                                                  1, // Number of columns in the grid
                                            ),
                                            itemCount: data.features!.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  Container(
                                                    height: 9,
                                                    width: 9,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13),
                                                        color: AppColors
                                                            .whitecolor),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      data.features![index].name
                                                          .toString(),
                                                      style: fontW5S12(context)!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .whitecolor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14)),
                                                ],
                                              );
                                            }),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          index == 0
                                              ? "\$80 / Monthly"
                                              : "\$20 / Monthly",
                                          style: fontW5S12(context)!.copyWith(
                                              color: AppColors.whitecolor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CommonButtonWidget(
                                          text: "Subscribe",
                                          onTap: () {
                                            toNext(
                                                context: context,
                                                widget: AddCardInformation(
                                                  productsDatum:
                                                      subscriptionProvider
                                                          .subscriptionProductsModel!
                                                          .data![index],
                                                ));
                                          }),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                    // ElevatedButton(
                    //     onPressed: () {
                    //       // subscriptionService.subscriptions();
                    //     },
                    //     child: Center(
                    //       child: Text("Subscribe"),
                    //     ))
                  ],
                ),
        ),
      );
    });
  }
}
