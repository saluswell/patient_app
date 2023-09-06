import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:saluswell_patient_updated/common/helperFunctions/showsnackbar.dart';
import 'package:saluswell_patient_updated/common/widgets/button_widget.dart';
import 'package:saluswell_patient_updated/src/subscriptionSection/models/subscription_products_model.dart';
import 'package:saluswell_patient_updated/src/subscriptionSection/providers/subscription_provider.dart';
import 'package:saluswell_patient_updated/src/subscriptionSection/services/subscription_services.dart';

import '../../../common/utils/appcolors.dart';

class AddCardInformation extends StatefulWidget {
  final ProductsDatum productsDatum;

  const AddCardInformation({Key? key, required this.productsDatum})
      : super(key: key);

  @override
  State<AddCardInformation> createState() => _AddCardInformationState();
}

class _AddCardInformationState extends State<AddCardInformation> {
  final _formKey = GlobalKey<FormState>();

  CardEditController cardEditController = CardEditController();
  SubscriptionService subscriptionService = SubscriptionService();

  CardFieldInputDetails? cardFieldInputDetails;

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
            title: Text("Add Card Information"),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CardField(
                  dangerouslyGetFullCardDetails: true,
                  dangerouslyUpdateFullCardDetails: true,
                  enablePostalCode: false,
                  // onCardChanged: (val) {
                  //   setState(() {
                  //     cardFieldInputDetails = val;
                  //   });
                  // },
                  controller: cardEditController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Card Information',
                      hintText: "Card Holder Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black)),
                ),
              ),

              SizedBox(
                height: 50,
              ),
              // CreditCardForm(
              //
              //     cardNumber: "cardNumber",
              //     cardHolderValidator: (),
              //     cardNumberDecoration:
              //         InputDecoration(border: OutlineInputBorder()),
              //     expiryDate: "expiryDate",
              //     expiryDateDecoration:
              //         InputDecoration(border: OutlineInputBorder()),
              //     cardHolderName: "cardHolderName",
              //     cardHolderDecoration:
              //         InputDecoration(border: OutlineInputBorder()),
              //     cvvCode: "cvvCode",
              //     onCreditCardModelChange: (val) {},
              //     themeColor: Colors.green,
              //     formKey: _formKey),
              CommonButtonWidget(
                  text: "Pay",
                  onTap: () {
                    if (cardEditController.complete) {
                      //cardFieldInputDetails.
                      subscriptionProvider.createSubscription(
                        cardNumber:
                            cardEditController.details.number.toString(),
                        expMonth: cardEditController.details.expiryMonth!,
                        expYear: cardEditController.details.expiryYear!,
                        cvc: cardEditController.details.cvc.toString(),
                        defaultPrice:
                            widget.productsDatum.defaultPrice.toString(),
                      );
                    } else {
                      showSnackBarMessage(
                          context: context,
                          backgroundcolor: AppColors.redcolor,
                          content: "Please Enter Complete Card Details");
                    }
                  })
            ],
          ),
        ),
      );
    });
  }
}
