import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/core/app_constants.dart';
import 'package:todo_app/features/add_task/widgets/add_task_screen.dart';
import 'package:todo_app/features/auth/models/user_model.dart';
import 'package:todo_app/features/home/models/task_model.dart';
import 'package:todo_app/features/home/widgets/add_task_row.dart';
import 'package:todo_app/features/home/widgets/home_app_bar.dart';
import 'package:todo_app/features/home/widgets/tasks_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
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
              Row(
                children: [
                  Expanded(
                    child: FilterButton(
                      title: "All",
                      isActive: activeIndex == 0,
                      onTap: () {
                        setState(() {
                          activeIndex = 0;
                          allTasks = Hive.box<TaskModel>(
                            AppConstants.taskBox,
                          ).values.toList();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: FilterButton(
                      title: "ToDo",
                      isActive: activeIndex == 1,
                      onTap: () {
                        setState(() {
                          activeIndex = 1;
                          allTasks = Hive.box<TaskModel>(AppConstants.taskBox)
                              .values
                              .where(
                                (e) => e.statusText.toLowerCase() == "todo",
                              )
                              .toList();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: FilterButton(
                      title: "Complete",
                      isActive: activeIndex == 2,
                      onTap: () {
                        setState(() {
                          activeIndex = 2;
                          allTasks = Hive.box<TaskModel>(AppConstants.taskBox)
                              .values
                              .where(
                                (e) =>
                                    e.statusText.toLowerCase() == "completed",
                              )
                              .toList();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
              SizedBox(height: 10.h),
              TasksListView(),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final void Function()? onTap;
  final bool isActive;
  final String title;
  const FilterButton({
    super.key,
    required this.title,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple),
          borderRadius: BorderRadius.circular(12.r),
          color: isActive ? Colors.purple : Colors.transparent,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
