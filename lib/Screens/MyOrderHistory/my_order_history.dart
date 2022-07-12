
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:topmaybe/constant.dart';
import 'package:get/get.dart';

import 'my_order_history_model.dart';
import 'my_order_history_repository.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {


  Future<MyOrderHistoryModel>? allOrderList;
  late MyOrderHistoryRepository _myOrderHistoryRepository;
  late SharedPreferences prefs;
  String userToken="";
  String userId="";
  bool deleteCheck=false;
  late Map idd;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString("user_token")!;
    userId=prefs.getString("user_id")!;
    _myOrderHistoryRepository = MyOrderHistoryRepository();
    allOrderList = _myOrderHistoryRepository.getOrderHistory(userId);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();

  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
          "My Orders",
          style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        actions: [
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
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          children: [
            FutureBuilder<MyOrderHistoryModel>(
                future: allOrderList,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    if(snapshot.data!.Data!.isNotEmpty){
                      return Container(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.Data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {

                                  },
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
                                                height: screenWidth * 0.2,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(5.0)),
                                                ),
                                                child: FadeInImage(
                                                  image: NetworkImage(
                                                    snapshot.data!.Data![index]!.iskuImage_1!,
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
                                                              snapshot.data!.Data![index]!.itmName!.toUpperCase(),
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines:1,
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.black,

                                                                fontSize: screenWidth * 0.04,
                                                              )),
                                                        ),

                                                      ],
                                                    ),
                                                    snapshot.data!.Data![index]!.secondaryVarName !=null ? SizedBox(height: 1.h,):const SizedBox(),
                                                    snapshot.data!.Data![index]!.secondaryVarName !=null ? Text(
                                                      "${snapshot.data!.Data![index]!.secondaryVarName} : ${snapshot.data!.Data![index]!.secondaryVaroName} ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: screenWidth * 0.03),
                                                    ): Container(),
                                                    SizedBox(height: 1.h,),
                                                    snapshot.data!.Data![index]!.primaryVarName !=null ? Text(
                                                      "${snapshot.data!.Data![index]!.primaryVarName} : ${snapshot.data!.Data![index]!.primaryVaroName} ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: screenWidth * 0.03),
                                                    ): Container(),
                                                    Container(
                                                      margin: const EdgeInsets.only(top: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Rs ${snapshot.data!.Data![index]!.ordGrandTotal!.toStringAsFixed(0)}",
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: screenWidth * 0.032),
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
                              ],
                            );
                          },
                        ),
                      );

                    }else{
                      return Column(
                        children: const [

                          Padding(
                            padding: EdgeInsets.only(top:250),
                            child: Center(
                              child: Text(
                                "Your Order List is Empty Please Order now!",
                                style: TextStyle(color: darkThemeBlue , fontWeight: FontWeight.bold, fontSize: 15.0),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      );
                    }


                  }
                  else if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Center(child: Text("Your Order List is Empty Please Order now!", style: TextStyle(
                        color: darkThemeBlue, fontSize: 20,
                      ),)),
                    );
                  }
                  else {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3.0,
                          valueColor: AlwaysStoppedAnimation<Color>(darkThemeOrange),
                        ),
                      ),
                    );
                  }


                }
            ),
          ]
      ),

    );
  }
}
