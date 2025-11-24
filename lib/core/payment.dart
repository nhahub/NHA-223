import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class Payment{

  static void init(){
    PaymentData.initialize(
      apiKey: dotenv.env["API_PAYMENT_KEY"]!,
      iframeId: dotenv.env["I_FRAME_ID"]!,
      integrationCardId: dotenv.env["integrationCardId"]!,
      integrationMobileWalletId: dotenv.env["integrationMobileWalletId"]!,
    );
  }
}