import 'dart:convert';
import 'package:http/http.dart' as http;

class WalletResponse {
  String status;
  String message;
  WalletData data;

  WalletResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
      status: json['status'],
      message: json['message'],
      data: WalletData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class WalletData {
  String id;
  String uuid;
  String balance;
  String status;
  String createdAt;
  String platformUuid;
  String totalTransactions;
  dynamic rechargeTransactions;
  dynamic paymentTransactions;
  dynamic transferTransactions;

  WalletData({
    required this.id,
    required this.uuid,
    required this.balance,
    required this.status,
    required this.createdAt,
    required this.platformUuid,
    required this.totalTransactions,
    this.rechargeTransactions,
    this.paymentTransactions,
    this.transferTransactions,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) {
    return WalletData(
      id: json['id'],
      uuid: json['uuid'],
      balance: json['balance'],
      status: json['status'],
      createdAt: json['created_at'],
      platformUuid: json['platform_uuid'],
      totalTransactions: json['total_transactions'],
      rechargeTransactions: json['recharge_transactions'],
      paymentTransactions: json['payment_transactions'],
      transferTransactions: json['transfer_transactions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'balance': balance,
      'status': status,
      'created_at': createdAt,
      'platform_uuid': platformUuid,
      'total_transactions': totalTransactions,
      'recharge_transactions': rechargeTransactions,
      'payment_transactions': paymentTransactions,
      'transfer_transactions': transferTransactions,
    };
  }

}
