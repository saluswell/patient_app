// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

SubscriptionModel subscriptionModelFromJson(String str) =>
    SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) =>
    json.encode(data.toJson(data.userId.toString()));

class SubscriptionModel {
  SubscriptionModel({
    this.userId,
    this.subscriptionId,
    this.planName,
    this.planPrice,
    this.planStatus,
    this.isApprovedByAdmin,
    this.dateCreated,
    this.subscriptionID,
    this.customerID,
    this.currency,
  });

  String? userId;
  String? subscriptionId;
  String? planName;
  String? planPrice;
  String? planStatus;
  bool? isApprovedByAdmin;
  Timestamp? dateCreated;
  String? subscriptionID;
  String? customerID;
  String? currency;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        userId: json["userID"],
        subscriptionId: json["subscriptionId"],
        planName: json["planName"],
        planPrice: json["planPrice"],
        planStatus: json["planStatus"],
        isApprovedByAdmin: json["isApprovedByAdmin"],
        dateCreated: json["dateCreated"],
        subscriptionID: json["subscriptionID"],
        customerID: json["customerID"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "userID": docID,
        "subscriptionId": subscriptionId,
        "planName": planName,
        "planPrice": planPrice,
        "planStatus": planStatus,
        "isApprovedByAdmin": isApprovedByAdmin,
        "dateCreated": dateCreated,
        "subscriptionID": subscriptionID,
        "customerID": customerID,
        "currency": currency,
      };
}
