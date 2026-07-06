package com.ledgerflow.services

import android.app.Activity
import com.firebase.ui.auth.AuthUI
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.auth.userProfileChangeRequest
import com.ledgerflow.models.User
import kotlinx.coroutines.tasks.await

class AuthManager private constructor() {
    private val firebaseAuth = FirebaseAuth.getInstance()
    
    companion object {
        @Volatile
        private var instance: AuthManager? = null
        
        fun getInstance() =
            instance ?: synchronized(this) {
                instance ?: AuthManager().also { instance = it }
            }
    }
    
    fun getCurrentUser(): FirebaseUser? = firebaseAuth.currentUser
    
    suspend fun signUp(
        email: String,
        password: String,
        name: String,
        accountType: String,
        currency: String
    ): Result<User> = try {
        val authResult = firebaseAuth.createUserWithEmailAndPassword(email, password).await()
        val firebaseUser = authResult.user ?: throw Exception("User creation failed")
        
        val profileUpdate = userProfileChangeRequest {
            displayName = name
        }
        firebaseUser.updateProfile(profileUpdate).await()
        
        val user = User(
            id = firebaseUser.uid,
            email = email,
            name = name,
            accountType = accountType,
            currency = currency,
            emailVerified = firebaseUser.isEmailVerified
        )
        
        Result.success(user)
    } catch (e: Exception) {
        Result.failure(e)
    }
    
    suspend fun signIn(
        email: String,
        password: String
    ): Result<User> = try {
        val authResult = firebaseAuth.signInWithEmailAndPassword(email, password).await()
        val firebaseUser = authResult.user ?: throw Exception("Sign in failed")
        
        val user = User(
            id = firebaseUser.uid,
            email = firebaseUser.email ?: "",
            name = firebaseUser.displayName ?: "",
            accountType = "individual",
            currency = "USD",
            emailVerified = firebaseUser.isEmailVerified
        )
        
        Result.success(user)
    } catch (e: Exception) {
        Result.failure(e)
    }
    
    fun signOut() {
        firebaseAuth.signOut()
    }
    
    suspend fun sendPasswordResetEmail(email: String): Result<Unit> = try {
        firebaseAuth.sendPasswordResetEmail(email).await()
        Result.success(Unit)
    } catch (e: Exception) {
        Result.failure(e)
    }
    
    suspend fun changePassword(newPassword: String): Result<Unit> = try {
        firebaseAuth.currentUser?.updatePassword(newPassword)?.await()
        Result.success(Unit)
    } catch (e: Exception) {
        Result.failure(e)
    }
}
