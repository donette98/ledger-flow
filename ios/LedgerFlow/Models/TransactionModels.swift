import Foundation

struct Transaction: Codable {
    let id: String
    let userId: String
    let type: String // "income" or "expense"
    let category: String
    let amount: Double
    let currency: String
    let description: String
    let date: Date
    let attachmentUrl: String?
    let createdAt: Date
    
    init(
        id: String = UUID().uuidString,
        userId: String,
        type: String,
        category: String,
        amount: Double,
        currency: String,
        description: String,
        date: Date = Date(),
        attachmentUrl: String? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.type = type
        self.category = category
        self.amount = amount
        self.currency = currency
        self.description = description
        self.date = date
        self.attachmentUrl = attachmentUrl
        self.createdAt = createdAt
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "id": id,
            "userId": userId,
            "type": type,
            "category": category,
            "amount": amount,
            "currency": currency,
            "description": description,
            "date": date,
            "createdAt": createdAt
        ]
        if let url = attachmentUrl {
            dict["attachmentUrl"] = url
        }
        return dict
    }
}

struct MonthlyReport: Codable {
    let month: String
    let totalIncome: Double
    let totalExpense: Double
    let balance: Double
    let categories: [String]
}
