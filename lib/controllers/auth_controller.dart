import 'dart:developer';
import 'package:get/get.dart';
import 'package:reclaim_india/services/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:reclaim_india/utils/constants.dart';

class AuthController extends GetxController {
  var loginLoadingStatus = false.obs;
  var registerLoading = false.obs;
  Future<int> signup({
    required String userId,
    required String password,
    required String mobile,
    required String address,
    required String io,
  }) async {
    // 101-User exist
    // 0-Error
    // 1-Signup Successfully
    registerLoading.value = true;
    try {
      final existingUser = FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(userId)
          .get();
      if (existingUser.exists) {
        registerLoading.value = false;
        return 101;
      } else {
        var hashPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        await FirebaseFirestore.instance
            .collection(Constants.admin)
            .doc(userId)
            .set({
          'address': address,
          'mobile': mobile,
          'investigating_officer': io,
          'password': hashPassword,
          'user_id': userId
        });
        return 1;
      }
    } catch (e) {
      log(e);
      return 0;
    }
  }

  Future<int> login({required String userId, required String password}) async {
    // 101-User Doesn't exist
    // 102-Password Doesn't match
    // 0-Error
    // 1-Login Successfully
    loginLoadingStatus.value = true;
    try {
      final userDocument = await FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(userId)
          .get();
      if (!userDocument.exists) {
        loginLoadingStatus.value = false;
        return 101;
      }

      String dbPassword = userDocument[Constants.password];
      Global.storageServices.setString(Constants.stationCode, userDocument.id);

      loginLoadingStatus.value = false;

      return BCrypt.checkpw(password, dbPassword) ? 1 : 102;
    } catch (e) {
      log(e.toString());
      loginLoadingStatus.value = false;
      return 0;
    }
  }
}
