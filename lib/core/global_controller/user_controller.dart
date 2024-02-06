import 'package:get/get.dart';

import '../utils/save_data.dart';

class UserController extends GetxController {
  var userDetails = {}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadUserDetails();
  }

  void setUserDetails(Map<String, dynamic> data) {
    userDetails.value = data;
  }

  Future<void> loadUserDetails() async {
    final data = await SaveData.getData(
      key: 'user',
    );
    setUserDetails(data);
  }

  Future<void> saveUserDetails(Map<String, dynamic> data) async {
    await SaveData.saveData(
      key: 'user',
      value: data,
    );
    setUserDetails(data);
  }

  Future<void> deleteUserDetails() async {
    await SaveData.deleteData(
      key: 'user',
    );
    setUserDetails({});
  }
}
