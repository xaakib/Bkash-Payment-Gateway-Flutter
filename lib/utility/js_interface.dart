import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JavaScriptInterface {
  BuildContext context;

  JavaScriptInterface(context) {
    this.context = context;
  }

  void onPaymentSuccess(String message) {
    // close BkashCheckout page
    Navigator.of(context).pop();
    print("MessagePrint : " + message.toLowerCase());

    Fluttertoast.showToast(
        msg: message.toString(),
        textColor: Colors.white,
        backgroundColor: Colors.pink,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);
  }
}
