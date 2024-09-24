import 'package:http/http.dart' as http;
import 'dart:convert';

import 'DataModel.dart';


class ApiService {
  static const String apiUrl = "https://salem-mar3y.com/e-wallet/src/api/gettransactions_mobile.php";

  Future<ApiResponse?> fetchTransactions(String walletUuid) async {
    final String body = jsonEncode({'wallet_uuid': walletUuid});
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ApiResponse.fromJson(jsonData);
    } else {
      throw Exception("Failed to load transactions");
    }
  }
}
