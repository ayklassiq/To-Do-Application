import 'package:flutter/material.dart';

class Task {
  String name;
  String category;
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String description;
  bool isCompleted;

  Task({
    required this.name,
    required this.category,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.description,
    this.isCompleted = false,
  });
}
