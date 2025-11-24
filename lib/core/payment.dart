import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class Payment{

  static void init(){
    PaymentData.initialize(
      apiKey: "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBME9UTTVOQ3dpYm1GdFpTSTZJakUzTmpNNU5qWTJPVGd1T1RreU5UUXpJbjAuMlFqaWhBMFdlelJFaW1Wbmd3RWxtYTVEUHM1QUdkS2lFVl9KZmo3LUlha1FVSHRqdnkzSDdkTHZNejlBMnAxc1hNQzNnbzAteW5PUW91cjlqdTJYbHc=",
      iframeId: "927415",
      integrationCardId: "5113269",
      integrationMobileWalletId: "5113314",
    );
  }
}