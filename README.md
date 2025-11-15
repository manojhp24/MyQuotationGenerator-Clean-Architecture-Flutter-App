# **MyQuotationGenerator – Clean Architecture Flutter App**

A Flutter-based quotation management application that allows businesses to manage customers, products, and create quotations.  
Built using **Clean Architecture**, with **Sqflite** as the local database, **Riverpod** for state management, **GoRouter** for routing, and **get_it** for dependency injection.

---

## 🚀 Features

- Manage **Business Profiles**
- Manage **Customers**
- Manage **Products**
- Create & View **Quotations**
- Local database using **Sqflite**
- Modern UI with custom themes
- Clean Architecture (Data → Domain → Presentation)
- State management using **Riverpod**
- Navigation using **GoRouter**
- Dependency Injection using **get_it**
- Modular & scalable codebase

---

## 🏗 Tech Stack

| Layer | Technology |
|-------|------------|
| **Frontend** | Flutter, Dart |
| **State Management** | Riverpod |
| **Routing** | GoRouter |
| **Local Database** | Sqflite |
| **Architecture** | Clean Architecture |
| **Dependency Injection** | get_it |

---

## 📂 Folder Structure

``` bash
lib/
│── app.dart
│── main.dart
│
├── config/
│ ├── constants/
│ ├── theme/
│ ├── utils/
│
├── core/
│ ├── common/
│ ├── database/
│ ├── di/
│ ├── enums/
│ ├── platform/
│ ├── resource/
│ ├── routes/
│ └── service/
│
├── features/
│ ├── business/
│ ├── customer/
│ ├── products/
│ ├── quotation/
│ ├── dashboard/
│ └── settings/
│
└── ...
```

This project follows **Clean Architecture**, divided into:

- **Data Layer** → Models, Local Datasources, Repository Implementations
- **Domain Layer** → Entities, Repository Interfaces, Use Cases
- **Presentation Layer** → Pages, Widgets, Providers

---

## 🧠 Architecture

### Clean Architecture Layers


- **Domain Layer** contains core business logic (Entities, UseCases).
- **Data Layer** handles database operations and repository implementations.
- **Presentation Layer** contains screens, widgets, and Riverpod providers.

This structure ensures the app is **scalable, testable, and easy to maintain**.

---

## 🔌 Dependency Injection

Dependency Injection is handled using **get_it**, initialized in:


All repositories, datasources, and use cases are registered here.

---

## 🗄️ Local Database (Sqflite)

Database initialization & table definitions:


Local datasources per module:

- `business_local_database.dart`
- `customer_local_database.dart`
- `product_local_database.dart`

---

## ▶️ How to Run the Project

### 1. Install dependencies
```sh
flutter pub get
flutter run
```
