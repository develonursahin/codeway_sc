import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderModel {
  String? id;
  String? title;
  String? content;
  String? category;
  String? time;
  List<String>? tags;
  int? priority;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? date;
  bool? done;
  String? file;
  List<int>? notificationIds; 

  ReminderModel({
    this.id,
    this.title,
    this.content,
    this.category,
    this.time,
    this.tags,
    this.priority,
    this.createdAt,
    this.updatedAt,
    this.date,
    this.done,
    this.file,
    this.notificationIds, 
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'time': time,
      'tags': tags,
      'priority': priority,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'date': date != null ? Timestamp.fromDate(date!) : null,
      'isDone': done,
      'file': file,
      'notificationIds': notificationIds, 
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> data) {
    return ReminderModel(
      id: data['id'],
      title: data['title'],
      content: data['content'],
      category: data['category'],
      time: data['time'],
      tags: data['tags'] != null ? List<String>.from(data['tags']) : null,
      priority: data['priority'],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      date: data['date'] != null ? (data['date'] as Timestamp).toDate() : null,
      done: data['isDone'],
      file: data['file'],
      notificationIds: data['notificationIds'] != null
          ? List<int>.from(data['notificationIds']) 
          : null,
    );
  }
}
