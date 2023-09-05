import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_list/View/dashboard.dart';

import '../Routes/routes_name.dart';
import '../Utils/colors.dart';
import '../Utils/text.dart';
import 'create_new_task.dart';

class EditTask extends StatelessWidget {
  const EditTask({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController editTitleController =
        TextEditingController(text: '${taskData[index].value}');
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
                      },
                      child: textSecondary15('Cancel')),
                ],
              ),
              SizedBox(height: 15.h),
              textSecondary30w600('Update Current Task'),
              SizedBox(height: 25.h),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return 'Please enter title';
                  }
                  return null;
                },
                controller: editTitleController,
                // autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Task title',
                    hintStyle: const TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white60, width: 1))),
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
                // onTap: () async {
                //   final FormState? form = formKey.currentState;
                //   if (form != null && form.validate()) {
                //     var titleValue = titleController.text.obs;
                //     addTask(titleValue.value, stringDate.value);
                //     Get.toNamed(RouteName.dashboard);
                //     titleController.text = '';
                //     storeData();
                //   }
                // },
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15.h),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: textWhite20('Update Task'))),
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
