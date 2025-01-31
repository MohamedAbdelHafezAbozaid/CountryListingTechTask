# iOS Technical Task

## 📌 Overview
This project is built using **SwiftUI** and follows the **MVVM-IO** pattern combined with a **Clean & Modular Architecture** to ensure scalability, testability, and maintainability.

Additionally, the project utilizes a **Coordinator** pattern with a structured **Router** and **Factory** based on a **Protocol-Oriented** approach to manage navigation and dependency injection efficiently.

## 📂 Project Structure
The project is divided into several modules:

### 1️⃣ **AppNetworking**
- Responsible for handling all network requests.
- Uses **Native URLSession**, structured using [Building Blox](https://github.com/jellyfishapp/BuildingBlox).

### 2️⃣ **AppCore**
Contains the core business logic:
- **DataLayer**: Manages local and remote data sources.
- **DomainLayer**: Contains Repositories & Use Cases to separate concerns.

### 3️⃣ **Commons**
A shared utility module that contains:
- **Models** (Remote & Presentable).
- **Extensions**.
- **Helper classes** for reusable functionalities.

### 4️⃣ **Presentation Layer**
The UI layer structured using SwiftUI, which includes:

#### 🏳️‍🌎 Countries List View
- Fetches all available countries.
- Implements location access logic:
  - If **location access is granted**, the closest country is added to the **Favorites List**.
  - If **location access is denied**, **Egypt** is added as the default favorite country.

#### ⭐ Favorite List View
- Fetches favorite countries stored locally in **CoreData**.
- Allows users to remove countries from the favorite list.

#### 📍 Country Details View
- Displays detailed information about the selected country.

## 🛠️ Unit Testing
The project includes extensive unit tests to ensure reliability:
- ✅ `MockHTTPClient`
- ✅ `SpyAPI`
- ✅ `SpyRepositories` **(Tested)**
- ✅ `SpyUseCase` **(Tested)**
- ✅ `Router` **(Tested)**
- ✅ `ViewModel` **(Tested)**

## 🚀 Getting Started
### Prerequisites
- **Xcode 15+**
- **iOS 17+**

### Installation
1. Clone the repository:
   ```bash
   git clone (https://github.com/MohamedAbdelHafezAbozaid/CountryListingTechTask.git)
   cd <project_directory>
   ```
2. Open the `.xcodeproj` file in Xcode.
3. Build & run the project.

## 🏗️ Tech Stack
- **SwiftUI** for UI
- **Combine** for reactive programming
- **CoreData** for local persistence
- **URLSession** for networking
- **Dependency Injection** to manage dependencies
- **Coordinator Pattern** for navigation
- **Factory Pattern** for object creation
- **Unit Testing** with XCTest

---
Feel free to contribute or reach out for any inquiries! 🚀

