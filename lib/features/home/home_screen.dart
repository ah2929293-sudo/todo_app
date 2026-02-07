import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/core/app_constants.dart';
import 'package:todo_app/features/auth/models/user_model.dart';
import 'package:todo_app/features/home/models/task_model.dart';
import 'package:todo_app/features/home/widgets/add_task_row.dart';
import 'package:todo_app/features/home/widgets/home_app_bar.dart';
import 'package:todo_app/features/home/widgets/task_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userData = Hive.box<UserModel>(AppConstants.userBox).getAt(5);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),

          child: Column(
            children: [
              HomeAppBar(userData: userData),
              SizedBox(height: 20.h),
              AddTaskRow(),
              SizedBox(height: 20.h),

              Expanded(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
