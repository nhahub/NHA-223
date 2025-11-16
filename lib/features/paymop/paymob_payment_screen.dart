import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'paymob_constants.dart';

class PaymobPaymentScreen extends StatefulWidget {
  final String paymentToken;

  const PaymobPaymentScreen({super.key, required this.paymentToken});

  @override
  State<PaymobPaymentScreen> createState() => _PaymobPaymentScreenState();
}

class _PaymobPaymentScreenState extends State<PaymobPaymentScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // إنشاء Controller للـ WebView
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
          "https://accept.paymob.com/api/acceptance/iframes/${PaymobConstants.iframeId}?payment_token=${widget.paymentToken}",
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay with Card")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
