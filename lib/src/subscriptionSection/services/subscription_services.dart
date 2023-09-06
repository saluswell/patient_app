import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/helperFunctions/showsnackbar.dart';
import '../../../common/utils/api_endpoints.dart';
import '../models/subscription_products_model.dart';

class SubscriptionService {
  String publishableKey =
      "pk_test_51InnRlIdxBCh70xgnPUTMKldbyysNjJNLe2uEhm9K11SnVDbfZMtyxafZXevuQV1TbWqlkulNwxN3KTfi4iCADcq00yJ1Hj6vG";

  //  "pk_test_51NkgkmBmOOZYrDNBuyuSrPHED0SDqdlfU4zO4c7xaTdhwiFMoBsXoOVUel1HocjYM5lBWy30UViEZ7MI7UtBG2q800Mgq7WxlI";
  static String secretKey =
      "sk_test_51InnRlIdxBCh70xgaKAYuLVmO8DujZuSHV8y2P2dligGO0tbeNvhO7DKubYmF1YrnwjOTBFsH84u0XuckRJHi3Mg00usIiiw3f";

  //"sk_test_51NkgkmBmOOZYrDNBdo5ng6vYQpAk6UwkiclSGmptLCsPrQLTttEu5SxQ5vSO5hs7LTTHNH9kAWiJzhXrUBPLY4oB00NTkRxoV7";

  void _init() {
    Stripe.publishableKey = publishableKey ?? '';
  }

  final client = http.Client();
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${secretKey}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  Future<Map<String, dynamic>> _createCustomer(String customerName) async {
    const String url = 'https://api.stripe.com/v1/customers';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {'description': customerName},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a customer.';
    }
  }

  // Future<Map<String, dynamic>> _createPaymentMethod(
  //     {required String number,
  //     required String expMonth,
  //     required String expYear,
  //     required String cvc}) async {
  //   const String url = 'https://api.stripe.com/v1/payment_methods';
  //   var response = await client.post(
  //     Uri.parse(url),
  //     headers: headers,
  //     body: {
  //       'type': 'card',
  //       'card[number]': '$number',
  //       'card[exp_month]': '$expMonth',
  //       'card[exp_year]': '$expYear',
  //       'card[cvc]': '$cvc',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     print(json.decode(response.body));
  //     throw 'Failed to create PaymentMethod.';
  //   }
  // }
  String? paymentMethodId;

  createPaymentMethod(
      {required String number,
      required int expMonth,
      required int expYear,
      required String cvc}) async {
    CardDetails cardDetails = CardDetails(
        number: number,
        expirationYear: expYear,
        expirationMonth: expMonth,
        cvc: cvc);
    await Stripe.instance.dangerouslyUpdateCardDetails(cardDetails);
    final billingDetails = BillingDetails();
    final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
            paymentMethodData:
                PaymentMethodData(billingDetails: billingDetails)));

    paymentMethodId = paymentMethod.id;

    //Stripe.instance.createToken(params);
  }

  Future<Map<String, dynamic>> _attachPaymentMethod(
      String paymentMethodId, String customerId) async {
    final String url =
        'https://api.stripe.com/v1/payment_methods/$paymentMethodId/attach';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'customer': customerId,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to attach PaymentMethod.';
    }
  }

  Future<Map<String, dynamic>> _updateCustomer(
      String paymentMethodId, String customerId) async {
    final String url = 'https://api.stripe.com/v1/customers/$customerId';

    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'invoice_settings[default_payment_method]': paymentMethodId,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to update Customer.';
    }
  }

  Future<Map<String, dynamic>> _createSubscriptions(
      String customerId, String defaultPrice) async {
    const String url = 'https://api.stripe.com/v1/subscriptions';

    Map<String, dynamic> body = {
      'customer': customerId,
      'items[0][price]': defaultPrice,
    };

    var response =
        await client.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      dp(msg: "subscription status", arg: json.decode(response.body));
      showSnackBarMessage(
          context: navstate.currentState!.context,
          content: "Subscription Activated Successfully");
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a subscriber.';
    }
  }

  Future<Map<String, dynamic>> getSubscriptionPlans() async {
    const String url = 'https://api.stripe.com/v1/products';

    var response = await client.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(response.body.toString());
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a subscriber.';
    }
  }

  Future<void> subscriptions({
    required String cardNumber,
    required int expMonth,
    required int expYear,
    required String cvc,
    required String defaultPrice,
  }) async {
    _init();
    final customer = await _createCustomer("Sohaib");
    final _paymentMethod = await createPaymentMethod(
        number: cardNumber, expMonth: expMonth, expYear: expYear, cvc: cvc);
    await _attachPaymentMethod(paymentMethodId.toString(), customer['id']);
    await _updateCustomer(paymentMethodId.toString(), customer['id']);
    await _createSubscriptions(customer['id'], defaultPrice);
  }

  ///-------------------------------- Subscription   Products Section -------------------------------------------

  Future<SubscriptionProductsModel?> getSubscriptionProducts() async {
    try {
      http.Response? response = await client.get(
        Uri.parse(Apis.products),
        headers: headers,
      );
      // var jsonResponse = jsonDecode(response.data);
      if (response.statusCode == 200) {
        dp(msg: "get Subscription products data", arg: response.body);
      } else {
        dp(msg: "Something went wrong");
      }

      // return
      return SubscriptionProductsModel.fromJson(json.decode(response.body));
    } on Exception catch (e) {
      dp(msg: "Exception", arg: e.toString());
      // TODO
    }
  }
}
