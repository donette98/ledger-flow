package com.ledgerflow.models

import java.io.Serializable
import java.util.*

data class Transaction(
    val id: String = UUID.randomUUID().toString(),
    val userId: String,
    val type: String, // "income" or "expense"
    val category: String,
    val amount: Double,
    val currency: String,
    val description: String,
    val date: Date = Date(),
    val attachmentUrl: String? = null,
    val createdAt: Date = Date()
) : Serializable {
    fun toMap(): Map<String, Any?> {
        return mapOf(
            "id" to id,
            "userId" to userId,
            "type" to type,
            "category" to category,
            "amount" to amount,
            "currency" to currency,
            "description" to description,
            "date" to date,
            "attachmentUrl" to attachmentUrl,
            "createdAt" to createdAt
        )
    }
}

data class MonthlyReport(
    val month: String,
    val totalIncome: Double,
    val totalExpense: Double,
    val balance: Double,
    val categories: List<String>
) : Serializable
