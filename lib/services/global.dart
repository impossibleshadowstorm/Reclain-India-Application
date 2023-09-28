import 'package:firebase_core/firebase_core.dart';
import 'package:reclaim_india/services/storage_services.dart';
import 'api/api_client.dart';
import 'api_services.dart';

class Global {
  static late StorageServices storageServices;
  static late ApiClient apiClient;

  static Future init() async {
    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    storageServices = await StorageServices().init();
    apiClient = ApiServices().init();
  }
}
