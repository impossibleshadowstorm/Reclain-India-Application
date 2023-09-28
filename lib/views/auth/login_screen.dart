import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reclaim_india/common/widgets/common_input_field.dart';
import 'package:reclaim_india/common/widgets/custom_toasts.dart';
import 'package:reclaim_india/controllers/auth_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_back,
                      size: 23.sp,
                    ),
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  "Hello \nSign In",
                  style: GoogleFonts.arima(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  width: 100.w,
                  padding: EdgeInsets.all(2.5.w),
                  child: Column(
                    children: [
                      CommonInputField.underlinedTextInputField(
                          username, "Username", () {}, Icons.people),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      CommonInputField.underlinedPasswordInputField(
                          password, "Password", () {}, false)
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password ?",
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffF8DB72),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                InkWell(
                  onTap: () async {
                    // Sign In Logic
                    if (_formKey.currentState!.validate()) {
                      int response = await _authController.login(
                        userId: username.text.trimLeft().trimRight(),
                        password: password.text.trimLeft().trimRight(),
                      );

                      if (response == 1) {
                        if (mounted) {
                          CustomToasts.successToast(
                              context, "SuccessFully Logged In..!!");
                        }
                      } else {
                        if (mounted) {
                          CustomToasts.errorToast(
                              context, "Unable to Log In..!!");
                        }
                      }
                    }
                  },
                  child: Container(
                    height: 5.h,
                    width: 80.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xffF8DB72),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      // border: Border.all(color: Colors.black)
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
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "SignUp",
                      style: GoogleFonts.poppins(
                        color: const Color(0xffF8DB72),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
