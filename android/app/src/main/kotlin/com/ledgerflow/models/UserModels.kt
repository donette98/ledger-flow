package com.ledgerflow.models

import java.io.Serializable
import java.util.*

data class User(
    val id: String = UUID.randomUUID().toString(),
    val email: String,
    val name: String,
    val accountType: String, // "individual" or "company"
    val currency: String,
    val createdAt: Date = Date(),
    val updatedAt: Date = Date(),
    val emailVerified: Boolean = false
) : Serializable {
    fun toMap(): Map<String, Any> {
        return mapOf(
            "id" to id,
            "email" to email,
            "name" to name,
            "accountType" to accountType,
            "currency" to currency,
            "createdAt" to createdAt,
            "updatedAt" to updatedAt,
            "emailVerified" to emailVerified
        )
    }
}

data class CompanyUser(
    val id: String = UUID.randomUUID().toString(),
    val companyId: String,
    val email: String,
    val name: String,
    val role: String, // "admin", "manager", "accountant", "viewer"
    val createdAt: Date = Date(),
    val isActive: Boolean = true
) : Serializable {
    fun toMap(): Map<String, Any> {
        return mapOf(
            "id" to id,
            "companyId" to companyId,
            "email" to email,
            "name" to name,
            "role" to role,
            "createdAt" to createdAt,
            "isActive" to isActive
        )
    }
}
