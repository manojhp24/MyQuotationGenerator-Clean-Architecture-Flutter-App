# **MyQuotationGenerator – Clean Architecture Flutter App**

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-State%20Management-0A84FF?style=for-the-badge)
![GoRouter](https://img.shields.io/badge/GoRouter-Routing-4285F4?style=for-the-badge)
![Sqflite](https://img.shields.io/badge/Sqflite-Local%20Database-3DDC84?style=for-the-badge)
![get_it](https://img.shields.io/badge/get_it-Dependency%20Injection-purple?style=for-the-badge)
![Clean Architecture](https://img.shields.io/badge/Clean%20Architecture-Design%20Pattern-darkgreen?style=for-the-badge)

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
