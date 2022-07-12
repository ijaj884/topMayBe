
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topmaybe/Screens/HomeScreen/home_screen.dart';
import 'package:topmaybe/constant.dart';

import '../../api_base/api_base_helper.dart';
import '../OrderPlace/order_Confirm/order_Confirm.dart';



class RazorPayScreen extends StatefulWidget {
  //final OrderPlaceResponseModel snapshotData;
  final String userToken;
  final String totalCartAmount;

  const RazorPayScreen({Key? key, required this.userToken, required this.totalCartAmount}) : super(key: key);
  //const RazorPayScreen({ required this.userToken, required this.totalCartAmount});



  @override
  _RazorPayScreenState createState() => _RazorPayScreenState();
}

class _RazorPayScreenState extends State<RazorPayScreen> {
  static const platform = MethodChannel("razorpay_flutter");

  // String _baseUrl = "http://demo.ewinfotech.com/bookingapp/public/api/";

  late Razorpay _razorpay;

  late SharedPreferences prefs;

  String userPhone="";
  String userEmail="";

  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  late Map _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: darkThemeOrange,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
            title: const Center(
              child: Text(
                "TopMayBe PAYMENT",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.payment,
                  color: Colors.white,
                ), onPressed: () {  },
              ),
            ]),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/logo.png',
                    fit: BoxFit.cover,
                    height: 50,//MediaQuery.of(context).size.height * 0.3,
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  RaisedButton(
                      color: Colors.red,
                      onPressed: openCheckout,
                      child: const Text(
                        '  Pay Using RazorPay  ',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ))
                ])),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openCheckout();
  }

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userPhone = prefs.getString("user_phone")!;
    userEmail = prefs.getString("email")!;
    /*setState(() {});*/
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    // 'key': 'rzp_test_BgJqsaZuDQ01OE',
    //  'amount': 100,
    // "image":
    //     "https://www.google.com/url?sa=i&url=https%3A%2F%2Ftimesofindia.indiatimes.com%2Flife-style%2Ffood-news%2Fcoronaeffect-restros-food-aggregators-step-up-their-game-to-ensure-safe-delivery-and-pickup-of-food%2Farticleshow%2F75891020.cms&psig=AOvVaw0_DmeL0vcWqQtop0stSsvg&ust=1605856153360000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKDcgr-Gju0CFQAAAAAdAAAAABAI",

    // 'key': 'rzp_test_ehhzapZ5Arkz2H',
    var options = {
      //rzp_test_rkCEZ1C6W2O0Ji //rzp_test_p000L8FV2LBwx8
      'key': 'rzp_test_p000L8FV2LBwx8',

      'name': 'TopMaybe',
      'description': 'TopMaybe Order Payment',
      'order_id': '15254515',
      'amount' : 100,
      'prefill': {
        'contact': '$userPhone',
        'email': 'abv@gmail.com',
        'name': 'suman'
      },
      'external': {
        'wallets': ['paytm']
      },
      "theme": {"color": "#ca562c"}
    };
    print(options);
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Map _body = {
      "ord_orh_id": 2,
      "ord_is_paid": true,
      "ord_transaction_no": response.orderId!
    };
    try{
      _response = await _apiBaseHelper.post(
        "CusApi/Order/SetPaymentStatus", _body,);
    }catch(ex){
      if (kDebugMode) {
        print(ex);
      }
    }

    prefs.setString("cart_id", "");
    prefs.setString("coupon_code", "");
    print("cart id at payment success 1 == ${prefs.getString("cart_id")}");

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const OrderConfirm()),
            (Route<dynamic> route) => false);


    // builder: (context) =>LoginScreen(title: 'MyDoc')));
    //  builder: (context) =>MyApp()));
    // builder: (context) =>IndexPage(channelName: 'AriDoc')));
    ///////////
    prefs.setString("cart_id", "");
    prefs.setString("coupon_code", "");
    print("cart id at payment success 2 == ${prefs.getString("cart_id")}");

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print(response.message);
    print("error");
    print("Ijaj");
    Map _body = {
      "ord_orh_id": 2,
      "ord_is_paid": false,
      "ord_transaction_no": response.code
    };
    _response = await _apiBaseHelper.post(
      "CusApi/Order/SetPaymentStatus", _body,);
    //prefs.setString("cart_id", "");
    prefs.setString("coupon_code", "");
    //print("cart id at payment success 2 == ${prefs.getString("cart_id")}");
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        timeInSecForIosWeb: 4);
    print("ERROR: " + response.code.toString() + " - " + response.message!);
    prefs.setString("cart_id", "");
    prefs.setString("coupon_code", "");

    print("cart id at payment success 2 == ${prefs.getString("cart_id")}");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!, timeInSecForIosWeb: 4);
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => IndexPage()));
  }
}

// print(widget.snapshotData.data.transactionId.toString()+"here is the Transaction iiiiidddd");
// double price=double.parse(widget.totalCartAmount);
// print("$price+ amount in double ");
// // print(int.parse(widget.totalCartAmount));
// price=price*100;
// print("$price+ amount in double *100 ");
// int price1=price.toInt();
// print("$price1+ amount in double price1 ");
