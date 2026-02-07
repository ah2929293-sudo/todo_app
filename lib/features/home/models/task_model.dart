import 'package:flutter/material.dart';

class TaskModel {
  String title;
  String startTime;
  String endTime;
  String description;
  String statusText;
  Color color;

  TaskModel({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.statusText,
    required this.color,
  });
}

List<TaskModel> allTaskes = [
  TaskModel(
    title: "Task 1",
    startTime: "02:22 pM",
    endTime: "04:30 AM",
    description: "i will do this task",
    statusText: "ToDo",
    color: Colors.indigo,
  ),
  TaskModel(
    title: "Task 2",
    startTime: "02:22 pM",
    endTime: "04:30 AM",
    description: "i will do this task",
    statusText: "ToDo",
    color: Colors.green,
  ),
  TaskModel(
    title: "Task 3",
    startTime: "02:22 pM",
    endTime: "04:30 AM",
    description: "i will do this task",
    statusText: "ToDo",
    color: Colors.amber,
  ),
];
