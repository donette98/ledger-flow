package com.ledgerflow.models

import java.io.Serializable
import java.util.*

data class InventoryItem(
    val id: String = UUID.randomUUID().toString(),
    val userId: String,
    val name: String,
    val description: String,
    val quantity: Int,
    val unitPrice: Double,
    val unit: String, // "pcs", "kg", "liters", etc.
    val category: String,
    val sku: String? = null,
    val imageUrl: String? = null,
    val createdAt: Date = Date(),
    val updatedAt: Date = Date()
) : Serializable {
    fun toMap(): Map<String, Any?> {
        return mapOf(
            "id" to id,
            "userId" to userId,
            "name" to name,
            "description" to description,
            "quantity" to quantity,
            "unitPrice" to unitPrice,
            "unit" to unit,
            "category" to category,
            "sku" to sku,
            "imageUrl" to imageUrl,
            "createdAt" to createdAt,
            "updatedAt" to updatedAt
        )
    }
}

data class InventoryTransaction(
    val id: String = UUID.randomUUID().toString(),
    val inventoryItemId: String,
    val type: String, // "in" or "out"
    val quantity: Int,
    val reason: String, // "purchase", "sale", "damage", "return"
    val reference: String? = null,
    val date: Date = Date(),
    val createdAt: Date = Date()
) : Serializable {
    fun toMap(): Map<String, Any?> {
        return mapOf(
            "id" to id,
            "inventoryItemId" to inventoryItemId,
            "type" to type,
            "quantity" to quantity,
            "reason" to reason,
            "reference" to reference,
            "date" to date,
            "createdAt" to createdAt
        )
    }
}
