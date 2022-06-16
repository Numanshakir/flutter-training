import 'package:get/get.dart';

class TestViewModel extends GetxController {
  RxInt counter = 0.obs;

  onCounterIncrease() {
    counter.value = counter.value + 1;
    print( counter.value);






  }





}
