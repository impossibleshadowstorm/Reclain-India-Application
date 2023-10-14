import 'dart:developer';
import 'dart:js_interop_unsafe';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reclaim_india/services/global.dart';
import 'package:reclaim_india/utils/constants.dart';

class MainApplicationController extends GetxController {
// Logic Beghind the matching Document Start

  Future<void> findMatchingDocuments() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final CollectionReference lostCollection = firestore.collection(Constants.lost);
      final CollectionReference foundCollection = firestore.collection(Constants.found);

// Fetch all documents from 'lost' and 'found' collections
      final QuerySnapshot lostQuerySnapshot = await lostCollection.get();
      final QuerySnapshot foundQuerySnapshot = await foundCollection.get();

// Create a set of document IDs from the 'found' collection
      final Set<String> foundDocumentIds =
          foundQuerySnapshot.docs.map((doc) => doc.id).toSet();

// Iterate through the 'lost' collection and process matching documents
      for (final lostDoc in lostQuerySnapshot.docs) {
        final lostDocumentId = lostDoc.id;

        if (foundDocumentIds.contains(lostDocumentId)) {
          log('Matching Document ID: $lostDocumentId');
          log('Data from "lost" collection: ${lostDoc.data()}');

// Find the matching document in the 'found' collection
          final foundDoc = foundQuerySnapshot.docs
              .firstWhere((doc) => doc.id == lostDocumentId);

          log('Data from "found" collection: ${foundDoc.data()}');

          try {
            Map<String, dynamic> recoverData;

// Set data in the 'matched' collection
            await firestore.collection(Constants.matched).doc(lostDocumentId).set({
              'engine': lostDoc['engine'],
              'chassis': lostDoc['chassis'],
              'lost_reported': lostDoc['station_code'],
              'lost_fir': lostDoc['fir_num'],
              'found_reported': foundDoc['station_code'],
              'found_fir': foundDoc['fir_num'],
              'owner': lostDoc['name'],
              'mobile': lostDoc['mobile'],
              'address': lostDoc['address'],
              'status': false,
              'e_challan': null,
            });

// Delete from the 'lost' collection
            await lostCollection.doc(lostDocumentId).delete();

// Delete from the 'found' collection
            await foundCollection.doc(lostDocumentId).delete();

            log("Successfully processed and deleted matching documents");
          } catch (e) {
            log('Error processing documents: $e');
          }
        }
      }
    } catch (e) {
      log('Error retrieving and processing matching documents: $e');
    }
  }

// Logic Behind the Matching Document End


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
          .delete()
          .then((value) async {
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
          .delete()
          .then((value) async {
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
        }).then((value) async {
          String stateCode = rc.substring(0, 2);
          String districtCode = rc.substring(2, 4);
          String series = rc.substring(4, rc.length - 4);
          String runningSerial = rc.substring(rc.length - 4);
          await FirebaseFirestore.instance
              .collection(Constants.search)
              .doc(stateCode)
              .collection(districtCode)
              .doc(series)
              .collection(runningSerial)
              .set({
            'status': 'Lost',
            'firNumber': fir,
            'stationCode':
                Global.storageServices.getString(Constants.stationCode),
          });
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
        }).then((value) async {
          String stateCode = rc.substring(0, 2);
          String districtCode = rc.substring(2, 4);
          String series = rc.substring(4, rc.length - 4);
          String runningSerial = rc.substring(rc.length - 4);
          await FirebaseFirestore.instance
              .collection(Constants.search)
              .doc(stateCode)
              .collection(districtCode)
              .doc(series)
              .collection(runningSerial)
              .set({
            'status': 'Found',
            'firNumber': fir,
            'stationCode':
                Global.storageServices.getString(Constants.stationCode),
          });
        });
      });

      return 1;
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }
}
