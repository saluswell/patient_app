import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/firebaseUtils.dart';
import '../models/paymentModel.dart';

class PaymentServices {
  ///Create payment
  Future createPayment(PaymentModel paymentModel) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(FirebaseUtils.paymenthistory)
        .doc(paymentModel.paymentId);
    return await docRef.set(paymentModel.toJson(docRef.id));
  }
}
