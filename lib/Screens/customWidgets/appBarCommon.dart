import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../../constant.dart';

class AppBarCommon extends StatelessWidget {
  final String title;
  final bool backArrow;

  const AppBarCommon({Key? key, required this.title, this.backArrow = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.fromLTRB(backArrow? 0.0 : 5.0.w, 3.5.w, 5.0.w, 3.0.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: backArrow,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0.w),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      //size: 18.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 27,
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  )),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon:  Icon(
                  Icons.shopping_cart,
                  color: darkThemeBlue,
                  size: 18.sp,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: darkThemeBlue,
                  size: 18.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
