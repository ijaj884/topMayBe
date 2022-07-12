import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:topmaybe/constant.dart';

import '../../api_base/api_response.dart';
import '../RazorPayScreen/RazorPayScreen.dart';
import 'SetOrder/set_order_bloc.dart';
import 'SetOrder/set_order_model.dart';
import 'order_Confirm/order_Confirm.dart';

class OrderPlace extends StatefulWidget {
  final String addressId;
  final String selectAddress;

  const OrderPlace({Key? key, required this.addressId, required this.selectAddress}) : super(key: key);

  @override
  _OrderPlaceState createState() => _OrderPlaceState();
}

class _OrderPlaceState extends State<OrderPlace> {

  String _paymentMode="";
  bool _orderplaced=false;
  String scheduled="";

  late Map _response;
  TextEditingController _description = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _startTimingController =  TextEditingController();
  SetOrderBloc _setOrderBloc=SetOrderBloc();


  // String _name;
  // String cartId;
   String userId="";
  // String userToken;
  String userPhone="";
  // String totalCartAmount;
  // String coupon_code;
  // Map body;
  late SharedPreferences prefs;
  //double _distance;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    //print(prefs.getString("name"));
    userId = prefs.getString("user_id")!;
    userPhone = prefs.getString("user_phone")!;


    setState(() {
    });
  }



  @override
  void initState() {
    super.initState();
    createSharedPref();
    // _getLocation();
  }
  // navToAttachList(context,OrderPlaceResponseModel data) async {
  //   Future.delayed(Duration.zero, () {
  //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
  //       return RazorPayScreen(snapshotData: data,userToken: userToken,totalCartAmount: totalCartAmount,);
  //     }));
  //     _orderplaced=false;
  //   });
  // }

  String address="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 6.h,
        titleSpacing: 0,
        backgroundColor: darkThemeOrange,
        //Color.fromRGBO(202, 85, 44, 1),
        //Colors.white,
        //bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 18.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Select Payment Mode".toUpperCase(),
          style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          //Add Address Text...
          Card(
            elevation: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,

              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.025,
                  MediaQuery.of(context).size.height * 0.015,
                  MediaQuery.of(context).size.height * 0.015,
                  MediaQuery.of(context).size.height * 0.020),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  color: Colors.white),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //First Row...
                  Row(
                    children: [
                      //Name Text...
                      Expanded(
                          flex: 5,
                          child: Text(
                            "Abilash".toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          )),

                      //Right Icon...
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.done,
                            color: darkThemeBlue,
                            size: MediaQuery.of(context).size.width * 0.05),
                      )
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Text(
                    widget.selectAddress,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.037,
                        color: Colors.black38),
                  ),
                  SizedBox(height: 2.h,),
                  //Third Row...
                  Row(
                    children: [
                      // Phone Number and Icon...
                      Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Icon(Icons.phone_iphone,
                                  color: darkThemeBlue,
                                  size: MediaQuery.of(context).size.width * 0.05),
                              Text(
                                " $userPhone",
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.037,
                                    color: Colors.black38),
                              ),
                            ],
                          )),

                      // Edit and Icon...
                      // Expanded(
                      //     flex: 2,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Icon(Icons.edit,
                      //             color: themeOrangeColor,
                      //             size: screenWidth * 0.05),
                      //         Text(
                      //           " Edit",
                      //           style: TextStyle(
                      //               fontSize: screenWidth * 0.037,
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ],
                      //     )),

                      //Delete and Icon...
                      // Expanded(
                      //     flex: 3,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Icon(Icons.delete_outline,
                      //             color: themeOrangeColor,
                      //             size: screenWidth * 0.05),
                      //         Text(
                      //           " Delete",
                      //           style: TextStyle(
                      //               fontSize: screenWidth * 0.037,
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ],
                      //     )),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 4,),

          Padding(
            padding:  EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.025),
            child: Text(" Select Payment Mode",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: darkThemeOrange,
                  fontSize: 13.sp,
                )),
          ),
          SizedBox(
            height: 1.5.h,
          ),

          // COD and Online Payment Radio Button..

          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.all(Radius.circular(12)),
            ),
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 15.0),
            // margin: EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
            height: 100.0,
            width: 100.w,
            child: Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.black,
                disabledColor: Colors.red,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      // height: 20.0,
                      width: 100.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Radio(
                              activeColor: darkThemeBlue,
                              value: "cod",
                              groupValue: _paymentMode,
                              onChanged: (value) {
                                setState(() {
                                  _paymentMode = value.toString();
                                  print(_paymentMode);
                                });
                              },
                            ),
                          ),
                          const Expanded(
                            flex: 8,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: Text(
                                "Cash On Delivery",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      // height: 20.0,
                      width: 100.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Radio(
                              activeColor: darkThemeBlue,
                              value: "online",
                              groupValue: _paymentMode,
                              onChanged: (value) {
                                setState(() {
                                  _paymentMode = value.toString();
                                  print(_paymentMode);
                                });
                              },
                            ),
                          ),
                          const Expanded(
                            flex: 8,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: Text(
                                "Online Payment",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // SizedBox(height: screenHeight * .2)
        ],
      ),

      bottomSheet: Container(
        margin: const EdgeInsets.only(bottom: 0),
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.5,
              spreadRadius: 0.0,
              offset: Offset(
                  2.0, 2.0), // shadow direction: bottom right
            )
          ],
          // gradient: LinearGradient(
          //   begin: Alignment.centerLeft,
          //   end: Alignment.centerRight,
          //   colors: <Color>[
          //     darkThemeBlue,
          //     darkThemeOrange,
          //   ],
          // ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rs. 2028',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(width: 25.w,),
            // StreamBuilder<ApiResponse<OrderPlaceResponseModel>>(
            //   stream: _orderPlaceBloc.orderPlaceStream,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       switch (snapshot.data.status) {
            //         case Status.LOADING:
            //           return CircularProgressIndicator(
            //               backgroundColor: circularBGCol,
            //               strokeWidth: strokeWidth,
            //               valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)
            //           );
            //
            //           break;
            //         case Status.COMPLETED:
            //         // if (snapshot.data.data.success != null)
            //           {
            //             print("complete");
            //             if(snapshot.data.data.data.paymentType=="cod" && snapshot.data.data.message=="Success" && _orderplaced){
            //               Future.delayed(Duration.zero, () {
            //                 prefs.setString("cart_id","");
            //                 prefs.setString("cart_item_number","");
            //                 prefs.setString("coupon_code","");
            //                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            //                   return NavigationButton(currentIndex: 1,);
            //                 }));
            //                 // Navigator.of(context).pushAndRemoveUntil(
            //                 //     MaterialPageRoute(
            //                 //         builder: (context) => OrderHistory()),ModalRoute.withName("/ShopDetail"));
            //               });
            //               _orderplaced=false;
            //               Fluttertoast.showToast(
            //                   msg: "Order has been Placed Successfully",
            //                   fontSize: 14,
            //                   backgroundColor: Colors.white,
            //                   textColor: darkThemeRed,
            //                   toastLength: Toast.LENGTH_LONG);
            //             }else if(snapshot.data.data.data.paymentType=="online" && _orderplaced){
            //               // managedSharedPref(snapshot.data.data);
            //               navToAttachList(context,snapshot.data.data);
            //               Fluttertoast.showToast(
            //                   msg: "You are Redirecting to Payment Gateway",
            //                   fontSize: 14,
            //                   backgroundColor: Colors.white,
            //                   textColor: darkThemeRed,
            //                   toastLength: Toast.LENGTH_LONG);
            //             }
            //           }
            //           break;
            //         case Status.ERROR:
            //           Fluttertoast.showToast(
            //               msg: "${snapshot.data.message}",
            //               fontSize: 16,
            //               backgroundColor: Colors.white,
            //               textColor: darkThemeRed,
            //               toastLength: Toast.LENGTH_LONG);
            //           //   Error(
            //           //   errorMessage: snapshot.data.message,
            //           // );
            //           break;
            //       }
            //     } else if (snapshot.hasError) {
            //       print("error");
            //     }
            //
            //     return InkWell(
            //       onTap: (){
            //         if(_paymentMode!=null){
            //           _orderplaced=true;
            //           Map _body={
            //             "userid":"$userId",
            //             "cartid":"$cartId",
            //             "addressid":"$addressId",
            //             "payment_type":"$_paymentMode",
            //             "coupon_code": coupon_code,
            //             "order_remarks": _description.text.toString(),
            //             "distance":distanceP.toString(),
            //             "scheduled_at":"${_dateController.text.trim()} ${_startTimingController.text.trim()}"
            //
            //           };
            //           _orderPlaceBloc.orderPlace(_body, userToken);
            //         }else{
            //           Fluttertoast.showToast(
            //               msg: "Please Select Payment Mode",
            //               fontSize: 16,
            //               backgroundColor: Colors.white,
            //               textColor: darkThemeRed,
            //               toastLength: Toast.LENGTH_LONG);
            //         }
            //       },
            //       child: Row(
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(top: 0.0),
            //             child: Text(
            //               " Checkout",
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 14
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: EdgeInsets.only(right: 10.0,left: 3),
            //             child: Icon(
            //               Icons.arrow_forward,
            //               color: Colors.white,
            //               size: 16,
            //             ),
            //           )
            //         ],
            //       ),
            //     );
            //   },
            // )
            InkWell(
              onTap: () {

                if(_paymentMode!=""){

                  if(_paymentMode =="cod"){
                    _orderplaced=true;
                    Map body ={
                      "ord_cus_id": userId,
                      "ord_cadd_id": widget.addressId,
                      "ord_coupon_id": 1,
                      "ord_instruction": "Instructions",
                      "ord_pgc_id": 1
                    };
                    _setOrderBloc.orderPlaced(body);
                  }else{
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                          return const RazorPayScreen(userToken: "",totalCartAmount: "22",);
                        }));
                    Fluttertoast.showToast(
                        msg: "You are Redirecting to Payment Gateway",
                        fontSize: 16,
                        backgroundColor: Colors.white,
                        textColor: darkThemeBlue,
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG);

                  }
                  Get.to(() => const OrderConfirm());

                  //OrderConfirm
                  // Map _body={
                  //   "userid":"$userId",
                  //   "cartid":"$cartId",
                  //   "addressid":"$addressId",
                  //   "payment_type":"$_paymentMode",
                  //   "coupon_code": coupon_code,
                  //   "order_remarks": _description.text.toString(),
                  //   "distance":distanceP.toString(),
                  //   "scheduled_at":"${_dateController.text.trim()} ${_startTimingController.text.trim()}"
                  //
                  // };
                  // _orderPlaceBloc.orderPlace(_body, userToken);
                }else{
                  Fluttertoast.showToast(
                      msg: "Please Select Payment Mode",
                      fontSize: 16,
                      backgroundColor: Colors.white,
                      textColor: darkThemeBlue,
                      gravity: ToastGravity.CENTER,
                      toastLength: Toast.LENGTH_LONG);
                }
              },
              child:StreamBuilder<ApiResponse<SetOrderModel>>(
                stream: _setOrderBloc.setOrderStream,
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    switch (snapshot2.data!.status) {
                      case Status.LOADING:
                        return const CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                darkThemeOrange));

                        break;
                      case Status.COMPLETED:
                        {
                          if (_orderplaced) {

                            if(_paymentMode == "cod"){
                              // managedSharedPref(snapshot2.data!.data);
                              Future.delayed(Duration.zero, () {
                                Get.offAll(() => const OrderConfirm());

                              });
                              Fluttertoast.showToast(
                                  msg: "Order has been Placed Successfully",
                                  fontSize: 14,
                                  backgroundColor: Colors.white,
                                  gravity: ToastGravity.CENTER,
                                  textColor: darkThemeBlue,
                                  toastLength: Toast.LENGTH_LONG);

                             }
                            // else{
                            //   Fluttertoast.showToast(
                            //       msg: "Something is wrong",
                            //       fontSize: 14,
                            //       backgroundColor: Colors.white,
                            //       gravity: ToastGravity.CENTER,
                            //       textColor: darkThemeBlue,
                            //       toastLength: Toast.LENGTH_LONG);
                            // }
                          }
                          _orderplaced = false;

                        }
                        break;
                      case Status.ERROR:
                        if (kDebugMode) {
                          print(snapshot2.error);
                          Fluttertoast.showToast(
                              msg: "Something is wrong",
                              fontSize: 14,
                              backgroundColor: Colors.white,
                              gravity: ToastGravity.CENTER,
                              textColor: darkThemeBlue,
                              toastLength: Toast.LENGTH_LONG);
                          //   Error(
                          //   errorMessage: snapshot.data.message,
                          // );

                        }
                        break;
                    }
                  } else if (snapshot2.hasError) {
                    print("error");
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 1.h),
                    height: 6.h,
                    width: 35.w,
                    decoration: const BoxDecoration(
                      color: darkThemeBlue,
                    ),
                    child:  Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            " Checkout",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              //fontSize: 14
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0,left: 3),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),

            ),
          ],
        ),
      ),
    );

  }

}
