import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/Utils/colors.dart';
import '../Routes/routes_name.dart';
import '../Utils/text.dart';
import 'dashboard.dart';

void storeData() async {
  final prefs = await SharedPreferences.getInstance();
  final taskDataAsStrings = taskData.map((task) => task.toString()).toList();
  final taskDateAsStrings = taskDate.map((task) => task.toString()).toList();
  await prefs.setStringList('items', taskDataAsStrings);
  await prefs.setStringList('date', taskDateAsStrings);
}

void addTask(String task) {
  taskData.add(task);
  taskDate.add(task);
  storeData();
}

void removeTask(int index) {
  taskData.removeAt(index);
  taskDate.removeAt(index);
  storeData();
}

var selectedDate = DateTime.now().obs;
var stringDate =
    '${selectedDate.value.day.toString()}/${selectedDate.value.month.toString().padLeft(2, '0')}/${selectedDate.value.year.toString().padLeft(2, '0')}'
        .obs;
TextEditingController titleController = TextEditingController();

class CreateNewTask extends StatelessWidget {
  const CreateNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.toNamed(RouteName.dashboard);
                        // Get.back();
                        // Navigator.pop(context);

                        titleController.text = '';
                        selectedDate.value = DateTime.now();
                        stringDate.value =
                            '${selectedDate.value.day.toString()}/${selectedDate.value.month.toString().padLeft(2, '0')}/${selectedDate.value.year.toString().padLeft(2, '0')}';
                      },
                      child: textSecondary15('Cancel')),
                ],
              ),
              SizedBox(height: 15.h),
              textSecondary30w600('Create New Task'),
              SizedBox(height: 25.h),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return 'Please enter title';
                  }
                  return null;
                },
                controller: titleController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Task title',
                    hintStyle: const TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white60, width: 1))),
              ),
              SizedBox(height: 25.h),
              // TextFormField(
              //   style: const TextStyle(color: Colors.white),
              //   maxLines: 5,
              //   decoration: InputDecoration(
              //       hintText: 'Description',
              //       hintStyle: const TextStyle(color: Colors.white54),
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10),
              //           borderSide:
              //               const BorderSide(color: Colors.white60, width: 1))),
              // ),
              SizedBox(height: 25.h),
              textWhite20('Select Date'),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      presentDatePicker(context);
                    },
                    child: Obx(
                      () => Container(
                          padding: EdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(10)),
                          child: textWhite16(stringDate.value)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35.h),
              GestureDetector(
                onTap: () async {
                  final FormState? form = formKey.currentState;
                  if (form != null && form.validate()) {
                    var titleValue = titleController.text.obs;
                    taskData.value = List.from(taskData)..add(titleValue);
                    taskDate.value = List.from(taskDate)..add(stringDate.value);
                    Get.toNamed(RouteName.dashboard);
                    // Get.back();
                    // Navigator.pop(context);
                    titleController.text = '';
                    storeData();
                  }
                },
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15.h),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: textWhite20('Create Task'))),
              )
            ],
          ),
        ),
      )),
    );
  }

  void presentDatePicker(context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.primary,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.secondary,
                ),
              ),
            ),
            child: child!);
      },
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      selectedDate.value = pickedDate;
      stringDate.value =
          "${selectedDate.value.day.toString()}/${selectedDate.value.month.toString().padLeft(2, '0')}/${selectedDate.value.year.toString().padLeft(2, '0')}";
    });
  }
}
