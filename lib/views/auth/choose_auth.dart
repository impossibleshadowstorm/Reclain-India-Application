import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reclaim_india/views/auth/login_screen.dart';
import 'package:reclaim_india/views/auth/signup_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChooseAuth extends StatefulWidget {
  const ChooseAuth({super.key});

  @override
  State<ChooseAuth> createState() => _ChooseAuthState();
}

class _ChooseAuthState extends State<ChooseAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon(
              //   Icons.arrow_back,
              //   size: 23.sp,
              // ),
              SizedBox(
                height: 7.h,
              ),
              Text(
                "WELCOME \nBACK",
                style: GoogleFonts.arima(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 7.h),
              InkWell(
                onTap: () {
                  Get.to(() => const LoginScreen());
                },
                child: Container(
                  height: 7.h,
                  width: 80.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    "SIGN IN",
                    style: GoogleFonts.poppins(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const SignupScreen());
                },
                child: Container(
                    height: 7.h,
                    width: 80.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xffF8DB72),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      // border: Border.all(color: Colors.black)
                    ),
                    child: Text(
                      "SIGN UP",
                      style: GoogleFonts.poppins(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                "IndiaLost: Nationwide Lost Item Recovery Solution, Unified Retrieval and Tracking Solution.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
