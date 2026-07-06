import Foundation
import FirebaseAuth
import FirebaseFirestore

class User: Codable {
    let id: String
    let email: String
    let name: String
    let accountType: String // "individual" or "company"
    let currency: String
    let createdAt: Date
    let updatedAt: Date
    let emailVerified: Bool
    
    init(
        id: String = UUID().uuidString,
        email: String,
        name: String,
        accountType: String,
        currency: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        emailVerified: Bool = false
    ) {
        self.id = id
        self.email = email
        self.name = name
        self.accountType = accountType
        self.currency = currency
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.emailVerified = emailVerified
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "email": email,
            "name": name,
            "accountType": accountType,
            "currency": currency,
            "createdAt": createdAt,
            "updatedAt": updatedAt,
            "emailVerified": emailVerified
        ]
    }
}

class CompanyUser: Codable {
    let id: String
    let companyId: String
    let email: String
    let name: String
    let role: String // "admin", "manager", "accountant", "viewer"
    let createdAt: Date
    let isActive: Bool
    
    init(
        id: String = UUID().uuidString,
        companyId: String,
        email: String,
        name: String,
        role: String,
        createdAt: Date = Date(),
        isActive: Bool = true
    ) {
        self.id = id
        self.companyId = companyId
        self.email = email
        self.name = name
        self.role = role
        self.createdAt = createdAt
        self.isActive = isActive
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "companyId": companyId,
            "email": email,
            "name": name,
            "role": role,
            "createdAt": createdAt,
            "isActive": isActive
        ]
    }
}
