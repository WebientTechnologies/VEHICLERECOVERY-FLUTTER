import 'package:hive_flutter/adapters.dart';

import '../../Screens/HomeScreen/model/vehicle_sm_hive.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  factory HiveService() {
    return _instance;
  }

  HiveService._internal();

  Box? _myBox;

  Future<void> initialize() async {
    // final appDocumentDirectory =
    //     await path_provider.getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    Hive.registerAdapter(VehicleSingleModelAdapter());

    // Open your Hive box here
    _myBox = await Hive.openBox<VehicleSingleModel>('vehicle');
  }

  Box? get myBox => _myBox;
}
