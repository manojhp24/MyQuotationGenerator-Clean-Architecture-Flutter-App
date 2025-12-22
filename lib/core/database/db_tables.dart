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
        state TEXT,
        shippingAddress TEXT
        )
    ''';

const String createProductTable = '''
    CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productName TEXT,
        price TEXT,
        unitMeasure TEXT,
        gst TEXT,
        description TEXT,
        hsn TEXT
        )
    ''';

const String createQuotationTable = '''
CREATE TABLE quotations(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  quoteNo TEXT NOT NULL,
  customerId INTEGER NOT NULL,
  quoteDate TEXT NOT NULL,
  subTotal REAL NOT NULL,
  taxTotal REAL NOT NULL,
  grandTotal REAL NOT NULL,
  status TEXT,
  createdAt TEXT,
  FOREIGN KEY (customerId) REFERENCES customer(id)
)
''';

const String createQuotationItemsTable = '''
CREATE TABLE quotation_items(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  quotationId INTEGER NOT NULL,
  productId INTEGER NOT NULL,
  productName TEXT NOT NULL,
  quantity INTEGER NOT NULL,
  unitPrice REAL NOT NULL,
  gstPercent REAL NOT NULL,
  gstAmount REAL NOT NULL,
  totalPrice REAL NOT NULL,
  FOREIGN KEY (quotationId) REFERENCES quotations(id),
  FOREIGN KEY (productId) REFERENCES products(id)
)
''';

const String getQuotationListQuery = '''
SELECT 
q.id  AS quotationId,
q.quoteNo,
q.quoteDate,
q.subTotal,
q.taxTotal,
q.grandTotal,
q.status,

c.id AS customerId,
c.customerName,
c.email,
c.mobile

FROM quotations q
INNER JOIN customer c ON c.id  = q.customerId
''';
