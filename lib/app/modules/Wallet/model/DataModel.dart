class Transaction {
  final String id;
  final String uuid;
  final String walletUuid;
  final String type;
  final String amount;
  final String description;
  final String status;
  final String isRefund;
  final String createdAt;

  Transaction({
    required this.id,
    required this.uuid,
    required this.walletUuid,
    required this.type,
    required this.amount,
    required this.description,
    required this.status,
    required this.isRefund,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      uuid: json['uuid'],
      walletUuid: json['wallet_uuid'],
      type: json['type'],
      amount: json['amount'],
      description: json['description'],
      status: json['status'],
      isRefund: json['is_refund'],
      createdAt: json['created_at'],
    );
  }
}

class ApiResponse {
  final String status;
  final String message;
  final List<Transaction> transactions;

  ApiResponse({
    required this.status,
    required this.message,
    required this.transactions,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var transactionList = json['data'] as List;
    List<Transaction> transactions = transactionList.map((i) => Transaction.fromJson(i)).toList();

    return ApiResponse(
      status: json['status'],
      message: json['message'],
      transactions: transactions,
    );
  }
}
