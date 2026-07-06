import Foundation

struct InventoryItem: Codable {
    let id: String
    let userId: String
    let name: String
    let description: String
    let quantity: Int
    let unitPrice: Double
    let unit: String // "pcs", "kg", "liters", etc.
    let category: String
    let sku: String?
    let imageUrl: String?
    let createdAt: Date
    let updatedAt: Date
    
    init(
        id: String = UUID().uuidString,
        userId: String,
        name: String,
        description: String,
        quantity: Int,
        unitPrice: Double,
        unit: String,
        category: String,
        sku: String? = nil,
        imageUrl: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.name = name
        self.description = description
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.unit = unit
        self.category = category
        self.sku = sku
        self.imageUrl = imageUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "id": id,
            "userId": userId,
            "name": name,
            "description": description,
            "quantity": quantity,
            "unitPrice": unitPrice,
            "unit": unit,
            "category": category,
            "createdAt": createdAt,
            "updatedAt": updatedAt
        ]
        if let sku = sku {
            dict["sku"] = sku
        }
        if let url = imageUrl {
            dict["imageUrl"] = url
        }
        return dict
    }
}

struct InventoryTransaction: Codable {
    let id: String
    let inventoryItemId: String
    let type: String // "in" or "out"
    let quantity: Int
    let reason: String // "purchase", "sale", "damage", "return"
    let reference: String?
    let date: Date
    let createdAt: Date
    
    init(
        id: String = UUID().uuidString,
        inventoryItemId: String,
        type: String,
        quantity: Int,
        reason: String,
        reference: String? = nil,
        date: Date = Date(),
        createdAt: Date = Date()
    ) {
        self.id = id
        self.inventoryItemId = inventoryItemId
        self.type = type
        self.quantity = quantity
        self.reason = reason
        self.reference = reference
        self.date = date
        self.createdAt = createdAt
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "id": id,
            "inventoryItemId": inventoryItemId,
            "type": type,
            "quantity": quantity,
            "reason": reason,
            "date": date,
            "createdAt": createdAt
        ]
        if let ref = reference {
            dict["reference"] = ref
        }
        return dict
    }
}
