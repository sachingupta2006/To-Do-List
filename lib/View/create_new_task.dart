import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_list/Utils/colors.dart';
import '../Controller/home_controller.dart';
import '../Utils/text.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({super.key, this.editTitle, this.editIndex});
  final String? editTitle;
  final int? editIndex;

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

var selectedDate = DateTime.now();

class _CreateNewTaskState extends State<CreateNewTask> {
  TextEditingController titleController = TextEditingController();
  var stringDate =
      '${selectedDate.day.toString()}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year.toString().padLeft(2, '0')}'
          .obs;
  HomeController homeController = Get.put(HomeController());

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
                        Get.back();
                        titleController.text = '';
                        selectedDate = DateTime.now();
                        stringDate.value =
                            '${selectedDate.day.toString()}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year.toString().padLeft(2, '0')}';
                      },
                      child: textSecondary15('Cancel')),
                ],
              ),
              SizedBox(height: 15.h),
              textSecondary30w600(
                  widget.editTitle != null ? 'Update Task' : 'Create New Task'),
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
                    hintText: widget.editTitle ?? 'Task title',
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
                onTap: () async {
                  final FormState? form = formKey.currentState;
                  if (form != null && form.validate()) {
                    if (widget.editTitle == null) {
                      var titleValue = titleController.text.obs;
                      homeController.addTask(
                          titleValue.value, stringDate.value, false);
                    } else {
                      var titleValue = titleController.text.obs;

                      homeController.taskData[widget.editIndex!] =
                          titleValue.value;
                      homeController.taskDate[widget.editIndex!] =
                          stringDate.value;
                      homeController.storeData();
                    }
                    Get.back();
                    titleController.text = '';
                    homeController.storeData();
                    selectedDate = DateTime.now();
                    stringDate.value =
                        '${selectedDate.day.toString()}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year.toString().padLeft(2, '0')}';
                  }
                },
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15.h),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: textWhite20(widget.editTitle != null
                            ? 'Update Task'
                            : 'Create Task'))),
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
      selectedDate = pickedDate;
      stringDate.value =
          "${selectedDate.day.toString()}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year.toString().padLeft(2, '0')}";
    });
  }
}
