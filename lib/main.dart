import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => GetMaterialApp(
            title: 'To-Do List',
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            getPages: AppRoutes.appRoutes()));
  }
}
