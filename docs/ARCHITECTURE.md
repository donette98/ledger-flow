# Ledger Flow - Architecture Documentation

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Client Layer                             │
├─────────────────────────────────────────────────────────────┤
│  Flutter (Web, Mobile) │  iOS (Swift)  │  Android (Kotlin)  │
└─────────────────────────────────────────────────────────────┘
                               ↓
┌─────────────────────────────────────────────────────────────┐
│              API Gateway & Load Balancer                     │
└─────────────────────────────────────────────────────────────┘
                               ↓
┌─────────────────────────────────────────────────────────────┐
│                   Backend API Layer                          │
│  ├─ Authentication Service (Firebase Auth)                  │
│  ├─ User Service                                            │
│  ├─ Transaction Service                                     │
│  ├─ Inventory Service                                       │
│  ├─ Notification Service (Email/Push)                       │
│  └─ Analytics Service                                       │
└─────────────────────────────────────────────────────────────┘
                               ↓
┌─────────────────────────────────────────────────────────────┐
│                  Data Layer                                  │
│  ├─ Firestore (Document Database)                           │
│  ├─ Firebase Storage (File Storage)                         │
│  ├─ Firebase Realtime Database (Sync)                       │
│  └─ Cache (Redis)                                           │
└─────────────────────────────────────────────────────────────┘
```

## Database Schema

### Users Collection
```
users/
├── {userId}
│   ├── id: string
│   ├── email: string
│   ├── name: string
│   ├── accountType: "individual" | "company"
│   ├── currency: string
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   └── emailVerified: boolean
```

### Transactions Collection
```
transactions/
├── {transactionId}
│   ├── userId: string
│   ├── type: "income" | "expense"
│   ├── category: string
│   ├── amount: number
│   ├── currency: string
│   ├── description: string
│   ├── date: timestamp
│   ├── attachmentUrl: string (optional)
│   └── createdAt: timestamp
```

### Inventory Collection
```
inventory/
├── {itemId}
│   ├── userId: string
│   ├── name: string
│   ├── description: string
│   ├── quantity: number
│   ├── unitPrice: number
│   ├── unit: string
│   ├── category: string
│   ├── sku: string (optional)
│   ├── imageUrl: string (optional)
│   ├── createdAt: timestamp
│   └── updatedAt: timestamp
```

### Company Users Collection
```
companyUsers/
├── {companyUserId}
│   ├── companyId: string
│   ├── email: string
│   ├── name: string
│   ├── role: "admin" | "manager" | "accountant" | "viewer"
│   ├── createdAt: timestamp
│   └── isActive: boolean
```

## API Endpoints

### Authentication
- `POST /auth/signup` - Register new user
- `POST /auth/login` - Login with email/password
- `POST /auth/google` - Google OAuth login
- `POST /auth/refresh` - Refresh auth token
- `POST /auth/logout` - Logout

### Users
- `GET /api/users/{userId}` - Get user profile
- `PUT /api/users/{userId}` - Update user profile
- `POST /api/users/{userId}/currency` - Change currency

### Transactions
- `POST /api/transactions` - Create transaction
- `GET /api/transactions/{userId}` - List transactions
- `PUT /api/transactions/{transactionId}` - Update transaction
- `DELETE /api/transactions/{transactionId}` - Delete transaction
- `GET /api/transactions/{userId}/summary` - Get financial summary
- `GET /api/transactions/{userId}/monthly` - Get monthly report

### Inventory
- `POST /api/inventory` - Add inventory item
- `GET /api/inventory/{userId}` - List inventory
- `PUT /api/inventory/{itemId}` - Update inventory item
- `DELETE /api/inventory/{itemId}` - Delete inventory item
- `POST /api/inventory/{itemId}/transaction` - Record inventory transaction
- `GET /api/inventory/{itemId}/history` - Get item history

### Company Management
- `POST /api/companies` - Create company
- `GET /api/companies/{companyId}` - Get company details
- `POST /api/companies/{companyId}/users` - Add user to company (max 7+)
- `GET /api/companies/{companyId}/users` - List company users
- `PUT /api/companies/{companyId}/users/{userId}` - Update user role
- `DELETE /api/companies/{companyId}/users/{userId}` - Remove user from company

### Notifications
- `POST /api/notifications/email` - Send email notification
- `POST /api/notifications/push` - Send push notification

## Security

### Authentication
- Firebase Authentication for user management
- JWT tokens for API requests
- Multi-factor authentication support (optional)

### Authorization
- Role-based access control (RBAC)
- User can only access their own data
- Company users can access company data based on roles

### Data Protection
- All data encrypted in transit (HTTPS)
- Firestore security rules enforced
- Sensitive data encrypted at rest

## Performance Optimization

### Caching
- Client-side caching with Hive (Flutter)
- Server-side caching with Redis
- API response caching

### Database Optimization
- Proper indexing on frequently queried fields
- Pagination for large result sets
- Query optimization

### CDN
- CloudFlare for static assets
- Firebase Storage for user uploads

## Scalability

- Horizontal scaling with load balancing
- Database sharding strategies
- Microservices ready architecture
- Async processing for heavy operations

## Monitoring & Analytics

- Firebase Analytics integration
- Application Performance Monitoring (APM)
- Error tracking with Sentry
- User behavior analytics

## Deployment

### Development
```bash
npm install
npm run dev
```

### Production
```bash
npm run build
npm start
```

### Docker
```dockerfile
FROM node:16
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```
