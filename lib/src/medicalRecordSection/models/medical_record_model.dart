// To parse this JSON data, do
//
//     final medicalRecordModel = medicalRecordModelFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
MedicalRecordModel medicalRecordModelFromJson(String str) =>
    MedicalRecordModel.fromJson(json.decode(str));

String medicalRecordModelToJson(MedicalRecordModel data) =>
    json.encode(data.toJson(data.recordId.toString()));

class MedicalRecordModel {
  MedicalRecordModel({
    this.recordId,
    this.patientId,
    this.appointmentId,
    this.dietitianId,
    this.recordType,
    this.recordImagesList,
    this.recordDate,
  });

  String? recordId;
  String? patientId;
  String? appointmentId;
  String? dietitianId;
  String? recordType;
  List? recordImagesList;
  Timestamp? recordDate;

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) =>
      MedicalRecordModel(
        recordId: json["recordID"],
        patientId: json["patientID"],
        appointmentId: json["appointmentID"],
        dietitianId: json["dietitianID"],
        recordType: json["recordType"],
        recordImagesList: json["recordImagesList "],
        recordDate: json["recordDate "],
      );

  Map<String, dynamic> toJson(String id) => {
        "recordID": id,
        "patientID": patientId,
        "appointmentID": appointmentId,
        "dietitianID": dietitianId,
        "recordType": recordType,
        "recordImagesList ": recordImagesList,
        "recordDate ": recordDate,
      };
}
