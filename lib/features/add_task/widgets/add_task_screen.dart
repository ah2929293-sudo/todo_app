import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/widgets/custom_app_button.dart';
import 'package:todo_app/core/widgets/custom_text_form_filed.dart';
import 'package:todo_app/features/home/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String? date;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  var titleController = TextEditingController();
  var describtionController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endtTimeController = TextEditingController();
  var activeIndex = 0;
  var formKey = GlobalKey<FormState>();
  List<Color> taskColoes = [Colors.indigo, Colors.green, Colors.yellow];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.indigo),
        title: Text(
          "Add Task",
          style: TextStyle(fontSize: 20.sp, color: Colors.indigo),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20.h,
            children: [
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  spacing: 20.h,
                  children: [
                    CustomTextFormFiled(
                      hintText: "Task Title",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title Is Required";
                        } else if (value.length < 4) {
                          return "Title must be at least 4 charcters";
                        }
                      },
                    ),
                    CustomTextFormFiled(
                      controller: describtionController,
                      hintText: "Enter Task Description",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Task Description Is Required";
                        }
                      },
                      maxLines: 3,
                    ),
                    CustomTextFormFiled(
                      controller: dateController,
                      hintText: "Enter Task Date",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Task Date Is Required";
                        }
                      },
                      suffixIcon: Icon(Icons.date_range),
                      readOnly: true,
                      onTap: () {
                        showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2027),
                            )
                            .then((d) {
                              date = DateFormat.MMMEd().format(
                                d ?? DateTime.now(),
                              );
                              dateController.text = date.toString();
                            })
                            .catchError((e) {
                              print("e");
                            });
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormFiled(
                            controller: startTimeController,
                            hintText: "Start Time",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Start Time Is Required";
                              }
                            },
                            readOnly: true,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((t) {
                                startTime = t;
                                startTimeController.text =
                                    t?.format(context) ?? "";
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomTextFormFiled(
                            controller: endtTimeController,
                            hintText: "End Time",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "End Time Is Required";
                              } else if (endTime!.isBefore(startTime!)) {
                                return "end time must be after start time";
                              }
                            },
                            readOnly: true,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((t) {
                                endTime = t;
                                endtTimeController.text =
                                    t?.format(context) ?? "";
                              });
                              ;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 50.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: taskColoes[index],
                      child: activeIndex == index
                          ? Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 2.w),
                  itemCount: taskColoes.length,
                ),
              ),
              CustomAppButton(
                title: "Create Task",
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    allTaskes.add(
                      TaskModel(
                        title: titleController.text,
                        startTime: startTimeController.text,
                        endTime: endtTimeController.text,
                        description: describtionController.text,
                        statusText: "ToDo",
                        color: taskColoes[activeIndex],
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
