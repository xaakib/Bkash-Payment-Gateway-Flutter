import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/payment_request.dart';
import '../utility/js_interface.dart';

class BkashPayment extends StatefulWidget {
  final String amount;
  final String intent;

  const BkashPayment({Key key,  this.amount,  this.intent})
      : super(key: key);

  @override
  _BkashPaymentState createState() => _BkashPaymentState();
}

class _BkashPaymentState extends State<BkashPayment> {
   WebViewController _controller;
   JavaScriptInterface _javaScriptInterface;

  bool isLoading = true;
  var paymentRequest = "";

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    var request = PaymentRequest( amount: widget.amount, intent: widget.intent);
    paymentRequest = "{paymentRequest: ${jsonEncode(request)}}";
    print("paymentRequest" + paymentRequest);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cinebaz Checkout')),
      body: Stack(
        children: [
          // Here I patched the default WebView plugin to load
          // local html (along with Javascript and CSS) files from local assets.
          // ref -> https://medium.com/flutter-community/loading-local-assets-in-webview-in-flutter-b95aebd6edad
          WebView(
            //initialUrl: 'http://localhost:80/bkash/payment.php', // api host link .
            initialUrl: 'assets/www/checkout_120.html', // api host link .
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: Set.from([
              JavascriptChannel(
                  name: 'onPaymentSuccess',
                  onMessageReceived: (JavascriptMessage message) {
                    _javaScriptInterface = JavaScriptInterface(context);
                    _javaScriptInterface.onPaymentSuccess(message.message);
                  })
            ]),
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;

              _controller.clearCache();
            },
            onPageFinished: (_) {
              _controller.evaluateJavascript(
                  "javascript:callReconfigure($paymentRequest)");
              print("paymentRequest :  $paymentRequest");

              _controller.evaluateJavascript("javascript:clickPayButton()");
              setState(() => isLoading = false);
              print(
                  "Pyment Done>>>>>>" + _controller.canGoForward().toString());
            },
          ),

          isLoading ? Center(child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }
}
