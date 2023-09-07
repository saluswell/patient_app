import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:saluswell_patient_updated/src/authenticationsection/providers/savUserDetailsProvider.dart';
import 'package:saluswell_patient_updated/src/subscriptionSection/services/subscription_services.dart';

import '../../../common/helperFunctions/commonMethods.dart';
import '../../../common/helperFunctions/getUserIDhelper.dart';
import '../../../common/helperFunctions/hive_local_storage.dart';
import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/helperFunctions/showsnackbar.dart';
import '../../../common/helperFunctions/storage_services.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/enums.dart';
import '../../../common/utils/textutils.dart';
import '../../dashboardSection/screens/bottomNavScreen.dart';
import '../Models/bankingInformationModel.dart';
import '../Models/patientQuestionareModel.dart';
import '../Models/personalInformationModel.dart';
import '../Models/professionalInformationModel.dart';
import '../Models/userModel.dart';
import '../screens/createAccountScreen.dart';
import '../screens/loginScreen.dart';
import '../services/authServices.dart';
import '../services/userServices.dart';

class AuthProvider extends ChangeNotifier {
  /// all variables
  bool showicon = false;
  bool showconfirmobsecure = false;

  bool isLoading = false;
  File? profileImage;
  var profileImageurlVar;

  ///patient questionalte screen variables
  double? bmivar;

  List<dynamic> wantToAcheiveList = [];

  List<dynamic> dailyactivitylevelList = [];

  makeLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  makeLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  ///service accesing from othe classes
  AuthServices authServices = AuthServices();
  UserServices userServices = UserServices();
  StorageServices storageServices = StorageServices();

  ///create account screen controllers
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  /// personal information screen controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController bussinessContactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipPostalCodeController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController coutryController = TextEditingController();

  /// banking information controllers
  TextEditingController branchNameController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController transitNumberController = TextEditingController();
  TextEditingController finincalInstutuionnumber = TextEditingController();

  /// professional information controllers

  TextEditingController professionalIDNumberController =
      TextEditingController();
  TextEditingController QualficationsController = TextEditingController();
  TextEditingController yearsOfExperienceController = TextEditingController();
  TextEditingController areaOfFocusController = TextEditingController();
  TextEditingController professionalApproachController =
      TextEditingController();
  TextEditingController languageSpokenController = TextEditingController();

  /// login screen controllers
  TextEditingController loginemailController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();

  ///  forgot email Controller
  TextEditingController forgotemailController = TextEditingController();

  ///pateint questionate screen controllers
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController waistCircumferrenceController = TextEditingController();
  TextEditingController HipCircumferrenceController = TextEditingController();

