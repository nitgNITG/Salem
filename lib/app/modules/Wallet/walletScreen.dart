import 'dart:convert';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/data/shared_preferences/sharedpreference_service.dart';
import '../../utils/helper_funcs.dart';
import 'model.dart';
import 'package:http/http.dart'as http;

class Walletscreen extends StatefulWidget {
  const Walletscreen({super.key});

  @override
  State<Walletscreen> createState() => _WalletscreenState();
}

class _WalletscreenState extends State<Walletscreen> {
  String wallet_uuid = '';
  String balance = '0'; // Initialize balance

  @override
  void initState() {
    super.initState();
    _retrieveUserData();
  }

  Future<void> _retrieveUserData() async {
    Map<String, dynamic> userData = await SharedPreferencesService.instance.getUserData();

    setState(() {
      wallet_uuid = '${userData['wallet_uuid']}';
      print('******************************************');
      print(wallet_uuid);
      balance ='${userData['balance']}';
    });

    // Fetch wallet details after retrieving wallet_uuid
    if (wallet_uuid.isNotEmpty) {
      fetchWalletDetails(wallet_uuid);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          NormalAppBar(
            title:  getL10(context).wallet,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text(
                    '${getL10(context).balance}: $balance ${ getL10(context).egp}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchWalletDetails(String walletUuid) async {
    final String url = 'https://salem-mar3y.com/e-wallet/src/api/getwallet_mobile.php';

    // Create request body
    final String body = jsonEncode({'wallet_uuid': walletUuid});

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Debugging: Print response status and body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'success') {
          // Create WalletResponse instance
          WalletResponse walletResponse = WalletResponse.fromJson(jsonResponse);
          setState(() {
            balance = walletResponse.data.balance; // Set balance from response
          });
          print(balance);
          // Process successful response
          print('Wallet details fetched successfully: $walletResponse');
        } else {
          // Handle API error
          print('API Error: ${jsonResponse['message']}');
        }
      } else {
        print('Failed to load wallet details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

}
