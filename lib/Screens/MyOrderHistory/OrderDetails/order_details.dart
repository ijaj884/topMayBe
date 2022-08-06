
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../constant.dart';
import '../my_order_history_model.dart';

class OrderDetails extends StatefulWidget {
  final String orderid;
  final String orderDateTime;
  final String orderStatus;
  final String name;
  final String cityName;
  final String pinCode;
  final String iskuImage_1;
  final String itmName;
  final String ?secondaryVarName;
  final String ? secondaryVaroName;
  final String ? primaryVarName;
  final String ? primaryVaroName;
  final String ordGrandTotal;
  final String discountAmount;


  //const OrderDetails({ required this.orderid, this.data});
  const OrderDetails({Key? key, required this.orderid, required this.orderDateTime,
    required this.orderStatus, required this.name, required this.cityName, required this.pinCode,
    required this.iskuImage_1, required this.itmName,  this.secondaryVarName, this.secondaryVaroName,
    this.primaryVarName, this.primaryVaroName, required this.ordGrandTotal, required this.discountAmount}) : super(key: key);


  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {


  @override
  void initState() {
    super.initState();

    createSharedPref();
  }

  late SharedPreferences prefs;
  String userToken = "";
  String userId="";

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userId=prefs.getString("user_id")!;

    //userToken = prefs.getString("user_token")!;

    //vendorId = prefs.getString("vendorId");
    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final scH = MediaQuery.of(context).size.height;
    final scW = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          backgroundColor: darkThemeOrange,
          //Color.fromRGBO(202, 85, 44, 1),
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
            "Order Details",
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          actions: [
            //const CartIconWidget(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.search,
            //     color: darkThemeBlue,
            //     size: 18.sp,
            //   ),
            // ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            Container(
              margin:  const EdgeInsets.only(
                top: 15.0,
              ),
              child: Center(
                child: Text(
                  "ORDER ID : ${widget.orderid}",
                  style:  const TextStyle(
                      color: darkThemeBlue,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 8.0,left: scW*0.05),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  // Text(
                  //   "Transaction Status ${snapshot.data.data.orderDetails[0].transactionStatus}",
                  //   style: new TextStyle(color: Colors.black, fontSize: 14.0),
                  // ),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0,right: 8
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        // Icon(
                        //   Icons.circle,
                        //   color: themePinkColor,size: 15,
                        // ),
                        Container(height: 60,color: Colors.green,width: 3,),
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration:  const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ordered",
                        style:  TextStyle(color: Colors.black, fontSize: 14.0,fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        DateFormat.yMMMMEEEEd().format(DateFormat("yyyy-MM-dd").parse(widget.orderDateTime, true)),
                        style:  const TextStyle(color:Colors.black, fontSize: 14.0),
                      ),
                      SizedBox(height: 35,),

                      const Text(
                        "Order Status",
                        style: TextStyle(color:Colors.black, fontSize: 14.0,fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height:5,),
                      widget.orderStatus == "Order Placed" ?
                      const Text(
                        "Successful",
                        style:  TextStyle(color: Colors.green, fontSize: 14.0,fontWeight: FontWeight.bold),
                      ):
                      const Text(
                        "FAILED",
                        style:  TextStyle(color: Colors.red, fontSize: 14.0,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                ],
              ),
            ),

            Container(
              // height: scH * 0.26,
              padding: const EdgeInsets.all(15.0),
              child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, bottom: 10),
                            child: Icon(
                              Icons.home,
                              color: Colors.orange,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 12, bottom: 10),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Shipping Details",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Home",
                                    style: TextStyle(
                                        color: darkThemeOrange,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${widget.cityName}, ${widget.pinCode}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            Container(
              //height: scH * 0.3,
              padding: const EdgeInsets.all(15.0),
              child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Text(
                                "Order Details",
                                style: TextStyle(
                                    color: darkThemeOrange,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 12, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  widget.name !=" " ?
                                  Text(
                                    widget.name,
                                    style: const TextStyle(
                                      color:Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ):
                                  Text(
                                    "Name",
                                    style: const TextStyle(
                                      color:Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  const Text(
                                    "9876543210",
                                    style: TextStyle(
                                      color:Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            margin: const EdgeInsets.only(top: 4.0, bottom: 14.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: scW * 0.2,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                      ),
                                      child: FadeInImage(
                                        image: NetworkImage(
                                          widget.iskuImage_1,
                                        ),
                                        placeholder: const AssetImage("images/headphone.jpg"),
                                        //fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 15.0,
                                          top: 5.0,
                                          bottom: 5.0,
                                          right: 10.0),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                //flex:6,
                                                child: Text(
                                                    widget.itmName,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines:1,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,

                                                      fontSize: scW * 0.04,
                                                    )),
                                              ),

                                            ],
                                          ),
                                          widget.secondaryVarName !=null ? SizedBox(height: 1.h,):const SizedBox(),
                                          widget.secondaryVarName !=null ? Text(
                                            "${widget.secondaryVarName} : ${widget.secondaryVaroName} ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: scW * 0.03),
                                          ): Container(),
                                          SizedBox(height: 1.h,),
                                          widget.primaryVarName !=null ? Text(
                                            "${widget.primaryVarName} : ${widget.primaryVaroName} ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: scW * 0.03),
                                          ): Container(),
                                          Container(
                                            margin: const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Rs ${widget.ordGrandTotal}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: scW * 0.032),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 18.0),
                                                  // child: Image.asset(
                                                  //   "images/heart2.png",
                                                  //   width: 25.0,
                                                  //   height: 25.0,
                                                  // ),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),

                      widget.discountAmount !="0" ?
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 10.0, right: 10,bottom: 15),
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 4,
                              child: Text(
                                "Coupon discount",
                                style: TextStyle(
                                  color: darkThemeOrange,
                                  fontSize: 14.0,fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "\u20B9 ${widget.discountAmount}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ):
                      Container(),
                      const Padding(
                        padding:
                        EdgeInsets.only(left: 10.0, right: 10),
                        child: Divider(),
                      ),
                      // Padding(
                      //   padding:
                      //   const EdgeInsets.only(left: 10.0, right: 10),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         flex: 4,
                      //         child: Text(
                      //           "Order Amount",
                      //           style: TextStyle(
                      //             color: themeOrangeColor,
                      //             fontSize: 14.0,
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 2,
                      //         child: Text(
                      //           "Rs. ${snapshot.data!.data!.orderDetails![0]!.orderAmount}",
                      //           style: TextStyle(
                      //             color: themeOrangeColor,
                      //             fontSize: 14.0,),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding:
                      //   const EdgeInsets.only(left: 10.0, right: 0),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         flex: 4,
                      //         child: Text(
                      //           "Tax",
                      //           style: TextStyle(
                      //             color: themeOrangeColor,
                      //             fontSize: 14.0,
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 2,
                      //         child: Text(
                      //           " + ${snapshot.data!.data!.orderDetails![0]!.taxAmount}",
                      //           style: TextStyle(
                      //             color: themeOrangeColor,
                      //             fontSize: 14.0,),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding:
                      //   const EdgeInsets.only(left: 10.0, right: 0),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         flex: 4,
                      //         child: Text(
                      //           "Delivery Charge",
                      //           style: TextStyle(
                      //             color: themeOrangeColor,
                      //             fontSize: 14.0,
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 2,
                      //         child: Text(
                      //           " + ${snapshot.data!.data!.orderDetails![0]!.deliveryAmount}",
                      //           style: TextStyle(
                      //             color: themeOrangeColor,
                      //             fontSize: 14.0,),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding:
                      //   const EdgeInsets.only(left: 10.0, right: 10),
                      //   child: Divider(),
                      // ),
                      /*
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 10.0, right: 10,bottom: 15),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                "Total Amount",
                                style: TextStyle(
                                  color: themePinkColor,
                                  fontSize: 14.0,fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. ${snapshot.data!.data!.orderDetails![0]!.onlineAmount}",
                                style: TextStyle(
                                    color: themePinkColor,
                                    fontSize: 14.0,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      */
                    ],
                  )),
            ),

          ],
        ),
      ),
    );





  }
}
