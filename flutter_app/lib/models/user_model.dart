import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String email;
  final String name;
  final String accountType; // 'individual' or 'company'
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool emailVerified;

  User({
    String? id,
    required this.email,
    required this.name,
    required this.accountType,
    required this.currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.emailVerified = false,
  })
      : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'accountType': accountType,
      'currency': currency,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'emailVerified': emailVerified,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      accountType: json['accountType'],
      currency: json['currency'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      emailVerified: json['emailVerified'] ?? false,
    );
  }
}

class CompanyUser {
  final String id;
  final String companyId;
  final String email;
  final String name;
  final String role; // 'admin', 'manager', 'accountant', 'viewer'
  final DateTime createdAt;
  final bool isActive;

  CompanyUser({
    String? id,
    required this.companyId,
    required this.email,
    required this.name,
    required this.role,
    DateTime? createdAt,
    this.isActive = true,
  })
      : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'email': email,
      'name': name,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  factory CompanyUser.fromJson(Map<String, dynamic> json) {
    return CompanyUser(
      id: json['id'],
      companyId: json['companyId'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      isActive: json['isActive'] ?? true,
    );
  }
}
