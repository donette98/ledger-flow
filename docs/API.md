# Ledger Flow - API Documentation

## Base URL
```
https://api.ledgerflow.app
```

## Authentication
All API requests (except public endpoints) require a Bearer token in the Authorization header:
```
Authorization: Bearer <token>
```

## Response Format
All responses are JSON with the following format:
```json
{
  "success": true,
  "data": {},
  "error": null,
  "timestamp": "2026-07-06T12:00:00Z"
}
```

## Error Handling

### Error Response
```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message"
  }
}
```

### HTTP Status Codes
- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `422` - Validation Error
- `500` - Internal Server Error

## Endpoints

### Authentication

#### Sign Up
```http
POST /auth/signup
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securePassword123",
  "name": "John Doe",
  "accountType": "individual",
  "currency": "USD"
}

Response 201:
{
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "name": "John Doe",
    "accountType": "individual",
    "currency": "USD"
  },
  "token": "jwt_token"
}
```

#### Sign In
```http
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securePassword123"
}

Response 200:
{
  "user": {...},
  "token": "jwt_token"
}
```

### Users

#### Get User Profile
```http
GET /api/users/{userId}
Authorization: Bearer token

Response 200:
{
  "id": "uuid",
  "email": "user@example.com",
  "name": "John Doe",
  "accountType": "individual",
  "currency": "USD",
  "createdAt": "2026-01-01T00:00:00Z"
}
```

#### Update User Profile
```http
PUT /api/users/{userId}
Authorization: Bearer token
Content-Type: application/json

{
  "name": "Jane Doe",
  "currency": "EUR"
}

Response 200:
{
  "success": true,
  "user": {...}
}
```

### Transactions

#### Create Transaction
```http
POST /api/transactions
Authorization: Bearer token
Content-Type: application/json

{
  "type": "expense",
  "category": "Groceries",
  "amount": 50.00,
  "currency": "USD",
  "description": "Weekly grocery shopping",
  "date": "2026-07-06T10:00:00Z"
}

Response 201:
{
  "id": "uuid",
  "userId": "uuid",
  "type": "expense",
  "category": "Groceries",
  "amount": 50.00,
  "currency": "USD",
  "description": "Weekly grocery shopping",
  "date": "2026-07-06T10:00:00Z",
  "createdAt": "2026-07-06T12:00:00Z"
}
```

#### List Transactions
```http
GET /api/transactions/{userId}?limit=20&offset=0
Authorization: Bearer token

Response 200:
[
  {
    "id": "uuid",
    "type": "expense",
    "category": "Groceries",
    "amount": 50.00,
    ...
  }
]
```

#### Get Financial Summary
```http
GET /api/transactions/{userId}/summary
Authorization: Bearer token

Response 200:
{
  "totalIncome": 5000.00,
  "totalExpense": 2000.00,
  "balance": 3000.00,
  "currency": "USD"
}
```

### Inventory

#### Add Inventory Item
```http
POST /api/inventory
Authorization: Bearer token
Content-Type: application/json

{
  "name": "Laptop",
  "description": "Dell XPS 13",
  "quantity": 5,
  "unitPrice": 999.99,
  "unit": "pcs",
  "category": "Electronics",
  "sku": "DELL-XPS-13"
}

Response 201:
{
  "id": "uuid",
  "name": "Laptop",
  "quantity": 5,
  "unitPrice": 999.99,
  ...
}
```

#### List Inventory
```http
GET /api/inventory/{userId}
Authorization: Bearer token

Response 200:
[
  {
    "id": "uuid",
    "name": "Laptop",
    "quantity": 5,
    ...
  }
]
```

#### Update Inventory Item
```http
PUT /api/inventory/{itemId}
Authorization: Bearer token
Content-Type: application/json

{
  "quantity": 3,
  "unitPrice": 899.99
}

Response 200:
{
  "success": true
}
```

### Company Management

#### Add User to Company
```http
POST /api/companies/{companyId}/users
Authorization: Bearer token
Content-Type: application/json

{
  "email": "newuser@company.com",
  "name": "New User",
  "role": "accountant"
}

Response 201:
{
  "id": "uuid",
  "email": "newuser@company.com",
  "role": "accountant"
}
```

#### List Company Users
```http
GET /api/companies/{companyId}/users
Authorization: Bearer token

Response 200:
[
  {
    "id": "uuid",
    "email": "user@company.com",
    "name": "User Name",
    "role": "admin",
    "isActive": true
  }
]
```

## Rate Limiting

- 100 requests per minute for authenticated users
- 10 requests per minute for unauthenticated endpoints
- Headers included:
  - `X-RateLimit-Limit`
  - `X-RateLimit-Remaining`
  - `X-RateLimit-Reset`

## Pagination

For list endpoints, use:
- `limit` - Number of items (default: 20, max: 100)
- `offset` - Starting index (default: 0)

Example:
```
GET /api/transactions/userId?limit=50&offset=100
```

## Filtering & Sorting

Supported query parameters:
- `sort` - Field to sort by (e.g., `sort=-date`)
- `filter` - Filter criteria (e.g., `filter={"type":"expense"}`)
- `search` - Full-text search

## WebSocket Events (Real-time Updates)

```javascript
const socket = io('https://api.ledgerflow.app');

// Connect with token
socket.auth = { token: 'jwt_token' };
socket.connect();

// Listen for transaction updates
socket.on('transaction:created', (data) => {
  console.log('New transaction:', data);
});

// Listen for inventory updates
socket.on('inventory:updated', (data) => {
  console.log('Inventory updated:', data);
});
```

## Webhooks

Configure webhooks in your account settings:

```json
{
  "url": "https://yourapp.com/webhook",
  "events": ["transaction.created", "inventory.updated"],
  "active": true
}
```

Webhook payload:
```json
{
  "event": "transaction.created",
  "timestamp": "2026-07-06T12:00:00Z",
  "data": {
    "id": "uuid",
    "type": "expense",
    ...
  }
}
```
