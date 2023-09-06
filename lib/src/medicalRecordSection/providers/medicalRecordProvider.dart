import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/helperFunctions/commonMethods.dart';
import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/helperFunctions/showsnackbar.dart';
import '../../../common/helperFunctions/storage_services.dart';
import '../../../common/utils/appcolors.dart';
import '../models/medical_record_model.dart';
import '../services/medical_record_services.dart';

class MedicalRecordProvider extends ChangeNotifier {
  MedicalRecordServices medicalRecordServices = MedicalRecordServices();
  StorageServices storageServices = StorageServices();
  String? recordType;
  DateTime? recordDate;
  List<File> recordImagesList = [];
  List<String> recordvarList = [
    'Record Type',
    'Laboratory Tests',
    'Medication ',
    'Report',
    'Vaccination',
    'Invoice',
    'Other',
  ];

  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  makeLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  updateRecordVarValue(val) {
    recordType = val;
    notifyListeners();
  }

  pickMedicalRecordImages(context, ImageSource imageSource) async {
    var xFile = await CommonMethods.getImage(imageSource);
    if (xFile != null) {
      //testCompressAndGetFile(File(xFile.path) Temp);
      recordImagesList.add(File(xFile.path));
      notifyListeners();
    } else {
      showSnackBarMessage(
          context: navstate.currentState!.context,
          content: "Picture not picked");
    }
  }

  removefromMedicalRecordImages(index) {
    recordImagesList.removeAt(index);
    notifyListeners();
  }

  showDatepicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: navstate.currentState!.context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));
    recordDate = pickedDate;
    notifyListeners();
  }

  ///crate medical record in firebase
  createMedicalRecord(
    String patientID,
    String dietianID,
    String apponintmentID,
  ) async {
    if (recordType == "Record Type") {
      showSnackBarMessage(
          backgroundcolor: AppColors.redcolor,
          contentColor: AppColors.whitecolor,
          context: navstate.currentState!.context,
          content: "Please Select Record Type");
    } else if (recordDate == null) {
      showSnackBarMessage(
          backgroundcolor: AppColors.redcolor,
          contentColor: AppColors.whitecolor,
          context: navstate.currentState!.context,
          content: "Please Select Record Date");
    } else if (recordImagesList.isEmpty || recordImagesList.length > 5) {
      showSnackBarMessage(
          backgroundcolor: AppColors.redcolor,
          contentColor: AppColors.whitecolor,
          context: navstate.currentState!.context,
          content: "Please Select least 1 and maximum 5 record images");
    } else {
      try {
        makeLoadingTrue();
        var urlsList = [];
        await Future.forEach<File>(recordImagesList, (element) async {
          var h = await storageServices.uploadFile(element);
          urlsList.add(h);
        });

        medicalRecordServices
            .createMedicalRecord(MedicalRecordModel(
                patientId: patientID,
                appointmentId: apponintmentID,
                dietitianId: dietianID,
                recordDate: Timestamp.fromDate(recordDate!),
                recordType: recordType,
                recordImagesList: urlsList))
            .then((value) {
          makeLoadingFalse();
          Navigator.maybePop(navstate.currentState!.context);
          showSnackBarMessage(
              context: navstate.currentState!.context,
              content: "Medical Record Uploaded Successfully");
        });
      } catch (e) {
        makeLoadingFalse();
        showSnackBarMessage(
            context: navstate.currentState!.context, content: e.toString());
        // TODO
      }
    }
  }
}
