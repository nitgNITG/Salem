// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class PaymobService {
//   final String apiKey; // Use environment variables for sensitive info
//   final String integrationId;
//   final String merchantId;
//
//   PaymobService({
//     required this.apiKey,
//     required this.integrationId,
//     required this.merchantId,
//   });
//
//   Future<String> createOrder(double amount) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://accept.paymobsolutions.com/api/ecommerce/orders'),
//         headers: {
//           'Authorization': 'Bearer $apiKey',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'amount_cents': (amount * 100).toInt(),
//           'currency': 'EGP',
//           'merchant_id': merchantId,
//           'items': [], // Include items if necessary
//         }),
//       );
//
//       if (response.statusCode != 200) {
//         throw Exception('Failed to create order: ${response.body}');
//       }
//
//       final orderData = json.decode(response.body);
//       return orderData['id'];
//     } catch (e) {
//       // Handle network errors, serialization errors, etc.
//       throw Exception('Error creating order: $e');
//     }
//   }
//
//   Future<String> createPaymentKey(String orderId, double amount) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://api.paymob.com/api/acceptance/payment_keys'),
//         headers: {
//           'Authorization': 'Bearer $apiKey',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'amount_cents': (amount * 100).toInt(),
//           'currency': 'EGP',
//           'integration_id': integrationId,
//           'order_id': orderId,
//           'expiration': 3600, // 1 hour expiration
//         }),
//       );
//
//       if (response.statusCode != 200) {
//         throw Exception('Failed to create payment key: ${response.body}');
//       }
//
//       final paymentData = json.decode(response.body);
//       return paymentData['id'];
//     } catch (e) {
//       throw Exception('Error creating payment key: $e');
//     }
//   }
//
//   String getPaymentUrl(String paymentKey) {
//     return 'https://accept.paymob.com/api/acceptance/iframes/$integrationId?payment_token=$paymentKey';
//   }
// }
