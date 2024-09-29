//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'PaymobService.dart';
//
// class PaymobHome extends StatefulWidget {
//   @override
//   _PaymobHomeState createState() => _PaymobHomeState();
// }
//
// class _PaymobHomeState extends State<PaymobHome> {
//   final PaymobService paymobService = PaymobService(
//     apiKey: 'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RnNU9UQXdMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuTGRUZnhQVkhFODNvc0lJdXRERzFnaWhwU3hpUEJGeVhoRm1Ra2k3OTBlY3JtNXNxRUY5WVpFMGROcUxWdDBQYno4azNDTEs4cmNkNk5PVlNfcEw0N3c=', // Replace with your actual API key
//     integrationId: '4628698', // Replace with your actual Integration ID
//     merchantId: '990737', // Replace with your actual Merchant ID
//   );
//
//   String orderId = '';
//   String errorMessage = '';
//
//   void _createOrder() async {
//     setState(() {
//       errorMessage = ''; // Clear previous error messages
//     });
//
//     try {
//       String createdOrderId = await paymobService.createOrder(100.0); // Specify the amount
//       setState(() {
//         orderId = createdOrderId; // Update the order ID state
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString(); // Capture any error messages
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Paymob Integration')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _createOrder,
//               child: Text('Create Order'),
//             ),
//             SizedBox(height: 20),
//             if (orderId.isNotEmpty)
//               Text('Order ID: $orderId', style: TextStyle(fontSize: 20)),
//             if (errorMessage.isNotEmpty)
//               Text('Error: $errorMessage', style: TextStyle(color: Colors.red)),
//
//           ],
//         ),
//       ),
//     );
//   }
// }