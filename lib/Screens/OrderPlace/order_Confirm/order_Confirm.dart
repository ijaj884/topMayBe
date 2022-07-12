import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:topmaybe/Screens/HomeScreen/home_screen.dart';
import 'package:topmaybe/constant.dart';


class OrderConfirm extends StatefulWidget {
  const OrderConfirm({Key? key}) : super(key: key);

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        children: [

          SizedBox(height: 25.h),
          Center(
            child: Image.asset(
              "images/confirm_tick.png",
              height: 100,
              width: 100,//30.0.w,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          const Center(
            child: Text('Order confirmed',
              style: TextStyle(
                color: Color.fromRGBO(0 , 157 ,143, 1),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          //const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text('Thank you, Abhilash. Your order is confirmed',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          //SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Center(
              child: Text("Your order hasn't shipped yet but we will send you an email when it does.",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 10.5.sp,
                ),
              ),
            ),
          ),

        ],
      ),
      bottomSheet: InkWell(
        onTap: () {
          Get.to(() => const HomeScreen());//Get.to(AddressAddPage());
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 0),
          height: 55,
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Colors.blue[800]!,
                Colors.blue[800]!,
              ],
            ),
          ),
          child: Center(
            child: Text('CONTINUE SHOPPING',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
