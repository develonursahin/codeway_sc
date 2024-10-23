# Plantist 🌱

Plantist: ToDo Application.

## Table of Contents 📚
- [Welcome](#welcome)
- [Introduction](#introduction)
- [Features](#features)
- [Screens](#screens)
- [Bonuses](#bonuses)
- [Used Packages](#used-packages)
- [Legal Notice](#legal-notice)
- [Getting Started](#getting-started)

## Welcome 🎉

Thank you for taking the time to review this case study. Your feedback is invaluable!

## Introduction 🚀

### Required Application Features:
- **TODO Grouping**: TODOs are organized by day and sorted by priority. 📅
- **Firebase Integration**: User authentication, data storage via Firestore, and file uploads via Storage are managed through Firebase. ☁️
- **State Management**: GetX is used for effective state management. 🔄
- **User Authentication**: Secure login and registration functionality is implemented via Firebase Authentication. 🔐
- **TODO Management**: User TODOs are stored and retrieved using Firebase Firestore; TODOs have attributes like "title, note, priority, due date, category, tags." 📝

## Features ✨
- **Login and Registration**: Seamless access for user authentication.
- **Local Notifications**: Users receive reminders 1 hour and 5 minutes before a TODO's due date. ⏰
- **Biometric Authentication**: Touch ID and Face ID support for enhanced security. 👆👁️
- **Reminder Management**: All reminder actions (create, update, delete, search, filter by priority) are managed on the main screen. 🔍📊

## Screens 📱
- **Splash Screen**: A welcome screen to greet users upon opening the application. 🌅

- **Welcome Screen**: An engaging introduction inviting users to log in or register. 👋

- **Login and Registration Screens**: 
  - Intuitive interfaces for secure user authentication via Firebase.

- **Main Screen**: 
  - A central point for managing reminders, displaying user TODOs by priority.
  - The design utilizes predetermined subpage structures for adding, updating, and deleting reminders, ensuring a smooth user experience.

- **WebView Screen**: 
  - Displays web content for additional information or features within the application. 🌐

- **Biometric Screen**: 
  - Allows users to authenticate using biometric methods (Touch ID/Face ID). 🔑

## Bonuses 🎁
- **File Attachment Feature**: Users can attach photos or files to their TODOs; these files are stored in Firebase Storage. 📎
- **Local Notifications**: Set reminders for upcoming TODOs, sent one day and five minutes before the due date. 🛎️
- **Biometric Authentication**: Implemented for secure and convenient user authentication. 🔑
- **Search Function**: Allows users to quickly search and filter TODOs based on various criteria. 🔎
- **Dark Mode**: With the Dark Mode feature, you can use Plantist in a dark theme, reducing eye strain and enhancing your experience. 🌙

## Used Packages 📦
Here are the main packages used in this application:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  get: ^4.6.6
  firebase_auth: ^5.3.1
  firebase_core: ^3.6.0
  cloud_firestore: ^5.4.4
  firebase_storage: ^12.3.3
  hive: ^2.2.3
  hive_generator: ^2.0.1
  hive_flutter: ^1.1.0
  path_provider: ^2.1.4
  uuid: ^4.5.1
  flutter_svg: ^2.0.10+1
  image_picker: ^1.1.2
  local_auth: ^2.3.0
  flutter_local_notifications: ^17.2.3
  flutter_slidable: ^3.1.1
  flutter_inappwebview: ^6.1.5
  adoptive_calendar: ^0.2.0
