import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/core/app_constants.dart';
import 'package:todo_app/features/home/models/task_model.dart';
import 'package:todo_app/features/home/widgets/task_item.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  @override
  void initState() {
    allTasks = Hive.box<TaskModel>(AppConstants.taskBox).values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return allTasks.isEmpty
        ? Lottie.asset("assets/empty.json")
        : Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Dismissible(
                  background: Container(
                    width: double.infinity,
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Complete",
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    ),
                  ),
                  secondaryBackground: Container(
                    width: double.infinity,
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Delete",
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      var task = Hive.box<TaskModel>(
                        AppConstants.taskBox,
                      ).getAt(index);
                      task?.statusText = "completed";
                      Hive.box<TaskModel>(
                        AppConstants.taskBox,
                      ).putAt(index, task!);
                    } else {
                      Hive.box<TaskModel>(AppConstants.taskBox).deleteAt(index);
                    }
                    setState(() {
                      allTasks = Hive.box<TaskModel>(
                        AppConstants.taskBox,
                      ).values.toList();
                    });
                  },
                  key: UniqueKey(),
                  child: TaskItem(task: allTasks[index]),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: allTasks.length,
            ),
          );
  }
}