  calculateBMI() {
    if (heightController.text.isEmpty && weightController.text.isEmpty) {
      showSnackBarMessage(
          backgroundcolor: AppColors.redcolor,
          context: navstate.currentState!.context,
          content: "Please Enter height and weight to calculate BMI");
      return;
    }
    final double height = double.parse(heightController.value.text);
    final double weight = double.parse(weightController.value.text);

    // Check if the inputs are valid
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      showSnackBarMessage(
          context: navstate.currentState!.context,
          content: "Height and weight must be positive numbers");
      notifyListeners();

      return;
    }
    bmivar = weight / (height * height);
    notifyListeners();
  }

  addWantToAchieveOrRemove(context, String dos) async {
    if (wantToAcheiveList.contains(dos)) {
      wantToAcheiveList.remove(dos);
      notifyListeners();
    } else {
      wantToAcheiveList.add(dos);

      notifyListeners();
    }
  }

  addDailyActivityLevelOrRemove(context, String dos) async {
    if (dailyactivitylevelList.contains(dos)) {
      dailyactivitylevelList.remove(dos);
      notifyListeners();
    } else {
      dailyactivitylevelList.add(dos);

      notifyListeners();
    }
  }

  /// create user in firebase authentication and in firestore

  createUser() async {
    makeLoadingTrue();

    try {
      ///This will allow user to register in firebase
      return await authServices
          .registerUser(
              email: emailController.text.trim(),
              password: passwordController.text)
          .then((value) async {
        userServices.createUser(UserModel(
            userId: getUserID(),
            dateCreated: Timestamp.fromDate(DateTime.now()),
            emailAdress: emailController.text,
            isApprovedByAdmin: false,
            profilePicture: null,
            userName: userNameController.text,
            userType: "Patient",
            planName: PlanName.FreePlan.name,
            planPrice: null,
            planStatus: PlanStatus.InActive.name,
            personalInformationModel: PersonalInformationModel(
                title: titleController.text,
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                userId: getUserID(),
                mobileNumber: mobileNumberController.text,
                businessContact: bussinessContactController.text,
                adress: addressController.text,
                city: cityController.text,
                postalCode: zipPostalCodeController.text,
                province: provinceController.text,
                country: coutryController.text),
            patientQuestionareModel: PatientQuestionareModel(
              userId: getUserID(),
              wantToAchieveList: wantToAcheiveList,
              activityLevelList: dailyactivitylevelList,
              height: heightController.text,
              weight: weightController.text,
              waistCircumferrence: waistCircumferrenceController.text,
              hipCicumferrence: HipCircumferrenceController.text,
            ),
            bankingInformationModel: BankingInformationModel(
              userId: getUserID(),
              accountNumber: "",
              accountType: "",
              bankBrachName: "",
              financialInstitutionNumber: "",
              transitNumber: "",
            ),
            professionalInformationModel: ProfessionalInformationModel(
                areaOfFocus: "",
                languageSpoken: "",
                professionalApproach: "",
                professionalIdNumber: "",
                qualfications: "",
                userId: getUserID(),
                yearofExperience: "")));

        await HiveLocalStorage.write(
            boxName: TextUtils.currentRouteBox,
            key: TextUtils.currentRouteKey,
            value: CreateAccountScreen.routeName);
        // await Fluttertoast.showToast(msg: "Login Successfully");
        // userServices.createUser(UserModel(
        //     firstName: _firstNameController.text,
        //     lastName: _lastNameController.text,
        //     userEmail: _emailController.text.trim(),
        //     userID: getUserID()));

        makeLoadingFalse();
      }).then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification().whenComplete(() {
            //   toNext(context: context, widget: ResendEmailScreen());
          }).whenComplete(() {
            toRemoveAll(
                context: navstate.currentState!.context, widget: LoginScreen());
            showSnackBarMessage(
                backgroundcolor: AppColors.whitecolor,
                contentColor: AppColors.blackcolor,
                context: navstate.currentState!.context,
                content: "Account Created Successfully! Now Login ");
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      makeLoadingFalse();
      return showDialog<void>(
        context: navstate.currentState!.context,
        barrierDismissible: false,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('ALert!'),
            content: Text(e.message.toString()),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Okay'),
                onPressed: () {
                  makeLoadingFalse();
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  loginUser() async {
    makeLoadingTrue();
    try {
      ///This will allow user to authenticate in firebase
      return await authServices
          .loginUser(
              email: emailController.text.trim(),
              password: passwordController.text)
          .whenComplete(() => makeLoadingFalse())
          .then((firebaseUser) async {
        authServices
            .fetchUserRecord(firebaseUser.uid.toString())
            .first
            .then((userData) async {
          print(userData.toJson('docID'));
          Provider.of<UserProvider>(navstate.currentState!.context,
                  listen: false)
              .saveUserDetails(userData);
          //  await UserLoginStateHandler.saveUserLoggedInSharedPreference(true);
          // await checkEmailVerified();
          await HiveLocalStorage.write(
              boxName: TextUtils.currentRouteBox,
              key: TextUtils.currentRouteKey,
              value: LoginScreen.routeName);
          toRemoveAll(
              context: navstate.currentState!.context,
              widget: BottomNavScreen());
          await showSnackBarMessage(
              backgroundcolor: AppColors.whitecolor,
              contentColor: AppColors.blackcolor,
              context: navstate.currentState!.context,
              content: "Login Successfully");
        });
      });
    } on FirebaseAuthException catch (e) {
      makeLoadingFalse();
      return showDialog<void>(
        context: navstate.currentState!.context,
        barrierDismissible: false,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: AppColors.whitecolor,
            title: const Text('ALert!'),
            content: Text(e.message.toString()),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Okay'),
                onPressed: () {
                  makeLoadingFalse();
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  /// forgot password get password reset link on email
  getResetPasswordLink() async {
    try {
      makeLoadingTrue();
      final list = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(forgotemailController.text);
      if (list.isNotEmpty) {
        authServices
            .resetPassword(email: forgotemailController.text)
            .whenComplete(() async {
          makeLoadingFalse();
          await showSnackBarMessage(
              context: navstate.currentState!.context,
              content:
                  "Password reset link send to your  entered email! make sure also to check spam folder");
        });
      } else {
        showSnackBarMessage(
            backgroundcolor: AppColors.redcolor,
            contentColor: AppColors.whitecolor,
            context: navstate.currentState!.context,
            content: "Email provided is not a user");
      }
    } on FirebaseAuthException catch (e) {
      makeLoadingFalse();
      showSnackBarMessage(
          backgroundcolor: AppColors.redcolor,
          contentColor: AppColors.whitecolor,
          context: navstate.currentState!.context,
          content: e.toString());
    }
  }

  ///update Profile data
  updateProfile(String userID, String userName) async {
    try {
      if (profileImage != null) {
        makeLoadingTrue();
        var profileimageurl = await storageServices.uploadFile(profileImage!);
        profileImageurlVar = profileimageurl;
        notifyListeners();

        userServices.updateUserDetailswithImage(UserModel(
          userId: userID,
          userName: userName,
          profilePicture: profileImageurlVar,
        ));
        await showSnackBarMessage(
            backgroundcolor: AppColors.blackcolor,
            contentColor: AppColors.whitecolor,
            context: navstate.currentState!.context,
            content: "Profile Updated Sucessfully with image");
        makeLoadingFalse();
        Navigator.maybePop(navstate.currentState!.context);
      } else {
        makeLoadingTrue();
        userServices.updateUserDetailsWithoutImage(
            UserModel(userId: userID, userName: userName));
        makeLoadingFalse();
        await showSnackBarMessage(
            backgroundcolor: AppColors.blackcolor,
            contentColor: AppColors.whitecolor,
            context: navstate.currentState!.context,
            content: "Profile Updated Sucessfully");
        Navigator.maybePop(navstate.currentState!.context);
      }
    } on FirebaseException catch (e) {
      makeLoadingFalse();

      showSnackBarMessage(
          backgroundcolor: AppColors.redcolor,
          contentColor: AppColors.whitecolor,
          context: navstate.currentState!.context,
          content: e.toString());
    }
  }

  /// logout user from app and delete local hive values
  logoutFromApp(context) async {
    await HiveLocalStorage.deleteHiveValue(
        boxName: TextUtils.currentRouteBox, key: TextUtils.currentRouteKey);
    await authServices.logoutUser();
    // GoogleSignIn().signOut();
    // FacebookAuth.instance.logOut();

    toRemoveAll(context: context, widget: LoginScreen());
    //pushNewScreen(context, withNavBar: false, screen: SignInScreen());
    await showSnackBarMessage(
        backgroundcolor: AppColors.whitecolor,
        contentColor: AppColors.blackcolor,
        context: navstate.currentState!.context,
        content: "Logout Successfully");
  }

  /// pick profile image

  pickProfileImage(context, ImageSource imageSource) async {
    var xFile = await CommonMethods.getImage(imageSource);
    if (xFile != null) {
      profileImage = File(xFile.path);
      notifyListeners();
    } else {
      showSnackBarMessage(
          context: navstate.currentState!.context,
          content: "Picture not picked");
    }
  }
}
