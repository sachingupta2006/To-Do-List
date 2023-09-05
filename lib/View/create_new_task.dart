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

void addTask(String title, String date) {
  taskData.add(title);
  taskDate.add(date);
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
  const CreateNewTask({super.key, this.editTitle, this.editIndex});
  final String? editTitle;
  final int? editIndex;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                textSecondary30w600(
                    editTitle != null ? 'Update Task' : 'Create New Task'),
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
                      hintText: editTitle ?? 'Task title',
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.white60, width: 1))),
                ),
                SizedBox(height: 50.h),
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
                      if (editTitle == null) {
                        var titleValue = titleController.text.obs;
                        addTask(titleValue.value, stringDate.value);
                      } else {
                        var titleValue = titleController.text.obs;

                        taskData[editIndex!] = titleValue.value;
                        taskDate[editIndex!] = stringDate.value;
                        storeData();
                      }

                      Get.toNamed(RouteName.dashboard);
                      // Get.back();
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
                      child: Center(
                          child: textWhite20(editTitle != null
                              ? 'Update Task'
                              : 'Create Task'))),
                )
              ],
            ),
          ),
        )),
      ),
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
