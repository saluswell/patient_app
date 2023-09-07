import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:saluswell_patient_updated/common/utils/enums.dart';
import 'package:saluswell_patient_updated/common/widgets/button_widget.dart';
import 'package:saluswell_patient_updated/src/authenticationsection/services/userServices.dart';
import 'package:saluswell_patient_updated/src/recipesSection/providers/recipes_provider.dart';
import 'package:saluswell_patient_updated/src/recipesSection/screens/recipe_details.dart';
import 'package:saluswell_patient_updated/src/subscriptionSection/screens/subscription_screen.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/cacheNetworkImageWidget.dart';
import '../../authenticationsection/Models/userModel.dart';
import '../models/recipes_model.dart';
import '../services/recipes_services.dart';

class RecipesListScreen extends StatefulWidget {
  const RecipesListScreen({Key? key}) : super(key: key);

  @override
  State<RecipesListScreen> createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<RecipesListScreen> {
  RecipesServices recipesServices = RecipesServices();
  UserServices userServices = UserServices();

  @override
  void initState() {
    context.read<RecipesProvider>().getRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipesProvider>(builder: (context, recipesProvider, __) {
      return LoadingOverlay(
          isLoading: recipesProvider.isLoading,
          progressIndicator: SpinKitPouringHourGlass(
            color: AppColors.appcolor,
            size: 30,
          ),
          child: Scaffold(
              body: StreamProvider.value(
                  value: userServices
                      .fetchUserRecord(FirebaseAuth.instance.currentUser!.uid),
                  initialData: UserModel(),
                  builder: (context, child) {
                    UserModel model = context.watch<UserModel>();
                    return Column(children: [
                      if (model.planName == PlanName.FreePlan.name) ...[
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              onPressed: () {
                                Navigator.maybePop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.appcolor,
                              )),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recipes",
                                  style: fontW5S12(context)!.copyWith(
                                      fontSize: 23,
                                      color: AppColors.blackcolor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 220,
                        ),
                        CommonButtonWidget(
                            horizontalPadding: 20,
                            textfont: 13,
                            text: "Subscribe to plan to access recipes",
                            onTap: () {
                              toNext(
                                  context: context,
                                  widget: SubscriptionScreen());
                            }),
                      ] else ...[
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              onPressed: () {
                                Navigator.maybePop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.appcolor,
                              )),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recipes",
                                  style: fontW5S12(context)!.copyWith(
                                      fontSize: 23,
                                      color: AppColors.blackcolor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        recipesProvider.recipes.isEmpty
                            ? const Center(
                                child: Padding(
                                padding: EdgeInsets.only(top: 220),
                                child: Text("No Recipes Found!",
                                    style: TextStyle(
                                        // fontFamily: 'Gilroy',
                                        color: AppColors.blackcolor,
                                        // decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Axiforma',
                                        fontSize: 13)),
                              ))
                            : recipesProvider.recipes[0].recipeId == null
                                ? const SpinKitPouringHourGlass(
                                    size: 30,
                                    color: AppColors.appcolor,
                                  )
                                : Expanded(
                                    flex: 4,
                                    child: GridView.builder(
                                        itemCount:
                                            recipesProvider.recipes.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    1, // Number of columns
                                                crossAxisSpacing:
                                                    3.0, // Space between columns
                                                mainAxisSpacing:
                                                    8.0, // Space between rows
                                                mainAxisExtent: 210),
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: 8,
                                            right: 8,
                                            bottom: 15),
                                        itemBuilder: ((context, index) {
                                          return InkWell(
                                            onTap: () {
                                              toNext(
                                                  context: context,
                                                  widget: RecipeDetailScreen(
                                                    recipesModel:
                                                        recipesProvider
                                                            .recipes[index],
                                                  ));
                                            },
                                            child: Container(
                                              height: 45,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11)),
                                                elevation: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CacheNetworkImageWidget(
                                                      imgUrl: recipesProvider
                                                          .recipes[index]
                                                          .recipeImage
                                                          .toString(),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      radius: 7,
                                                      height: 160,
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            recipesProvider
                                                                .recipes[index]
                                                                .recipeTitle
                                                                .toString(),
                                                            style: fontW5S12(
                                                                    context)!
                                                                .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color: AppColors
                                                                        .blackcolor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                          Text(
                                                            recipesProvider
                                                                .recipes[index]
                                                                .dateCreated!
                                                                .toDate()
                                                                .format(
                                                                    "d-M-Y"),
                                                            style: fontW5S12(context)!.copyWith(
                                                                fontSize: 11,
                                                                color: AppColors
                                                                    .blackcolor
                                                                    .withOpacity(
                                                                        0.5),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })))
                      ]
                    ]);
                  })));
    });
  }
}
