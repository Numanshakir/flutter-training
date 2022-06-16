import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageHandler extends GetxController {
  final box = GetStorage();

  setEmail(String token) {
    var result = box.write('email', token);

    print(result);
  }

  getEmail() {
    var result = box.read('email');

    return result;
  }

  removeEmail() {
    box.remove('email');
  }
}
