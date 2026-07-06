import 'package:uuid/uuid.dart';

class InventoryItem {
  final String id;
  final String userId;
  final String name;
  final String description;
  final int quantity;
  final double unitPrice;
  final String unit; // 'pcs', 'kg', 'liters', etc.
  final String category;
  final String? sku;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  InventoryItem({
    String? id,
    required this.userId,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.unit,
    required this.category,
    this.sku,
    this.imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  })
      : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'unit': unit,
      'category': category,
      'sku': sku,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'].toDouble(),
      unit: json['unit'],
      category: json['category'],
      sku: json['sku'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class InventoryTransaction {
  final String id;
  final String inventoryItemId;
  final String type; // 'in', 'out'
  final int quantity;
  final String reason; // 'purchase', 'sale', 'damage', 'return'
  final String? reference; // Transaction ID or order reference
  final DateTime date;
  final DateTime createdAt;

  InventoryTransaction({
    String? id,
    required this.inventoryItemId,
    required this.type,
    required this.quantity,
    required this.reason,
    this.reference,
    DateTime? date,
    DateTime? createdAt,
  })
      : id = id ?? const Uuid().v4(),
        date = date ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inventoryItemId': inventoryItemId,
      'type': type,
      'quantity': quantity,
      'reason': reason,
      'reference': reference,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory InventoryTransaction.fromJson(Map<String, dynamic> json) {
    return InventoryTransaction(
      id: json['id'],
      inventoryItemId: json['inventoryItemId'],
      type: json['type'],
      quantity: json['quantity'],
      reason: json['reason'],
      reference: json['reference'],
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
