import 'package:flutter/cupertino.dart';
import 'package:saluswell_patient_updated/common/helperFunctions/navigatorHelper.dart';
import 'package:saluswell_patient_updated/common/helperFunctions/showsnackbar.dart';
import 'package:saluswell_patient_updated/src/subscriptionSection/models/subscription_products_model.dart';
import 'package:saluswell_patient_updated/src/subscriptionSection/services/subscription_services.dart';

class SubscriptionProvider extends ChangeNotifier {
  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  makeLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  SubscriptionProductsModel? subscriptionProductsModel;

  SubscriptionService subscriptionService = SubscriptionService();

  getSubscriptionProductsProvider() async {
    try {
      Future.delayed(const Duration(milliseconds: 10)).whenComplete(() async {
        makeLoadingTrue();

        subscriptionProductsModel = await subscriptionService
            .getSubscriptionProducts()
            .whenComplete(() {
          makeLoadingFalse();
        });

        notifyListeners();
      });
    } on Exception catch (e) {
      makeLoadingFalse();
      showSnackBarMessage(
        content: e.toString(),
        context: navstate.currentState!.context,
      );
      // TODO
    }
  }

  ///-----------------------------subscription section-------------------------

  createSubscription({
    required String cardNumber,
    required int expMonth,
    required int expYear,
    required String cvc,
    required String defaultPrice,
    required String planName,
    required String planPrice,
  }) async {
    try {
      Future.delayed(const Duration(milliseconds: 10)).whenComplete(() async {
        makeLoadingTrue();

        await subscriptionService
            .subscriptions(
                cardNumber: cardNumber,
                expMonth: expMonth,
                expYear: expYear,
                cvc: cvc,
                defaultPrice: defaultPrice,
                planName: planName,
                planePrice: planPrice)
            .whenComplete(() {
          makeLoadingFalse();
        });

        notifyListeners();
      });
    } on Exception catch (e) {
      makeLoadingFalse();
      showSnackBarMessage(
        content: e.toString(),
        context: navstate.currentState!.context,
      );
      // TODO
    }
  }

  ///cancel subscription provider
  cancelSubscriptionProvider(String subscriptionID) async {
    try {
      Future.delayed(const Duration(milliseconds: 10)).whenComplete(() async {
        makeLoadingTrue();

        await subscriptionService
            .cancelSubscription(subscriptionID)
            .whenComplete(() {
          makeLoadingFalse();
        });

        notifyListeners();
      });
    } on Exception catch (e) {
      makeLoadingFalse();
      showSnackBarMessage(
        content: e.toString(),
        context: navstate.currentState!.context,
      );
      // TODO
    }
  }
}
