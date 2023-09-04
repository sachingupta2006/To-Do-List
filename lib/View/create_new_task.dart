import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Routes/Utils/colors.dart';
import 'package:to_do_list/Routes/Utils/home_controller.dart';
import '../Routes/Utils/text.dart';

var selectedDate = DateTime.now().obs;
var stringDate =
    '${selectedDate.value.day.toString()} / ${selectedDate.value.month.toString()} / ${selectedDate.value.year.toString()}'
        .obs;
TextEditingController titleController = TextEditingController();

class CreateNewTask extends StatelessWidget {
  const CreateNewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Get.back(),
                    child: textSecondary15('Cancel')),
              ],
            ),
            SizedBox(height: 15.h),
            textSecondary30w600('Create New Task'),
            SizedBox(height: 25.h),
            TextFormField(
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
            TextFormField(
              style: const TextStyle(color: Colors.white),
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white60, width: 1))),
            ),
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
              onTap: () {
                var titleValue = titleController.text.obs;
                HomeController().taskData.value =
                    List.from(HomeController().taskData)..add(titleValue);
                Get.back();
                titleController.text = '';
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
      )),
    );
  }

  void presentDatePicker(context) {
    TextEditingController dateController = TextEditingController();

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
      dateController.text =
          "  ${selectedDate.value.day.toString()}/${selectedDate.value.month.toString().padLeft(2, '0')}/${selectedDate.value.year.toString().padLeft(2, '0')}";
    });
  }
}


//  answeredData.value =
//                                     List.from(answeredData.value)
//                                       ..add(selectedRadio.value);