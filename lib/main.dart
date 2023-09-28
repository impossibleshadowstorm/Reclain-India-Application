import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaim_india/controllers/auth_controller.dart';
import 'package:reclaim_india/controllers/main_application_controller.dart';
import 'package:reclaim_india/views/splash_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  AuthController authController = Get.put(AuthController());
  MainApplicationController mainApplicationController =
      Get.put(MainApplicationController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, type) {
      return GetMaterialApp(
        title: 'Reclaim India',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      );
    });
  }
}
