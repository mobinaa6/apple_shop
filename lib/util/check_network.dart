import 'dart:io';

class NetworkChecker {
  static bool isInternet = false;

  static void ChackInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isInternet = true;
      }
    } on SocketException catch (ex) {
      isInternet = false;
    }
  }
}
