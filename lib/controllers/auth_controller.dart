import 'dart:developer';
import 'package:get/get.dart';
import 'package:reclaim_india/services/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:reclaim_india/utils/constants.dart';

class AuthController extends GetxController {
  var loginLoadingStatus = false.obs;

  Future<int> login({required String userId, required String password}) async {
    // 101-User Doesn't exists
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
