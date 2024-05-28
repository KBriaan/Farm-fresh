
import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:soko_fresh/Service/shared_preference.dart';
import 'package:soko_fresh/widgets/widget_support.dart';

class Wallet extends StatefulWidget {

  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  
   
String? Wallet;
int? add;

getthesharedpref() async {
  Wallet =await SharedPreferenceHelper().getUserWallet();
  setState(() {
    
  });
}

ontheload() async{
  await getthesharedpref();
  setState(() {
    
  });
}
@override
void initState(){
  ontheload();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
          margin: const EdgeInsets.only(top: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 3.4,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Center(
                    child: Text(
                      ' Wallet',
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
                child: Row(
                  children: [
                    Image.asset(
                      'android/assets/images/wallet.png',
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 40.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your total pay',
                          style: AppWidget.HeadlineTextFieldStyle(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Add money in Kenya shillings',
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        startTransaction(amount: 50, phone: '254799860103');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFF2F2F2)),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          '50',
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        startTransaction(amount: 100, phone: '254799860103');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFF2F2F2)),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          '100',
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        startTransaction(amount: 200, phone: '254799860103');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFF2F2F2)),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          '200',
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        startTransaction(amount: 500, phone: '254799860103');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFF2F2F2)),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          '500',
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        startTransaction(amount: 1000, phone: '254799860103');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFF2F2F2)),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          '1000',
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  startTransaction(amount: 10, phone: '254799860103');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xFF008080),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                      child: Text(
                    'Add Money ',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
                ),
              ),
            ],
          )),
    );
  }
}

Future<dynamic> startTransaction(
    {required double amount, required String phone}) async {
  dynamic transactionInitialisation;
//Wrap it with a try-catch
  try {
//Run it
    transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode:
            '174379', //use your store number if the transaction type is CustomerBuyGoodsOnline
        transactionType: TransactionType
            .CustomerPayBillOnline, //or CustomerBuyGoodsOnline for till numbers
        amount: amount,
        partyA: phone,
        partyB: '174379',
        callBackURL: Uri(
          scheme: "https",
          host: "us-central1-nigel-da5d1.cloudfunctions.net",
          path: "/paymentCallback",
        ),
        accountReference: 'kipkirui',
        phoneNumber: phone,
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: 'payment',
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');
    var result = transactionInitialisation;
    print('RESULT: $transactionInitialisation');
     if (transactionInitialisation['ResultCode'] == 0) {
      // Transaction successful, update wallet balance
    } else {
      // Transaction failed, handle error
      print('Transaction failed: $transactionInitialisation');
    }
  } catch (e) {
    print('CAUGHT EXEPTION$e');
  }
}

  

