// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:stripe_payment/stripe_payment.dart';
// import 'dart:io';



// class Payment extends StatefulWidget {
//   const Payment({Key? key}) : super(key: key);

//   @override
//   _PaymentState createState() => _PaymentState();
// }

// class _PaymentState extends State<Payment> {
//   Token? _paymentToken;
//    PaymentMethod? _paymentMethod;
//   String _error="Error";
//   final String _currentSecret = "Your_Secret_key"; //set this yourself, e.g using curl
//    PaymentIntentResult? _paymentIntent;
//    Source? _source;

//   final ScrollController _controller = ScrollController();

//   final CreditCard testCard = CreditCard(
//     number: '4111111111111111',
//     expMonth: 08,
//     expYear: 22,
//   );

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

//   @override
//   initState() {
//     super.initState();

//     StripePayment.setOptions(
//         StripeOptions(publishableKey: "Your_Publish_key",
//             merchantId: "Your_Merchant_id",
//             androidPayMode: 'test'));
//   }

//   void setError(dynamic error) {
//     _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(error.toString())));
//     setState(() {
//       _error = error.toString();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[800],
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: const Text('Stripe Payment Demo',),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.clear),
//             onPressed: () {
//               setState(() {
//                 // _source = '';
//                 // _paymentIntent = null;
//                 // _paymentMethod = null;
//                 // _paymentToken = null;
//               });
//             },
//           )
//         ],
//       ),
//       body: ListView(
//         controller: _controller,
//         padding: const EdgeInsets.all(20),
//         children: <Widget>[
//           TextButton(
//             child: const Text("Create Source"),
//             onPressed: () {
//               StripePayment.createSourceWithParams(SourceParams(
//                 type: 'ideal',
//                 amount: 2102,
//                 currency: 'eur',
//                 returnURL: 'example://stripe-redirect',
//               )).then((source) {
//                 _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text('Received ${source.sourceId}')));
//                 setState(() {
//                   _source = source;
//                 });
//               }).catchError(setError);
//             },
//           ),
//           const Divider(),
//           TextButton(
//             child: const Text("Create Token with Card Form"),
//             onPressed: () {
//               StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest()).then((paymentMethod) {
//                 _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text('Received ${paymentMethod.id}')));
//                 setState(() {
//                   _paymentMethod = paymentMethod;
//                 });
//               }).catchError(setError);
//             },
//           ),
//           TextButton(
//             child: const Text("Create Token with Card"),
//             onPressed: () {
//               StripePayment.createTokenWithCard(
//                 testCard,
//               ).then((token) {
//                 _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text('Received ${token.tokenId}')));
//                 setState(() {
//                   _paymentToken = token;
//                 });
//               }).catchError(setError);
//             },
//           ),
//           const Divider(),
//           TextButton(
//             child: const Text("Create Payment Method with Card"),
//             onPressed: () {
//               StripePayment.createPaymentMethod(
//                 PaymentMethodRequest(
//                   card: testCard,
//                 ),
//               ).then((paymentMethod) {
//                 _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text('Received ${paymentMethod.id}')));
//                 setState(() {
//                   _paymentMethod = paymentMethod;
//                 });
//               }).catchError(setError);
//             },
//           ),
//           TextButton(
//             child: const Text("Create Payment Method with existing token"),
//             onPressed: _paymentToken == null
//                 ? null
//                 : () {
//               StripePayment.createPaymentMethod(
//                 PaymentMethodRequest(
//                   card: CreditCard(
//                     token: _paymentToken!.tokenId,
//                   ),
//                 ),
//               ).then((paymentMethod) {
//                 _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text('Received ${paymentMethod.id}')));
//                 setState(() {
//                   _paymentMethod = paymentMethod;
//                 });
//               }).catchError(setError);
//             },
//           ),
//           const Divider(),
//           TextButton(
//             child: const Text("Confirm Payment Intent"),
//             onPressed: _paymentMethod == null
//                 ? null
//                 : () {
//               StripePayment.confirmPaymentIntent(
//                 PaymentIntent(
//                   clientSecret: _currentSecret,
//                   paymentMethodId: _paymentMethod!.id,
//                 ),
//               ).then((paymentIntent) {
//                 _scaffoldKey.currentState
//                     !.showSnackBar(SnackBar(content: Text('Received ${paymentIntent.paymentIntentId}')));
//                 setState(() {
//                   _paymentIntent = paymentIntent;
//                 });
//               }).catchError(setError);
//             },
//           ),
//           TextButton(
//             child:const Text("Authenticate Payment Intent"),
//             onPressed: _currentSecret ==null
//                 ? null
//                 : () {
//               StripePayment.authenticatePaymentIntent(clientSecret: _currentSecret).then((paymentIntent) {
//                 _scaffoldKey.currentState
//                     !.showSnackBar(SnackBar(content: Text('Received ${paymentIntent.paymentIntentId}')));
//                 setState(() {
//                   _paymentIntent = paymentIntent;
//                 });
//               }).catchError(setError);
//             },
//           ),
//           const Divider(),
//           TextButton(
//             child: Text("Native payment"),
//             onPressed: () {
//               if (Platform.isIOS) {
//                 _controller.jumpTo(450);
//               }
//               StripePayment.paymentRequestWithNativePay(
//                 androidPayOptions: AndroidPayPaymentRequest(
//                   totalPrice: "2.40",
//                   currencyCode: "EUR",
//                 ),
//                 applePayOptions: ApplePayPaymentOptions(
//                   countryCode: 'DE',
//                   currencyCode: 'EUR',
//                   items: [
//                     ApplePayItem(
//                       label: 'Test',
//                       amount: '27',
//                     )
//                   ],
//                 ),
//               ).then((token) {
//                 setState(() {
//                   _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text('Received ${token.tokenId}')));
//                   _paymentToken = token;
//                 });
//               }).catchError(setError);
//             },
//           ),
//           TextButton(
//             child:const Text("Complete Native Payment"),
//             onPressed: () {
//               StripePayment.completeNativePayRequest().then((_) {
//                 _scaffoldKey.currentState!.showSnackBar(const SnackBar(content: Text('Completed successfully')));
//               }).catchError(setError);
//             },
//           ),
//          const Divider(),
//           const Text('Current source:'),
//           //  Text(
//           //   const JsonEncoder.withIndent('  ').convert(_source!.toJson()),
//           //   style: const TextStyle(fontFamily: "Monospace"),
//           // ),
//           const Divider(),
//           const Text('Current token:'),
//           // Text(
//           //   const JsonEncoder.withIndent('  ').convert(_paymentToken!.toJson()),
//           //   style: const TextStyle(fontFamily: "Monospace"),
//           // ),
//           const Divider(),
//           const Text('Current payment method:'),
//           // Text(
//           //   const JsonEncoder.withIndent('  ').convert(_paymentMethod!.toJson()),
//           //   style: const TextStyle(fontFamily: "Monospace"),
//           // ),
//           const Divider(),
//           const Text('Current payment intent:'),
//           // Text(
//           //   const JsonEncoder.withIndent('  ').convert(_paymentIntent!.toJson()),
//           //   style: const TextStyle(fontFamily: "Monospace"),
//           // ),
//           const Divider(),
//           Text('Current error: $_error'),
//         ],
//       ),
//     );
//   }
// }