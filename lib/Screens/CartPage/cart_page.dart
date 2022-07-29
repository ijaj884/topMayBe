import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:topmaybe/constant.dart';

import '../../api_base/api_response.dart';
import '../MyAddress/address_list_page.dart';
import 'GetCart/get_cart_model.dart';
import 'GetCart/get_cart_repository.dart';
import 'SetCart/SetCartBloc.dart';
import 'SetCart/setcart_model.dart';


class CartPage extends StatefulWidget {

  const CartPage({Key? key,}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  final List<int> _productAmount = [];
  // List<int> _productAmount = List.filled(1, 0, growable: true);
  bool cartChangeCheck = false;

  // ignore: non_constant_identifier_names
  String cart_id = "";
  // ignore: non_constant_identifier_names
  String userId = "";
  // ignore: non_constant_identifier_names
  String coupon_code = "";
  String vendorLat="";
  String vendorLong="";
  late SharedPreferences prefs;
  Future<GetCartModel>? _getCart;
  late GetCartRepository _getCartRepository;
  final TextEditingController _couponCode = TextEditingController();
  bool setCart=false;
  final SetCartBloc _setCartBloc=SetCartBloc();
  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    // print("cartId at Cart page1" + prefs.getString("cart_id"));
    // cart_id = prefs.getString("cart_id")!;
    userId = prefs.getString("user_id")!;
    // _userToken = prefs.getString("user_token")!;
    // coupon_code = prefs.getString("coupon_code")!;
    _getCartRepository =GetCartRepository();
    Map body={};
    _getCart=_getCartRepository.getCart(body, userId);

    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    createSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: FutureBuilder<GetCartModel>(
          future: _getCart,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data!.Data!.itemListModels!.isNotEmpty){
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
                      " My Cart (${snapshot.data!.Data!.itemListModels!.length.toString()} Items)",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    // actions: [
                    //   IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.shopping_cart,
                    //       color: darkThemeBlue,
                    //       size: 18.sp,
                    //     ),
                    //   ),
                    //   IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.notifications,
                    //       color: darkThemeBlue,
                    //       size: 18.sp,
                    //     ),
                    //   ),
                    // ],
                  ),
                  body: ListView(
                    padding: EdgeInsets.fromLTRB(5.0.w, 0.0, 5.0.w, 3.0.w),
                    shrinkWrap: true,
                    children: [
                      StreamBuilder<ApiResponse<SetCartModel>>(
                        stream: _setCartBloc.setCartStream,
                        builder: (context, snapshot2) {
                          if (snapshot2.hasData) {
                            switch (snapshot2.data!.status) {
                              case Status.LOADING:
                                // return const CircularProgressIndicator(
                                //     backgroundColor: Colors.white,
                                //     strokeWidth: 3,
                                //     valueColor: AlwaysStoppedAnimation<Color>(
                                //         darkThemeOrange));

                                break;
                              case Status.COMPLETED:
                                {
                                  if (setCart) {

                                    if(snapshot2.data!.data.Code != 0){
                                      // managedSharedPref(snapshot2.data!.data);
                                      // Future.delayed(Duration.zero, () {
                                      //   Get.offAll(() => const CartPage());
                                      //
                                      // });

                                    }else{
                                      Fluttertoast.showToast(
                                          msg: "Something is wrong",
                                          fontSize: 14,
                                          backgroundColor: Colors.white,
                                          gravity: ToastGravity.CENTER,
                                          textColor: darkThemeBlue,
                                          toastLength: Toast.LENGTH_LONG);
                                    }
                                  }
                                  setCart = false;

                                }
                                break;
                              case Status.ERROR:
                                if (kDebugMode) {
                                  print(snapshot.error);
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
                          } else if (snapshot.hasError) {
                            print("error");
                          }
                          return Container();
                        },
                      ),
                      SizedBox(height: 4.h,),
                      ListView.builder(
                        itemCount: snapshot.data!.Data!.itemListModels!.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          _productAmount.add(int.parse(snapshot.data!.Data!.itemListModels![index]!.cartQty!.toString()));
                          // _productAmount.add(1);
                          return Padding(
                            padding: EdgeInsets.only(bottom: 4.0.w),
                            child: Material(
                              elevation: 2,
                              child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      // Image.asset(
                                      //   "images/headphone.jpg",
                                      //   width: 25.0.w,
                                      //   height: 24.0.w,
                                      //   fit: BoxFit.fill,
                                      // ),
                                      FadeInImage(
                                        image: NetworkImage(
                                            snapshot.data!.Data!.itemListModels![index]!.iskuImage_1!),
                                        // width: screenWidth*0.29,//120.0,
                                        // height: screenHeight*0.123,
                                        placeholder: const AssetImage("images/headphone.jpg"),
                                        width: 25.0.w,
                                        height: 24.0.w,
                                        fit: BoxFit.fill,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                        width: 100.0.w - 36.0.w - 34,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  fit: FlexFit.loose,
                                                  child: Text(
                                                    snapshot.data!.Data!.itemListModels![index]!.itmName!,
                                                    style: const TextStyle(color: darkThemeBlue,fontWeight: FontWeight.w500),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Image.asset(
                                                  "images/trash.png",
                                                  width: 15,
                                                  height: 15,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${snapshot.data!.Data!.itemListModels![index]!.primaryVarName}: ${snapshot.data!.Data!.itemListModels![index]!.primaryVaroName}",
                                                  style: TextStyle(color: Colors.black,fontSize: 9.sp,fontWeight: FontWeight.w300),
                                                ),
                                                Spacer(),
                                                Icon(Icons.share,
                                                  color: Colors.grey[700],
                                                  size: 15.sp,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "${snapshot.data!.Data!.itemListModels![index]!.secondaryVarName}: ${snapshot.data!.Data!.itemListModels![index]!.secondaryVaroName}",
                                              style: TextStyle(color: Colors.black,fontSize: 9.sp,fontWeight: FontWeight.w300),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "\u20B9 ${snapshot.data!.Data!.itemListModels![index]!.iskuMrp}",
                                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14.sp),
                                                    ),
                                                    const SizedBox(width: 5,),
                                                    snapshot.data!.Data!.itemListModels![index]!.iskuOfferPrice != null ? Text(
                                                      " \u20B9 ${snapshot.data!.Data!.itemListModels![index]!.iskuOfferPrice}",
                                                      style: TextStyle(
                                                        fontSize: 9.sp,
                                                        color: Colors.black,
                                                        //fontWeight: FontWeight.w400,
                                                        decoration: TextDecoration.lineThrough,
                                                      ),
                                                    ) : Container(),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: (){
                                                        int _quantity = _productAmount[index] - 1;

                                                        // Map body = {
                                                        //   "cart_item_id": "${snapshot.data!.data!.cartItems![index]!.cartItemId}",
                                                        //   "quantity": "$_quantity",
                                                        //   "distance": "$_distance"
                                                        // };
                                                        // _cartItemsUpdateBloc.cartItemsUpdate(body);
                                                        setCart=true;
                                                        Map body ={
                                                          "cart_cus_id": userId,
                                                          "cart_seller_id": "${snapshot.data!.Data!.itemListModels![index]!.itmId}",
                                                          "cart_itm_id": "${snapshot.data!.Data!.itemListModels![index]!.itmId}",
                                                          "cart_isku_id": "${snapshot.data!.Data!.itemListModels![index]!.iskuId}",
                                                          "cart_qty": "$_quantity"
                                                        };
                                                        _setCartBloc.setCart(body);
                                                        setState(() {
                                                          _productAmount[index]--;
                                                          cartChangeCheck = true;
                                                        });
                                                        Future.delayed(Duration.zero, () {
                                                          setState(() {
                                                            //_cartApi = _cartRepository.cartItemsDetails(_body);

                                                          });
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        "images/plus_circle_inactive.png",
                                                        width: 6.0.w,
                                                        height: 6.0.w,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 8,right: 8),
                                                      child: Text(
                                                        "${_productAmount[index]}",
                                                        style: TextStyle(color: Colors.black),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        int _quantity = _productAmount[index] + 1;

                                                        // Map body = {
                                                        //   "cart_item_id": "${snapshot.data!.data!.cartItems![index]!.cartItemId}",
                                                        //   "quantity": "$_quantity",
                                                        //   "distance": "$_distance"
                                                        // };
                                                        //_cartItemsUpdateBloc.cartItemsUpdate(body);
                                                        setCart=true;
                                                        Map body ={
                                                          "cart_cus_id": userId,
                                                          "cart_seller_id": "${snapshot.data!.Data!.itemListModels![index]!.itmId}",
                                                          "cart_itm_id": "${snapshot.data!.Data!.itemListModels![index]!.itmId}",
                                                          "cart_isku_id": "${snapshot.data!.Data!.itemListModels![index]!.iskuId}",
                                                          "cart_qty": "$_quantity"
                                                        };
                                                        _setCartBloc.setCart(body);
                                                        setState(() {
                                                          _productAmount[index]++;
                                                          cartChangeCheck = true;
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        "images/plus_circle_active.png",
                                                        width: 6.0.w,
                                                        height: 6.0.w,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                Text(
                                                  "45 % Off",
                                                  style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 11.sp),
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15,),
                      InkWell(
                        onTap: (){
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => PromoCodePage(),
                          //     ));
                          //OrderDetails
                        },
                        child: Row(

                          children:  const [
                            Text("APPLY COUPON",style: TextStyle(fontSize: 14,color: Colors.black ,fontWeight: FontWeight.bold),),
                            Spacer(),
                            Text("View offers",style: TextStyle(color: darkThemeBlue,fontSize: 14,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Text("Price Summary",
                        style: TextStyle(
                          color: darkThemeOrange,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.5.sp,
                        ),
                      ),
                      const SizedBox(height: 8,),

                      Row(
                        children: [
                          Text("Price (${snapshot.data!.Data!.itemListModels!.length.toString()} Items)",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5.sp,
                            ),
                          ),
                          const Spacer(),
                          Text("\u20B9 4000",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5.sp,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("Discount",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5.sp,
                            ),
                          ),
                          const Spacer(),
                          Text("- \u20B9 2002",
                            style: TextStyle(
                              color: Colors.green[800],
                              fontWeight: FontWeight.w500,
                              fontSize: 11.5.sp,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      // (snapshot.data!.data!.totalAfterDiscount != null)
                      //     ? Row(
                      //   children: [
                      //     Text(
                      //       "Discount Amount",
                      //       style: GoogleFonts.poppins(fontSize: 11.5.sp, color: Colors.black,fontWeight: FontWeight.w400),
                      //     ),
                      //     Spacer(),
                      //     Text(
                      //       "[ - ] \u20B9 ${double.parse(snapshot.data!.data!.cartTotalAmount!) - double.parse(snapshot.data!.data!.totalAfterDiscount!)}",
                      //       style:
                      //       TextStyle(fontWeight: FontWeight.w400,
                      //           fontSize: 11.5.sp, color: Colors.green),
                      //     )
                      //   ],
                      // )
                      //     : Container(),
                      // (snapshot.data!.data!.totalAfterDiscount != null)
                      //     ? Row(
                      //   children: [
                      //     Text(
                      //       "Amount After Discount",
                      //       style: GoogleFonts.poppins(color: Colors.black,
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: 11.5.sp,),
                      //     ),
                      //     Spacer(),
                      //     Text(
                      //       "\u20B9 ${snapshot.data!.data!.totalAfterDiscount}",
                      //       style:
                      //       TextStyle(color: Colors.black,
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: 11.5.sp,),
                      //     )
                      //   ],
                      // )
                      //     : Container(),
                      Row(
                        children: [
                          Text("Tax",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5.sp,
                            ),
                          ),
                          Spacer(),
                          Text("\u20B9 40",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5.sp,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("Shipping",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5.sp,
                            ),
                          ),
                          Spacer(),
                          Text("\u20B9 40",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5.sp,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Divider(thickness: 1,),
                      //const SizedBox(height: 1,),
                      Row(
                        children: [
                          Text("Total Amount",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.3.sp,
                            ),
                          ),
                          const Spacer(),
                          Text("\u20B9 2078",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                    ],
                  ),
                  bottomSheet:  InkWell(
                    onTap: (){
                      Get.to(() => AddressListPage());
                    },
                    child: Container(
                        height: 60,

                        decoration:  const BoxDecoration(
                          //color:darkThemeRed,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2.5,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                          gradient: LinearGradient(
                            colors: [
                              Colors.white, Colors.white,//darkThemeOrange,
                            ],
                          ),
                          borderRadius:  BorderRadius.all(
                              Radius.circular(0)),

                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:  [
                              Text("\u20B92078",
                                style: TextStyle(color: Colors.black,fontSize: 16.sp,fontWeight: FontWeight.w500),

                              ),
                              SizedBox(width: 35.w,),
                              Container(
                                color: darkThemeBlue,
                                height: 6.h,
                                width: 35.w,
                                child: Center(
                                  child: Text("Continue",
                                    style: TextStyle(color: Colors.white,fontSize: 13.sp,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )

                    ),
                  ),
                );
              }else{
                return Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(15, 15, 10, 30),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "".toUpperCase(),
                          // textAlign: TextAlign.start,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14.0),
                        )),
                    Image.asset(
                      "images/cart_active.png",
                      height: 150.0,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Center(
                      child: Text(
                        "Your Cart is Empty",
                        style: TextStyle(color: darkThemeOrange, fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    )
                  ],
                );
              }
            } else if (snapshot.hasError) {
              if (kDebugMode) {
                print("hello");
              }
              return const Center(
                  child: Text(
                    "No Data ",
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ));
            } else {
              return const Center(child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(
                darkThemeOrange,
              ),));
            }
          },
        ),

      );
  }
}
