import 'dart:core';
import 'package:flutter/material.dart';
import 'package:look/paymentgateway/paypalservice.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaypalPayment extends StatefulWidget {
  final Function onFinish;

  const PaypalPayment({Key? key, required this.onFinish}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   String? checkoutUrl='';
   String? executeUrl;
String? accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic,dynamic> defaultCurrency = {"symbol": "USD ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "USD"};

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL= 'cancel.example.com';
bool loaded=false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {

    //  try {
try {
  accessToken = (await services.getAccessToken());
  print("Khannf ${services.getAccessToken().toString()}");

  print("afjkajdnf");
}catch(e)
      {
        print("Kh");
        print(e.toString());
      }



// try{
// print("typetransact ${transactions.runtimeType}");
// print(accessToken);
// print(" typeaceess ${accessToken.runtimeType}");
//   var res = await services.createPaypalPayment(transactions, accessToken) as Uri;
//   print("Result: $res");
// }catch(e)
//       {
//         print("Ha");
//         print(e.toString());
//       }

        // if (res != null) {
        //   setState(() {
        //     checkoutUrl = res["approvalUrl"] ;
        //     executeUrl = res["executeUrl"] ;
        //     loaded=true;
        //   });
        // }
  //    }
  //     catch (e) {
  //       print('exceeptionn: '+e.toString());
  //       final snackBar = SnackBar(
  //         content: Text(e.toString()),
  //         duration: const Duration(seconds: 10),
  //         action: SnackBarAction(
  //           label: 'Close',
  //           onPressed: () {
  //             // Some code to undo the change.
  //           },
  //         ),
  //       );
  //       _scaffoldKey.currentState!.showSnackBar(snackBar);
  //     }
    });
  }

  // item name, price and quantity
  String itemName = 'iPhone X';
  String itemPrice = '1.99';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": itemPrice,
        "currency": defaultCurrency["currency"]
      }
    ];


    // checkout invoice details
    String totalAmount = '1.99';
    String subTotalAmount = '1.99';
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'Gulshan';
    String userLastName = 'Yadav';
    String addressCity = 'Delhi';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'India';
    String addressState = 'Delhi';
    String addressPhoneNumber = '+919990119091';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount":
              ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping &&
                isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName +
                    " " +
                    userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": returnURL,
        "cancel_url": cancelURL
      }
    };

    return temp;
  }

  @override
  Widget build(BuildContext context) {
   if(loaded==true)
     {
       print(checkoutUrl);
     }

    if (checkoutUrl != '') {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
  }
}