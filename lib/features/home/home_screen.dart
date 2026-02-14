import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/core/app_constants.dart';
import 'package:todo_app/features/add_task/widgets/add_task_screen.dart';
import 'package:todo_app/features/auth/models/user_model.dart';
import 'package:todo_app/features/home/widgets/add_task_row.dart';
import 'package:todo_app/features/home/widgets/home_app_bar.dart';
import 'package:todo_app/features/home/widgets/tasks_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box<UserModel>(AppConstants.userBox);
    int totalUsers = box.length;

    var userData = Hive.box<UserModel>(
      AppConstants.userBox,
    ).getAt(totalUsers - 1);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),

          child: Column(
            children: [
              HomeAppBar(userData: userData),
              SizedBox(height: 20.h),
              AddTaskRow(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => AddTaskScreen()),
                  );
                  setState(() {});
                },
              ),
              SizedBox(height: 20.h),
              TasksListView(),
            ],
          ),
        ),
      ),
    );
  }
}
