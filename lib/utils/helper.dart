import 'package:fimber/fimber_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

printData(String value) {
  if (kDebugMode || true) {
    print(
      '$value',
    );
  }
}

class Helper {
  static Color get primary => Color(0xFFEF9C25);
  static Color get splashBackround => Colors.black;
  static Color get colorGray => Colors.white60;
  static Color get fontWhite => Color(0xFFE4E4E4);
  static Color get newsBackround => Color(0xFFedf2f6);


  static void showAlert(String msg, BuildContext context) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  static void printLog() {
    if (kReleaseMode) {
      print('release mode');
    } else {
      print('debug mode');
    }
  }
}
