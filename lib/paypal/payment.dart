// import 'package:flutter/material.dart';
// import 'package:flutter_braintree/flutter_braintree.dart';
//
//
//
// class Paypal extends StatefulWidget {
//   const Paypal({Key? key}) : super(key: key);
//
//   @override
//   _PaypalState createState() => _PaypalState();
// }
//
// class _PaypalState extends State<Paypal> {
//   static const String tokenizationKey = 'sandbox_yk9m564n_cnms3gp4ww9s8v4p';
//
//   void showNonce(BraintreePaymentMethodNonce nonce) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Payment method nonce:'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Text('Nonce: ${nonce.nonce}'),
//             const SizedBox(height: 16),
//             Text('Type label: ${nonce.typeLabel}'),
//             const SizedBox(height: 16),
//             Text('Description: ${nonce.description}'),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Braintree example app'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () async {
//                 var request = BraintreeDropInRequest(
//                   tokenizationKey: tokenizationKey,
//                   collectDeviceData: true,
//                   googlePaymentRequest: BraintreeGooglePaymentRequest(
//                     totalPrice: '4.20',
//                     currencyCode: 'USD',
//                     billingAddressRequired: false,
//                   ),
//                   paypalRequest: BraintreePayPalRequest(
//                     amount: '4.20',
//                     displayName: 'Example company',
//                   ),
//                   cardEnabled: true,
//                 );
//                 final result = await BraintreeDropIn.start(request);
//                 if (result != null) {
//                   showNonce(result.paymentMethodNonce);
//                 }
//               },
//               child: const Text('LAUNCH NATIVE DROP-IN'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//
//                 final request = BraintreeCreditCardRequest(
//                   cardNumber: '5555555555554444',
//                   expirationMonth: '12',
//                   expirationYear: '2026',
//                   cvv: '123',
//                 );
//                 final result = await Braintree.tokenizeCreditCard(
//                   'sandbox_yk9m564n_cnms3gp4ww9s8v4p',
//                   request,
//                 );
//                 print("khan");
//                 if (result != null) {
//                   showNonce(result);
//                 }
//               },
//               child: const Text('TOKENIZE CREDIT CARD'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//
//                 final request = BraintreePayPalRequest(amount: '50.00');
//
//                 final result = await Braintree.requestPaypalNonce(
//                   tokenizationKey,
//                   request,
//                 );
//                 if (result != null) {
//                   showNonce(result);
//                 }
//
//               },
//               child: const Text('PAYPAL VAULT FLOW'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final request = BraintreePayPalRequest(amount: '13.37');
//                 final result = await Braintree.requestPaypalNonce(
//                   tokenizationKey,
//                   request,
//                 );
//                 if (result != null) {
//                   showNonce(result);
//                 }
//               },
//               child: const Text('PAYPAL CHECKOUT FLOW'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }