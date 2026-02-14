import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/features/home/models/task_model.dart';
import 'package:todo_app/features/home/widgets/task_item.dart';

class TasksListView extends StatelessWidget {
  const TasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return allTaskes.isEmpty
        ? Lottie.asset("assets/empty.json")
        : Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  child: TaskItem(task: allTaskes[index]),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: allTaskes.length,
            ),
          );
  }
}
