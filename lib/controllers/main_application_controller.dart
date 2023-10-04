import 'dart:developer';
import 'dart:js_interop_unsafe';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reclaim_india/services/global.dart';
import 'package:reclaim_india/utils/constants.dart';

class MainApplicationController extends GetxController {

  Future<int> foundDel({required String fir}) async {
    //  101 - Document Doesn't Exist
    //  1 - Delete Sucessfully
    //  0 - Error


    try {
      final userDocument = await FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(Global.storageServices.getString(Constants.stationCode))
          .collection(Constants.adminFound)
          .doc(fir)
          .get();
      if (!userDocument.exists) {
        return 101;
      }

      await FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(Global.storageServices.getString(Constants.stationCode))
          .collection(Constants.adminFound)
          .doc(fir)
          .delete().then((value) async {
        await FirebaseFirestore.instance
            .collection(Constants.found)
            .doc(userDocument['rc'])
            .delete();
      });

      return 1;
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }






  Future<int> lostDel({required String fir}) async {
    //  101 - Document Doesn't Exist
    //  1 - Delete Sucessfully
    //  0 - Error


    try {
      final userDocument = await FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(Global.storageServices.getString(Constants.stationCode))
          .collection(Constants.adminLost)
          .doc(fir)
          .get();
      if (!userDocument.exists) {
        return 101;
      }

      await FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(Global.storageServices.getString(Constants.stationCode))
          .collection(Constants.adminLost)
          .doc(fir)
          .delete().then((value) async {
        await FirebaseFirestore.instance
            .collection(Constants.lost)
            .doc(userDocument['rc'])
            .delete();
      });

      return 1;
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }

  Future<int> lostAdd({
    required String rc,
    required String engine,
    required String chassis,
    required String fir,
    required String station,
    required String name,
    required String address,
    required String contact,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(Global.storageServices.getString(Constants.stationCode))
          .collection(Constants.adminLost)
          .doc(fir)
          .set({
        'rc': rc,
        'engine': engine,
        'chassis': chassis,
        'mobile': contact,
        'address': address,
        'name': name,
      }).then((value) async {
        await FirebaseFirestore.instance
            .collection(Constants.lost)
            .doc(rc)
            .set({
          'engine': engine,
          'chassis': chassis,
          'fir_num': fir,
          'station_code':
              Global.storageServices.getString(Constants.stationCode),
        });
      });

      return 1;
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }

  Future<int> foundAdd({
    required String rc,
    required String engine,
    required String chassis,
    required String fir,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(Global.storageServices.getString(Constants.stationCode))
          .collection(Constants.adminFound)
          .doc(fir)
          .set({
        'rc': rc,
        'engine': engine,
        'chassis': chassis,
      }).then((value) async {
        await FirebaseFirestore.instance
            .collection(Constants.found)
            .doc(rc)
            .set({
          'engine': engine,
          'chassis': chassis,
          'fir_num': fir,
          'station_code':
              Global.storageServices.getString(Constants.stationCode),
        });
      });

      return 1;
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }
}
