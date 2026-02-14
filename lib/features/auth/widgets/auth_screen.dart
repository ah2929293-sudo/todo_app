import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/core/app_constants.dart';
import 'package:todo_app/core/widgets/custom_app_button.dart';
import 'package:todo_app/core/widgets/custom_text_form_filed.dart';
import 'package:todo_app/features/auth/models/user_model.dart';
import 'package:todo_app/features/home/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  TextEditingController nameController = TextEditingController();

  void openCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  void openGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 100.h),
          child: Column(
            spacing: 20.h,

            children: [
              Visibility(
                visible: image == null,
                replacement: Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: Image.file(File(image?.path ?? " ")).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                child: CircleAvatar(
                  radius: 100.r,
                  child: Icon(Icons.person, size: 100.r),
                ),
              ),
              CustomAppButton(
                title: "Upload From Camera",
                onPressed: () {
                  openCamera();
                },
              ),
              CustomAppButton(
                title: "Upload From Gallery",
                onPressed: () {
                  openGallery();
                },
              ),
              Divider(),
              CustomTextFormFiled(controller: nameController, hintText: ""),
              CustomAppButton(
                title: "Login",
                onPressed: () {
                  if (image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Image is required"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  Hive.box<UserModel>(AppConstants.userBox)
                      .add(
                        UserModel(
                          name: nameController.text,
                          image: image!.path,
                        ),
                      )
                      .then((v) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
