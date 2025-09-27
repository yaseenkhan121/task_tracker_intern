# 🚀 Task Tracker - Real-Time Flutter Productivity App

**Task Tracker** is a modern, responsive **Flutter** app backed by **Firebase Firestore**, designed to help users manage daily tasks, track project progress, and visualize their schedule in a clean and decorative interface.

---

## ✨ Features

- 🌐 **Real-Time Task Management:** Instantly syncs tasks across all devices using Firestore.  
- 📝 **Task CRUD Operations:** Create, read, update, and delete tasks seamlessly.  
- 🔄 **Status Toggling:** Move tasks between **Todo**, **In Progress**, and **Completed**.  
- ⏰ **Time-Blocked Scheduling:** Visualize your day with color-coded schedule blocks.  
- 🎨 **Decorative & Responsive UI:** Custom widgets and design system (`AppColors`, `AppStyles`) for a modern look.  

---

## 🖥 Screens

### 🏠 Home Screen
- Overview of tasks categorized by status: **Todo**, **In Progress**, **Completed**  
- Gradient cards for ongoing tasks and compact list for others  
- Quick access to notifications and search  

### 📂 Project Screen
- Displays projects with **large gradient cards**  
- Shows project progress, assigned users, and deadlines  
- Quick navigation to project-specific tasks  

### ➕ Add Task Screen
- Create tasks with title, description, assignees, due date, and status  
- Assign custom colors for visual organization  
- Saves tasks directly to **Firestore** in real-time  

### 📅 Schedule Screen
- **Time-blocked view** of daily tasks  
- Color-coded for quick identification  
- Supports daily, weekly, or custom views  

### 📝 Task Details Screen
- Full task overview with title, description, assignees, and status  
- Edit or delete tasks directly  
- Navigate to related project or schedule  

---

## 🛠 Tech Stack

- **Frontend:** Flutter (Dart)  
- **State Management:** StatefulWidget / InheritedWidget  
- **Backend:** Firebase Authentication & Cloud Firestore  
- **Styling & Theming:** Custom design system (`app_colors.dart`, `app_styles.dart`)  

---

## ⚡ Installation

1. Clone the repo:  
```bash
git clone https://github.com/yaseenkhan121/task_tracker_app.git
