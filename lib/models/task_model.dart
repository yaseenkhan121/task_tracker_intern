import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime date; // Task due date
  final String category;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? startTime; // optional, for tracking start time

  Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.isCompleted,
    required this.createdAt,
    this.startTime,
  });

  factory Task.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    Timestamp? dateTimestamp = data['date'] as Timestamp?;
    Timestamp? createdAtTimestamp = data['createdAt'] as Timestamp?;
    Timestamp? startTimeTimestamp = data['startTime'] as Timestamp?;

    return Task(
      id: doc.id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: dateTimestamp?.toDate() ?? DateTime.now(),
      category: data['category'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      createdAt: createdAtTimestamp?.toDate() ?? DateTime.now(),
      startTime: startTimeTimestamp?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'date': date,
      'category': category,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
      if (startTime != null) 'startTime': startTime,
    };
  }
}
