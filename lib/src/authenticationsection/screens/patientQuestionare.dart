import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/textutils.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/button_widget.dart';
import '../../../common/widgets/textfield_widget.dart';
import '../../apppointmentsSection/widgets/accessories_widget.dart';
import '../providers/authProvider.dart';
import 'loginScreen.dart';

class PatientQuestionareScreen extends StatefulWidget {
  static String routeName = "PatientQuestionareScreen";

  const PatientQuestionareScreen({Key? key}) : super(key: key);

  @override
  State<PatientQuestionareScreen> createState() =>
      _PatientQuestionareScreenState();
}

class _PatientQuestionareScreenState extends State<PatientQuestionareScreen> {
  final _formKey = GlobalKey<FormState>();

  bool firstDropDownOpen = false;
  bool secondDropDownOpen = false;
  bool thirdDropDownOpen = false;

  // List<dynamic> wantToAcheiveList = [];

  List<String> listOFSelectedItem = ["hello", "hi", "what"];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, __) {
      return LoadingOverlay(
        isLoading: authProvider.isLoading,
        progressIndicator: const SpinKitPouringHourGlass(
          size: 30,
          color: AppColors.appcolor,
        ),
        child: Scaffold(
          backgroundColor: AppColors.appcolor,
          body: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 6,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    //  height: 660,

                    width: 340,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(28)),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                      elevation: 3,
                      color: AppColors.whitecolor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 3,
                                  width: 310,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Patient",
                                  style: fontW5S12(context)!.copyWith(
                                      fontSize: 30,
                                      color: AppColors.blackcolor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Questionnaire",
                                  style: fontW5S12(context)!.copyWith(
                                      fontSize: 30,
                                      color: AppColors.blackcolor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 36),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            'We want to get to know you and understand your lifestyle. Complete the questionnaire so our care providers can understand your lifestyle and how to tailor your journey for better health ',
                                        style: fontW5S12(context)!.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.lightdarktextcolor)),
                                  ],
                                ),
                                textScaleFactor: 0.7,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 350,
                                      child: ListView(
                                        padding: const EdgeInsets.only(),
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "What do you want to achieve?",
                                              style: fontW5S12(context)!
                                                  .copyWith(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.blackcolor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 14,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1),
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              //  runAlignment: WrapAlignment.end,
                                              children: [
                                                TextUtils.Disease_Prevention,
                                                TextUtils.Gain_weight,
                                                TextUtils.Lose_weight_fat,
                                                TextUtils.Maintain_weight,
                                                TextUtils.Add_muscle,
                                                TextUtils.healthy_aging,
                                                TextUtils.get_stronger,
                                                TextUtils.modeling,
                                                TextUtils.decrarse_medications,
                                                TextUtils.physical_fitnesss,
                                                TextUtils.other
                                              ]
                                                  .map((e) => AccessoriesWidget(
                                                        textcolor: authProvider
                                                                .wantToAcheiveList
                                                                .contains(e)
                                                            ? AppColors
                                                                .whitecolor
                                                                .withOpacity(
                                                                    0.9)
                                                            : AppColors
                                                                .blackcolor
                                                                .withOpacity(
                                                                    0.5),
                                                        onTap: (value) {
                                                          authProvider
                                                              .addWantToAchieveOrRemove(
                                                                  context,
                                                                  value);
                                                        },
                                                        text: e,
                                                        color: authProvider
                                                                .wantToAcheiveList
                                                                .contains(e)
                                                            ? AppColors.appcolor
                                                                .withOpacity(
                                                                    0.9)
                                                            : AppColors
                                                                .lightdarktextcolor
                                                                .withOpacity(
                                                                    0.5),
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "What is your daily activity level?",
                                              style: fontW5S12(context)!
                                                  .copyWith(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.blackcolor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 14,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1),
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              //  runAlignment: WrapAlignment.end,
                                              children: [
                                                TextUtils.notActive,
                                                TextUtils.Moderately_Active,
                                                TextUtils.Very_Active,
                                              ]
                                                  .map((e) => AccessoriesWidget(
                                                        textcolor: authProvider
                                                                .dailyactivitylevelList
                                                                .contains(e)
                                                            ? AppColors
                                                                .whitecolor
                                                                .withOpacity(
                                                                    0.9)
                                                            : AppColors
                                                                .blackcolor
                                                                .withOpacity(
                                                                    0.5),
                                                        onTap: (value) {
                                                          authProvider
                                                              .addDailyActivityLevelOrRemove(
                                                                  context,
                                                                  value);
                                                        },
                                                        text: e,
                                                        color: authProvider
                                                                .dailyactivitylevelList
                                                                .contains(e)
                                                            ? AppColors.appcolor
                                                                .withOpacity(
                                                                    0.9)
                                                            : AppColors
                                                                .lightdarktextcolor
                                                                .withOpacity(
                                                                    0.5),
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "What is your height? ",
                                              style: fontW5S12(context)!
                                                  .copyWith(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.blackcolor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: TextFieldWidget(
                                                    showSuffixIcon: false,
                                                    controller: authProvider
                                                        .heightController,
                                                    textFieldHeight: 55,
                                                    enabled: true,
                                                    maxLengt: 40,
                                                    maxlines: 1,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter Height in feet";
                                                      }
                                                      return null;
                                                    },
                                                    suffixIcon: const Icon(
                                                        Icons.arrow_drop_down),
                                                    toppadding: 19,
                                                    hintText: "Height",
                                                    textInputType:
                                                        TextInputType.number),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "What is your current weight?",
                                              style: fontW5S12(context)!
                                                  .copyWith(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.blackcolor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          TextFieldWidget(
                                              showSuffixIcon: false,
                                              controller:
                                                  authProvider.weightController,
                                              textFieldHeight: 55,
                                              suffixIcon: const Icon(
                                                  Icons.arrow_drop_down),
                                              enabled: true,
                                              maxlines: 1,
                                              toppadding: 19,
                                              maxLengt: 40,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter weight in lbs e.g 110 lbs";
                                                }
                                                return null;
                                              },
                                              hintText: "e.g 110 lbs)",
                                              textInputType:
                                                  TextInputType.number),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "What is your Waist Circumference(in inches)?",
                                              style: fontW5S12(context)!
                                                  .copyWith(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.blackcolor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          TextFieldWidget(
                                              showSuffixIcon: false,
                                              controller: authProvider
                                                  .waistCircumferrenceController,
                                              textFieldHeight: 55,
                                              suffixIcon: const Icon(
                                                  Icons.arrow_drop_down),
                                              enabled: true,
                                              maxlines: 1,
                                              toppadding: 19,
                                              maxLengt: 40,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter Waist Circumference(in inches)";
                                                }
                                                return null;
                                              },
                                              hintText: "e.g 32 Inches)",
                                              textInputType:
                                                  TextInputType.number),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "What is your Hip Circumference(in inches)?",
                                              style: fontW5S12(context)!
                                                  .copyWith(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.blackcolor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          TextFieldWidget(
                                              showSuffixIcon: false,
                                              controller: authProvider
                                                  .HipCircumferrenceController,
                                              textFieldHeight: 55,
                                              maxlines: 1,
                                              toppadding: 18,
                                              maxLengt: 15,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter Hip Circumference(in inches)";
                                                }
                                                return null;
                                              },
                                              hintText: "e.g 23 inches",
                                              textInputType:
                                                  TextInputType.number),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Your BMi is:",
                                          style: fontW5S12(context)!.copyWith(
                                              fontSize: 16,
                                              color: AppColors.blackcolor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          authProvider.bmivar == null
                                              ? "BMI"
                                              : authProvider.bmivar!
                                                  .toStringAsFixed(2),
                                          style: fontW5S12(context)!.copyWith(
                                              fontSize: 16,
                                              color: AppColors.blackcolor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        authProvider.calculateBMI();
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 108,
                                        decoration: BoxDecoration(
                                            color: AppColors.appcolor,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: const Center(
                                          child: Text(
                                            "Calculate BMI",
                                            style: TextStyle(
                                                color: AppColors.whitecolor),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              // Spacer(),

                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Step",
                                      style: fontW5S12(context)!.copyWith(
                                          fontSize: 16,
                                          color: AppColors.blackcolor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      " 4 of 4",
                                      style: fontW5S12(context)!.copyWith(
                                          fontSize: 16,
                                          color: AppColors.appcolor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              CommonButtonWidget(
                                  horizontalPadding: 8,
                                  backgroundcolor: AppColors.appcolor,
                                  text: "Create Account",
                                  textfont: 16,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      authProvider.createUser();
                                    }
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: fontW5S12(context)!.copyWith(
                                          fontSize: 16,
                                          color: AppColors.blackcolor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        toNext(
                                            context: context,
                                            widget: const LoginScreen());
                                      },
                                      child: Text(
                                        " Login",
                                        style: fontW5S12(context)!.copyWith(
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.underline,
                                            color: AppColors.appcolor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }
}
