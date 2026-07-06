package com.ledgerflow.services

import android.content.Context
import android.content.SharedPreferences
import androidx.preference.PreferenceManager
import com.google.gson.Gson
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.RequestBody.Companion.toRequestBody
import java.util.concurrent.TimeUnit

class APIManager private constructor(context: Context) {
    private val prefs: SharedPreferences = PreferenceManager.getDefaultSharedPreferences(context)
    private val gson = Gson()
    private val baseUrl = "https://api.ledgerflow.app"
    
    private val httpClient = OkHttpClient.Builder()
        .connectTimeout(10, TimeUnit.SECONDS)
        .readTimeout(10, TimeUnit.SECONDS)
        .writeTimeout(10, TimeUnit.SECONDS)
        .build()
    
    companion object {
        @Volatile
        private var instance: APIManager? = null
        
        fun getInstance(context: Context) =
            instance ?: synchronized(this) {
                instance ?: APIManager(context).also { instance = it }
            }
    }
    
    suspend inline fun <reified T> get(endpoint: String): Result<T> = withContext(Dispatchers.IO) {
        try {
            val request = Request.Builder()
                .url(baseUrl + endpoint)
                .header("Authorization", "Bearer ${getAuthToken()}")
                .build()
            
            val response = httpClient.newCall(request).execute()
            if (response.isSuccessful) {
                val body = response.body?.string() ?: throw Exception("Empty response")
                val result = gson.fromJson(body, T::class.java)
                Result.success(result)
            } else {
                Result.failure(Exception("HTTP ${response.code}"))
            }
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    suspend inline fun <reified T> post(endpoint: String, body: Any): Result<T> = withContext(Dispatchers.IO) {
        try {
            val json = gson.toJson(body)
            val requestBody = json.toRequestBody("application/json".toMediaType())
            
            val request = Request.Builder()
                .url(baseUrl + endpoint)
                .post(requestBody)
                .header("Authorization", "Bearer ${getAuthToken()}")
                .build()
            
            val response = httpClient.newCall(request).execute()
            if (response.isSuccessful) {
                val responseBody = response.body?.string() ?: throw Exception("Empty response")
                val result = gson.fromJson(responseBody, T::class.java)
                Result.success(result)
            } else {
                Result.failure(Exception("HTTP ${response.code}"))
            }
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    suspend inline fun <reified T> put(endpoint: String, body: Any): Result<T> = withContext(Dispatchers.IO) {
        try {
            val json = gson.toJson(body)
            val requestBody = json.toRequestBody("application/json".toMediaType())
            
            val request = Request.Builder()
                .url(baseUrl + endpoint)
                .put(requestBody)
                .header("Authorization", "Bearer ${getAuthToken()}")
                .build()
            
            val response = httpClient.newCall(request).execute()
            if (response.isSuccessful) {
                val responseBody = response.body?.string() ?: throw Exception("Empty response")
                val result = gson.fromJson(responseBody, T::class.java)
                Result.success(result)
            } else {
                Result.failure(Exception("HTTP ${response.code}"))
            }
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    suspend inline fun <reified T> delete(endpoint: String): Result<T> = withContext(Dispatchers.IO) {
        try {
            val request = Request.Builder()
                .url(baseUrl + endpoint)
                .delete()
                .header("Authorization", "Bearer ${getAuthToken()}")
                .build()
            
            val response = httpClient.newCall(request).execute()
            if (response.isSuccessful) {
                val body = response.body?.string() ?: throw Exception("Empty response")
                val result = gson.fromJson(body, T::class.java)
                Result.success(result)
            } else {
                Result.failure(Exception("HTTP ${response.code}"))
            }
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    fun saveAuthToken(token: String) {
        prefs.edit().putString("auth_token", token).apply()
    }
    
    private fun getAuthToken(): String {
        return prefs.getString("auth_token", "") ?: ""
    }
}
