import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';

class CommonInputField {
  static Widget textInputField(TextEditingController controller,
      String labelText, Function validator, IconData iconData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Constants.lightGreyBorderColor),
      ),
      child: TextFormField(
        cursorColor: Constants.primaryColor,
        validator: (value) => validator(value),
        controller: controller,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Constants.primaryColor),
          labelText: labelText,
          border: InputBorder.none,
          icon: Icon(
            iconData,
            size: 28,
            color: Constants.primaryColor,
          ),
        ),
      ),
    );
  }

  static Widget passwordInputField(TextEditingController controller,
      String labelText, Function validator, String showPass) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: Constants.lightGreyBorderColor),
        ),
        child: TextFormField(
            controller: controller,
            validator: (value) => validator(value),
            obscureText: false,
            cursorColor: Constants.primaryColor,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Constants.primaryColor),
              suffixIcon: InkWell(
                onTap: () {
                  // if(showPass == "login"){
                  //   mainApplicationController.loginShow.value = !mainApplicationController.loginShow.value;
                  // }
                  // else if(showPass == "signup") {
                  //   mainApplicationController.signupShow.value = !mainApplicationController.signupShow.value;
                  // } else{
                  //   mainApplicationController.confirmSignupShow.value = !mainApplicationController.confirmSignupShow.value;
                  // }
                },
                child: Icon(
                  Icons.remove_red_eye,
                  size: 28,
                  color: Constants.primaryColor,
                ),
              ),
              border: InputBorder.none,
              icon: Icon(
                Icons.lock,
                size: 28,
                color: Constants.primaryColor,
              ), //icon at head of input
            )),
      );
    });
  }

  static Widget underlinedPasswordInputField(TextEditingController controller,
      String labelText, Function validator, bool showPass) {
    return TextFormField(
      validator: (v) {
        return "";
      },
      controller: controller,
      obscureText: showPass,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusColor: Colors.blue,
        prefixIcon: const Icon(
          Icons.lock,
        ),
        labelText: labelText,
        suffixIcon: const Icon(Icons.remove_red_eye),
      ),
    );
  }

  static Widget underlinedTextInputField(TextEditingController controller,
      String labelText, Function validator, IconData iconData) {
    return TextFormField(
      controller: controller,
      validator: (v) {
        return "";
      },
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelText: labelText,
        prefixIcon: Icon(iconData),
      ),
    );
  }
}
