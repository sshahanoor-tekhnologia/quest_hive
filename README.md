📌 Project Overview

This Flutter application allows users to:

Register, Login, and Logout

View available questionnaires

Submit MCQ-based responses during site visits

Store submissions offline (mandatory requirement)

Track submission history

Capture and store Lat/Long during submission

All network interactions are implemented using Mock APIs (mockapi.io).

The app follows Clean Architecture and uses GetX for state management.

🚀 Features
✅ Authentication

Register (Email, Password, Confirm Password validation)

Login

Logout

Session persistence using GetStorage

✅ Home Screen

Fetch questionnaires from Mock API

Display title & description

Navigate to questionnaire details

✅ Questionnaire Module

5 MCQ questions

Single option selection per question

Mandatory answering before submission

Capture device Lat/Long

Store:

Questionnaire ID & Name

Selected answers

Date & Time

Location coordinates

✅ Offline Storage (Mandatory)

All submissions saved locally using Hive

Data persists after:

App restart

Logout/Login

No internet connection

✅ Profile Screen

Logged-in user email

Total questionnaires filled

Submission history list (offline data only)

🛠 Tech Stack & Libraries Used

| Package       | Purpose                       |
| ------------- | ----------------------------- |
| get           | State management & navigation |
| dio           | API calls                     |
| get_storage   | Session management            |
| hive          | Offline storage               |
| hive_flutter  | Hive Flutter integration      |
| path_provider | Local storage path            |
| geolocator    | Fetch Lat/Long                |
| intl          | Date & time formatting        |
| google_fonts  | Custom fonts                  |

Dev Dependencies:

hive_generator

build_runner

🌐 Mock API

All network calls are implemented using:

https://mockapi.io

Endpoints used:

Register

Login

Fetch Questionnaires

(Optional) Sync submissions


⚙️ Setup Instructions

1️⃣ Clone the repository
git clone https://github.com/sshahanoor-tekhnologia/quest_hive.git

2️⃣ Navigate to project folder
cd your-repository-name

3️⃣ Install dependencies
flutter pub get

4️⃣ Generate Hive adapters
flutter pub run build_runner build --delete-conflicting-outputs

5️⃣ Run the application
flutter run

📱 Requirements

Flutter (Latest Stable Version)

Android Studio / VS Code

Android Emulator or Physical Device

Internet (for API calls)

Location enabled device

⚠️ Assumptions & Limitations

Mock API simulates backend behavior (no real authentication security).

No score calculation (as per requirement).

Location accuracy depends on device GPS availability.

Submission sync to Mock API is optional and simulated.

App designed primarily for mobile devices (responsive layout supported).