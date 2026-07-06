import 'package:uuid/uuid.dart';

class Transaction {
  final String id;
  final String userId;
  final String type; // 'income', 'expense'
  final String category;
  final double amount;
  final String currency;
  final String description;
  final DateTime date;
  final String? attachmentUrl;
  final DateTime createdAt;

  Transaction({
    String? id,
    required this.userId,
    required this.type,
    required this.category,
    required this.amount,
    required this.currency,
    required this.description,
    DateTime? date,
    this.attachmentUrl,
    DateTime? createdAt,
  })
      : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'category': category,
      'amount': amount,
      'currency': currency,
      'description': description,
      'date': date.toIso8601String(),
      'attachmentUrl': attachmentUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      category: json['category'],
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      attachmentUrl: json['attachmentUrl'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class MonthlyReport {
  final String month;
  final double totalIncome;
  final double totalExpense;
  final double balance;
  final List<String> categories;

  MonthlyReport({
    required this.month,
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
    required this.categories,
  });
}
