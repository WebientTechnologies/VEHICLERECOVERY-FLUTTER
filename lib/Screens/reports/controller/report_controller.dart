import 'package:get/get.dart';

class ReportController extends GetxController {
  RxInt index = 0.obs;

  void setIndex(int i) {
    index.value = i;
  }
}
