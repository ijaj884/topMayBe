import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constant.dart';

class BecomeASeller extends StatefulWidget {
  const BecomeASeller({Key? key}) : super(key: key);

  @override
  _BecomeASellerState createState() => _BecomeASellerState();
}

class _BecomeASellerState extends State<BecomeASeller> {

  final String assetName = 'images/ProductIcon.svg';
  final String assetName2 = 'images/GSTINIcon.svg';
  final String assetName3 = 'images/CheckSheetIcon.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: darkThemeOrange,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text("Become A Seller",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500)),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 2.5.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(

                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        // WidgetSpan(
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(right: 8),
                        //     child: Icon(
                        //       Icons.local_offer,
                        //       size: 13.sp,
                        //       color: Colors.green,
                        //     ),
                        //   ),
                        // ),
                        TextSpan(
                            text: "0",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 35.sp,
                                color: darkThemeOrange)),
                        TextSpan(
                            text:
                            "%",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: darkThemeOrange)),
                      ],
                    ),
                  ),
                  Text("Sell at 0%",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600),),
                  Text("Commission",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600),),

                ],
              ),
              Column(

                children: [
                  Icon(
                    Icons.people_rounded,
                    size: 33.sp,
                    color: darkThemeOrange,
                  ),
                  Text("40 Crores+",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600),),
                  Text("Customers",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600),),

                ],
              ),
            ],
          ),
          SizedBox(height: 5.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding:  EdgeInsets.only(right: 18.0.w),
                child: Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 33.sp,
                      color: darkThemeOrange,
                    ),
                    Text("27000+",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600),),
                    Text("pincodes",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600),),

                  ],
                ),
              ),
              Container(),
            ],
          ),
          SizedBox(height: 5.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 1.0.w),
                width: 40.w,
                child: RawMaterialButton(
                  onPressed: () async {

                  },

                  elevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Ink(
                    //padding: padding,
                    height: 5.5.h,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [darkThemeBlue, darkThemeBlue])),
                    child: Center(
                      child: Text(
                        "Login",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 40.w,
                padding: EdgeInsets.symmetric(horizontal: 1.0.w),
                child: RawMaterialButton(
                  onPressed: () async {

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
                  child: Ink(
                    //padding: padding,
                    height: 5.5.h,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [darkThemeBlue, darkThemeBlue])),
                    child: Center(
                      child: Text(
                        "Start Selling",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Image.asset(
                "images/seller-banner.png",
                fit: BoxFit.fill,
                // width: 8.5.w,
                // height: 4.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0.w),
            child: Text("Why sell on MyStore?",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),
          ),
          Container(
            padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 2.h,bottom: 2.h),
            margin: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 2.h,bottom: 1.h),
            decoration: BoxDecoration(
                color: Colors.cyan[50],
               // border: Border.all(color: Colors.grey[700]!),
                borderRadius: BorderRadius.circular(
                    12) // use instead of BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  assetName,
                ),
                Text("Receive timely payments",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600),),
                SizedBox(height: 1.0.h,),
                Text("Topmaybe ensures your payments are deposited directly in your bank account within 7-14 days.",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w400),),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 2.h,bottom: 2.h),
            margin: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 2.h,bottom: 1.h),
            decoration: BoxDecoration(
                color: Colors.cyan[50],
                // border: Border.all(color: Colors.grey[700]!),
                borderRadius: BorderRadius.circular(
                    12) // use instead of BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  assetName,
                ),
                Text("Receive timely payments",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600),),
                SizedBox(height: 1.0.h,),
                Text("Topmaybe ensures your payments are deposited directly in your bank account within 7-14 days.",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w400),),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 2.h,bottom: 2.h),
            margin: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 2.h,bottom: 1.h),
            decoration: BoxDecoration(
                color: Colors.cyan[50],
                // border: Border.all(color: Colors.grey[700]!),
                borderRadius: BorderRadius.circular(
                    12) // use instead of BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  assetName,
                ),
                Text("Receive timely payments",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w600),),
                SizedBox(height: 1.0.h,),
                Text("Topmaybe ensures your payments are deposited directly in your bank account within 7-14 days.",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w400),),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0.w,top: 2.h),
            child: Text("How to Register?",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0.w,top: 2.h),
            child: Text("You need just 3 things to become a MyStore Seller",style: TextStyle(fontSize: 13.5.sp,fontWeight: FontWeight.w500),),
          ),
          Container(
            padding: EdgeInsets.only(left: 5.0.w,top: 2.h,bottom: 2.h),
            margin: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 2.h,bottom: 1.h),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                // border: Border.all(color: Colors.grey[700]!),
                borderRadius: BorderRadius.circular(
                    12) // use instead of BorderRadius.all(Radius.circular(20))
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  assetName,
                ),
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.only(left: 8.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("At least 1 product to sell",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                        Text("All you need is a minimum of 1 unique product to start selling on MyStore.",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5.0.w,top: 2.h,bottom: 2.h),
            margin: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 2.h,bottom: 1.h),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                // border: Border.all(color: Colors.grey[700]!),
                borderRadius: BorderRadius.circular(
                    12) // use instead of BorderRadius.all(Radius.circular(20))
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  assetName3,
                ),
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.only(left: 8.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Cancelled cheque",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                        Text("A copy of the cancelled cheque of your bank account is mandatory of registering.",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5.0.w,top: 2.h,bottom: 2.h),
            margin: EdgeInsets.only(left: 5.0.w,right: 5.0.w,top: 2.h,bottom: 1.h),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                // border: Border.all(color: Colors.grey[700]!),
                borderRadius: BorderRadius.circular(
                    12) // use instead of BorderRadius.all(Radius.circular(20))
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  assetName2,
                ),
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.only(left: 8.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("GSTIN details",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500),),
                        Text("You are required to furnish the details of your GSTIN to sell your products online.",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
           // width: 40.w,
            child: RawMaterialButton(
              onPressed: () async {

              },

              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Ink(
                //padding: padding,
                height: 5.5.h,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [darkThemeBlue, darkThemeBlue])),
                child: Center(
                  child: Text(
                    "Register Now",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 5.h,),
        ],
      ),
    );
  }
}
