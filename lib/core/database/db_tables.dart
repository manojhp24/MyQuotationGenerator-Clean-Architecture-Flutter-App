const String createBusinessTable = '''
      CREATE TABLE business(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        businessName TEXT,
        contactName TEXT,
        mobileNumber TEXT,
        email TEXT,
        address1 TEXT,
        address2 TEXT,
        otherInfo TEXT,
        gstIN TEXT,
        state TEXT,
        businessCategory TEXT,
        accountName TEXT,
        accountNumber TEXT,
        bankName TEXT,
        upiId TEXT
        )
    ''';

const String createCustomerTable = '''
      CREATE TABLE customer(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerName TEXT,
        email TEXT,
        mobile TEXT,
        address1 TEXT,
        address2 TEXT,
        otherInfo TEXT,
        gstIN TEXT,
        shippingAddress TEXT
        )
    ''';
