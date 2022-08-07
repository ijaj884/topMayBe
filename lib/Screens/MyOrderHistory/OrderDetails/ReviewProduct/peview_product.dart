//ReviewProduct
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:topmaybe/Screens/MyOrderHistory/OrderDetails/ReviewProduct/review_product_bloc.dart';
import 'package:topmaybe/Screens/MyOrderHistory/OrderDetails/ReviewProduct/review_product_model.dart';
import 'package:topmaybe/Screens/MyOrderHistory/my_order_history.dart';

import '../../../../api_base/api_response.dart';
import '../../../../constant.dart';

class ReviewProduct extends StatefulWidget {
  final String orderid;
  final String orderDateTime;
  final String iskuImage_1;
  final String itmName;
  final String rating;
  final String itmId;
  final String skuId;

  //const OrderDetails({ required this.orderid, this.data});
  const ReviewProduct(
      {Key? key,
        required this.orderid,
        required this.orderDateTime,
        required this.iskuImage_1,
        required this.itmName, required this.rating, required this.itmId, required this.skuId,
        })
      : super(key: key);

  @override
  _ReviewProductState createState() => _ReviewProductState();
}

class _ReviewProductState extends State<ReviewProduct> {
  @override
  void initState() {
    super.initState();

    createSharedPref();
  }

  late SharedPreferences prefs;
  String userToken = "";
  String userId = "";
  final TextEditingController _writeController = TextEditingController();
  final ReviewProductBloc _reviewProductBloc = ReviewProductBloc();
  bool _setRating=false;
  String reviewRating="0";

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id")!;
    reviewRating=widget.rating;
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
            "ReviewProduct",
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
              //height: scH * 0.3,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        margin:
                        const EdgeInsets.only(top: 4.0, bottom: 14.0),
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)),
                                  ),
                                  child: FadeInImage(
                                    image: NetworkImage(
                                      widget.iskuImage_1,
                                    ),
                                    placeholder: const AssetImage(
                                        "images/headphone.jpg"),
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            //flex:6,
                                            child: Text(widget.itmName,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: scW * 0.04,
                                                )),
                                          ),
                                        ],
                                      ),

                                      Container(
                                        margin:
                                        const EdgeInsets.only(top: 8.0),
                                        child: RatingBar.builder(
                                          initialRating: double.parse(widget.rating),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: darkThemeOrange,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                            reviewRating=rating.toStringAsFixed(0);
                                          },
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
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.0.h, left: scW * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Write a Review",
                    style: TextStyle(fontSize: 14.sp,color: Colors.black,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1.h,),
                  Padding(
                    padding: EdgeInsets.only(left: 1.w,right: 8.w,top: 1.h,bottom: 3.h),
                    child: TextField(
                      controller: _writeController,
                      maxLines: 5,
                      //expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                          labelText: 'Share details of your experience',
                          border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  Text("You can upload photos related to product",
                    style: TextStyle(fontSize: 11.sp,color: Colors.grey,),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    width: 34.w,
                    height: 5.5.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0,
                        color: Colors.grey
                      ),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(5.0) //                 <--- border radius here
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8,),
                        const Icon(
                          Icons.camera_alt_rounded,
                          color: lightThemeBlue,
                        ),
                        const SizedBox(width: 5,),
                        Text("Add Photo",
                          style: TextStyle(fontSize: 12.sp,color: lightThemeBlue,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: RawMaterialButton(
                onPressed: () async {
                  _setRating=true;
                  Map body={
                    "creview_cus_id": userId,
                    "creview_itm_id": widget.itmId,
                    "creview_isku_id": widget.skuId,
                    "creview_rating": reviewRating,
                    "creview_remark": _writeController.text,
                    "creview_image1": "",
                    "creview_image2": "",
                    "creview_image3": ""
                  };
                  _reviewProductBloc.setReview(body);

                },
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    0,
                  ),
                ),
                child: StreamBuilder<ApiResponse<ReviewProductModel>>(
                  stream: _reviewProductBloc.setReviewStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status) {
                        case Status.LOADING:
                          return const CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  darkThemeOrange));

                          break;
                        case Status.COMPLETED:
                          {
                            //String Otp =snapshot.data!.data!.Data!;
                            // if (kDebugMode) {
                            //   print(Otp);
                            // }
                            // _getOtp=false;
                            if (_setRating) {
                              Future.delayed(Duration.zero, () {
                                Get.to(() => const MyOrder());
                              });
                              Fluttertoast.showToast(
                                  msg: "Thank You For Rating Us",
                                  fontSize: 14,
                                  backgroundColor: Colors.white,
                                  textColor: darkThemeBlue,
                                  toastLength: Toast.LENGTH_LONG);
                            }
                            _setRating = false;

                          }
                          break;
                        case Status.ERROR:
                          if (kDebugMode) {
                            print("Erooooooooooooooooooooorrrrrrrrrrrrr");
                            print(snapshot.error);
                            //   Error(
                            //   errorMessage: snapshot.data.message,
                            // );

                          }
                          break;
                      }
                    } else if (snapshot.hasError) {
                      print("error");
                    }
                    return Ink(
                      //padding: padding,
                      height: 5.5.h,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [darkThemeBlue, darkThemeBlue])),
                      child: Center(
                        child: Text(
                          "Finish",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
