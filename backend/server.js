const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const admin = require('firebase-admin');
const morgan = require('morgan');

dotenv.config();

// Initialize Firebase Admin
admin.initializeApp({
  credential: admin.credential.cert(require('./config/firebase-key.json')),
});

const app = express();
const db = admin.firestore();

// Middleware
app.use(cors());
app.use(express.json());
app.use(morgan('dev'));

// Authentication Middleware
const verifyToken = async (req, res, next) => {
  const token = req.headers.authorization?.split('Bearer ')[1];
  if (!token) {
    return res.status(401).json({ error: 'Unauthorized' });
  }

  try {
    const decodedToken = await admin.auth().verifyIdToken(token);
    req.user = decodedToken;
    next();
  } catch (error) {
    res.status(401).json({ error: 'Invalid token' });
  }
};

// Health Check
app.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// User Routes
app.post('/api/users', async (req, res) => {
  try {
    const { uid, email, name, accountType, currency } = req.body;

    const userData = {
      id: uid,
      email,
      name,
      accountType,
      currency,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      emailVerified: false,
    };

    await db.collection('users').doc(uid).set(userData);
    res.status(201).json(userData);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/api/users/:userId', verifyToken, async (req, res) => {
  try {
    const { userId } = req.params;

    if (req.user.uid !== userId) {
      return res.status(403).json({ error: 'Forbidden' });
    }

    const doc = await db.collection('users').doc(userId).get();
    if (!doc.exists) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json(doc.data());
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.put('/api/users/:userId', verifyToken, async (req, res) => {
  try {
    const { userId } = req.params;
    const updates = req.body;

    if (req.user.uid !== userId) {
      return res.status(403).json({ error: 'Forbidden' });
    }

    updates.updatedAt = admin.firestore.FieldValue.serverTimestamp();
    await db.collection('users').doc(userId).update(updates);

    res.json({ success: true, ...updates });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Transaction Routes
app.post('/api/transactions', verifyToken, async (req, res) => {
  try {
    const { type, category, amount, currency, description, date } = req.body;

    const transaction = {
      userId: req.user.uid,
      type,
      category,
      amount,
      currency,
      description,
      date: new Date(date),
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    const docRef = await db.collection('transactions').add(transaction);
    res.status(201).json({ id: docRef.id, ...transaction });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/api/transactions/:userId', verifyToken, async (req, res) => {
  try {
    const { userId } = req.params;

    if (req.user.uid !== userId) {
      return res.status(403).json({ error: 'Forbidden' });
    }

    const snapshot = await db
      .collection('transactions')
      .where('userId', '==', userId)
      .orderBy('date', 'desc')
      .limit(100)
      .get();

    const transactions = [];
    snapshot.forEach((doc) => {
      transactions.push({ id: doc.id, ...doc.data() });
    });

    res.json(transactions);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/api/transactions/:userId/summary', verifyToken, async (req, res) => {
  try {
    const { userId } = req.params;

    if (req.user.uid !== userId) {
      return res.status(403).json({ error: 'Forbidden' });
    }

    const snapshot = await db
      .collection('transactions')
      .where('userId', '==', userId)
      .get();

    let totalIncome = 0;
    let totalExpense = 0;

    snapshot.forEach((doc) => {
      const data = doc.data();
      if (data.type === 'income') {
        totalIncome += data.amount;
      } else if (data.type === 'expense') {
        totalExpense += data.amount;
      }
    });

    res.json({
      totalIncome,
      totalExpense,
      balance: totalIncome - totalExpense,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Inventory Routes
app.post('/api/inventory', verifyToken, async (req, res) => {
  try {
    const { name, description, quantity, unitPrice, unit, category, sku } = req.body;

    const item = {
      userId: req.user.uid,
      name,
      description,
      quantity,
      unitPrice,
      unit,
      category,
      sku: sku || null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    const docRef = await db.collection('inventory').add(item);
    res.status(201).json({ id: docRef.id, ...item });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/api/inventory/:userId', verifyToken, async (req, res) => {
  try {
    const { userId } = req.params;

    if (req.user.uid !== userId) {
      return res.status(403).json({ error: 'Forbidden' });
    }

    const snapshot = await db
      .collection('inventory')
      .where('userId', '==', userId)
      .get();

    const items = [];
    snapshot.forEach((doc) => {
      items.push({ id: doc.id, ...doc.data() });
    });

    res.json(items);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.put('/api/inventory/:itemId', verifyToken, async (req, res) => {
  try {
    const { itemId } = req.params;
    const updates = req.body;

    const doc = await db.collection('inventory').doc(itemId).get();
    if (!doc.exists) {
      return res.status(404).json({ error: 'Item not found' });
    }

    if (doc.data().userId !== req.user.uid) {
      return res.status(403).json({ error: 'Forbidden' });
    }

    updates.updatedAt = admin.firestore.FieldValue.serverTimestamp();
    await db.collection('inventory').doc(itemId).update(updates);

    res.json({ success: true, ...updates });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.delete('/api/inventory/:itemId', verifyToken, async (req, res) => {
  try {
    const { itemId } = req.params;

    const doc = await db.collection('inventory').doc(itemId).get();
    if (!doc.exists) {
      return res.status(404).json({ error: 'Item not found' });
    }

    if (doc.data().userId !== req.user.uid) {
      return res.status(403).json({ error: 'Forbidden' });
    }

    await db.collection('inventory').doc(itemId).delete();
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Email Notification (placeholder)
app.post('/api/notifications/email', verifyToken, async (req, res) => {
  try {
    const { to, subject, message } = req.body;
    // TODO: Implement SendGrid or similar email service
    console.log(`Email notification: ${to} - ${subject}`);
    res.json({ success: true, message: 'Email sent' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Error Handling
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Internal Server Error' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Ledger Flow API running on port ${PORT}`);
});

module.exports = app;
