
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:topmaybe/Screens/ProductList/product_list_allrepository.dart';

import '../../constant.dart';
import '../CartPage/cart_page.dart';
import '../HomeScreen/GetAllActiveDeals/new_arrival_model.dart';
import '../ProductDetails/product_details.dart';
import '../WishList/WishListAdded/FavoriteAddBloc.dart';
// ignore: must_be_immutable
class ProductList extends StatefulWidget{
  final String varName;
  final String categoryId;
  const ProductList({Key? key, required this.varName, required this.categoryId}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  //String categoryid;

  //_ProductByCategoryState(this.categoryid);
  //
  // Future<ProductModel>? _getChildCategory;
  // late GetAllActiveChildBySubRepository _getAllActiveChildBySubRepository;

  // Future<GetFilteredItemListModel>? _getFilterItem;
  // late GetFilteredItemListRepository _getFilteredItemListRepository;
  Future<NewArrivalModel>? _getNewArrival;
  late ProductListRepository _getAllActiveDealsRepository;
  String userId="0";
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late SharedPreferences prefs;
  final List<bool> _isFavoriteBest = [];
  final FavoriteAddBloc _favoriteAddBloc = FavoriteAddBloc();

  Future<void> createSharedPref() async {


    prefs = await SharedPreferences.getInstance();
    if (userLogin) {
      userId = prefs.getString("user_id")!;
      _getAllActiveDealsRepository = ProductListRepository();
      if(widget.varName=="Best Seller"){
        _getNewArrival = _getAllActiveDealsRepository.getBestSeller(userId);
      }
      else if(widget.varName=="Top Offers"){
        _getNewArrival = _getAllActiveDealsRepository.getTopOfer(userId);
      }
      else if(widget.varName=="Deals of the day"){
        _getNewArrival = _getAllActiveDealsRepository.getDealsOfTheDay(userId);
      }
      //New Arrival
      else if(widget.varName=="New Arrival"){
        _getNewArrival = _getAllActiveDealsRepository.getNewArrival(userId);
      }
      else if(widget.varName=="Recently Viewed"){
        _getNewArrival = _getAllActiveDealsRepository.getRecentlyViewed(userId);
      }

    }
    setState(() {});
  }
  String wistList="";
  //final bool _isFavorite = true;

  @override
  void initState() {
    super.initState();
    createSharedPref();

  }
  RangeValues values = const RangeValues(0, 100000);
  RangeLabels labels =const RangeLabels('0', "100000");
  String minPrice="0";
  String maxPrice="";
  String sortBy="";
  //String _paymentMode="";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      // drawer: Drawer(
      //   child: ListView(
      //     //crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         height: 7.0.h,
      //         color: darkThemeOrange,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Padding(
      //               padding: EdgeInsets.only(left: 4.5.w, top: 1.0),
      //               child: Text(
      //                 "Filter",
      //                 style: TextStyle(color: Colors.white, fontSize: 14.sp),
      //               ),
      //             ),
      //             InkWell(
      //               onTap: () {
      //                 Get.back();
      //               },
      //               child: Padding(
      //                 padding: EdgeInsets.only(right: 4.0.w),
      //                 child: Icon(
      //                   Icons.cancel_sharp,
      //                   color: Colors.white,
      //                   size: 20.sp,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(
      //         height: 2.h,
      //       ),
      //       Padding(
      //         padding: EdgeInsets.only(left: 4.5.w, top: 1.0),
      //         child: Text(
      //           "Price",
      //           style: TextStyle(color: Colors.black, fontSize: 14.sp),
      //         ),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.only(left: 4.5.w, top: 1.0),
      //         child: Row(
      //           children: [
      //             Row(
      //               children: [
      //                 Text(
      //                   "from :",
      //                   style: TextStyle(color: Colors.black, fontSize: 12.sp),
      //                 ),
      //                 Container(
      //                   margin: const EdgeInsets.all(10.0),
      //                   padding: const EdgeInsets.only(left: 8.0,right: 8,top: 3.0,bottom: 3.0),
      //                   decoration:BoxDecoration(
      //                     border: Border.all(color: Colors.grey),
      //                   ),
      //                   child: Center(
      //                     child: Text(
      //                       minPrice,
      //                       style: TextStyle(color: Colors.black, fontSize: 12.sp),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(width: 5.w,),
      //             Row(
      //               children: [
      //                 Text(
      //                   "to :",
      //                   style: TextStyle(color: Colors.black, fontSize: 12.sp),
      //                 ),
      //                 Container(
      //                   margin: const EdgeInsets.all(10.0),
      //                   padding: const EdgeInsets.only(left: 8.0,right: 8,top: 3.0,bottom: 3.0),
      //                   decoration:BoxDecoration(
      //                     border: Border.all(color: Colors.grey),
      //                   ),
      //                   child: Center(
      //                     child: Text(
      //                       maxPrice,
      //                       style: TextStyle(color: Colors.black, fontSize: 12.sp),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: RangeSlider(
      //             divisions: 200,
      //             activeColor: lightThemeBlue,
      //             inactiveColor: Colors.blue[300],
      //             min: 0,
      //             max: 100000,
      //             values: values,
      //             labels: labels,
      //             onChanged: (value){
      //               print("START: ${value.start}, End: ${value.end}");
      //               setState(() {
      //                 values =value;
      //                 minPrice=value.start.toStringAsFixed(0);
      //                 maxPrice=value.end.toStringAsFixed(0);
      //                 labels =RangeLabels(value.start.toInt().toString(), value.end.toInt().toString());
      //               });
      //             }
      //         ),
      //       ),
      //
      //
      //       const Divider(thickness: 0.7),
      //       SizedBox(height: 30.h,),
      //       Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 6.0.w),
      //         child: RawMaterialButton(
      //           onPressed: () async {
      //             if(maxPrice !="0"){
      //               Map body = {
      //                 "cus_id": userId,
      //                 "cat_id": widget.categoryId,
      //                 "tags": "",
      //                 "brand_id": 0,
      //                 "min_price": minPrice,
      //                 "max_price": maxPrice
      //               };
      //               setState(() {
      //                 _getFilterItem = _getFilteredItemListRepository.getFilteredItem(body);
      //               });
      //             }else{
      //               Map body = {
      //                 "cus_id": userId,
      //                 "cat_id": widget.categoryId,
      //                 "tags": "",
      //                 "brand_id": 0,
      //                 "min_price": minPrice,
      //                 "max_price": 1
      //               };
      //               setState(() {
      //                 _getFilterItem = _getFilteredItemListRepository.getFilteredItem(body);
      //               });
      //             }
      //
      //             //Future.delayed(Duration.zero, () {});
      //             Get.back();
      //
      //           },
      //           elevation: 0,
      //           hoverElevation: 0,
      //           focusElevation: 0,
      //           highlightElevation: 0,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(
      //               0,
      //             ),
      //           ),
      //           child: Ink(
      //             //padding: padding,
      //             height: 5.5.h,
      //             decoration: const BoxDecoration(
      //                 gradient: LinearGradient(
      //                     begin: Alignment.centerLeft,
      //                     end: Alignment.centerRight,
      //                     colors: [darkThemeBlue, darkThemeBlue])),
      //             child: Center(
      //               child: Text(
      //                 "Apply",
      //                 overflow: TextOverflow.ellipsis,
      //                 maxLines: 1,
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 13.sp,
      //                 ),
      //                 textAlign: TextAlign.center,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: darkThemeOrange,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text(widget.varName,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500)),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back,color: Colors.white,size: 16.sp,)),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 2.h,),
          InkWell(
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  //isScrollControlled: true,
                  backgroundColor: Colors.white,
                  //backgroundColor: Colors.cyan,
                  builder: (BuildContext context){

                    return  StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return ListView(
                            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 3.w,),
                                  Text("Sort By",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Icon(
                                      Icons.cancel_rounded,
                                      color: darkThemeOrange,
                                      size: 23.sp,
                                    ),
                                  ),
                                  SizedBox(width: 2.w,),
                                ],
                              ),
                              SizedBox(height: 2.h,),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                                ),
                                //padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 15.0),
                                // margin: EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                                height: 25.h,
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
                                        child: SizedBox(
                                          // height: 20.0,
                                          width: 100.w,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              const Expanded(
                                                flex: 8,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8.0, 0.0, 8.0, 0.0),
                                                  child: Text(
                                                    "Popularity",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight
                                                            .w600),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Radio(
                                                  activeColor: darkThemeBlue,
                                                  value: "Popularity",
                                                  groupValue: sortBy,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      sortBy = value.toString();
                                                      if (kDebugMode) {
                                                        print(sortBy);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          // height: 20.0,
                                          width: 100.w,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              const Expanded(
                                                flex: 8,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8.0, 0.0, 8.0, 0.0),
                                                  child: Text(
                                                    "Price",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight
                                                            .w600),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Radio(
                                                  activeColor: darkThemeBlue,
                                                  value: "Price",
                                                  groupValue: sortBy,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      sortBy = value.toString();
                                                      if (kDebugMode) {
                                                        print(sortBy);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          // height: 20.0,
                                          width: 100.w,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              const Expanded(
                                                flex: 8,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8.0, 0.0, 8.0, 0.0),
                                                  child: Text(
                                                    "Rating",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight
                                                            .w600),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Radio(
                                                  activeColor: darkThemeBlue,
                                                  value: "Rating",
                                                  groupValue: sortBy,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      sortBy = value.toString();
                                                      if (kDebugMode) {
                                                        print(sortBy);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          // height: 20.0,
                                          width: 100.w,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              const Expanded(
                                                flex: 8,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8.0, 0.0, 8.0, 0.0),
                                                  child: Text(
                                                    "Newest First",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight
                                                            .w600),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Radio(
                                                  activeColor: darkThemeBlue,
                                                  value: "online",
                                                  groupValue: sortBy,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      sortBy = value.toString();
                                                      if (kDebugMode) {
                                                        print(sortBy);
                                                      }
                                                    });
                                                  },
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
                            ],
                          );
                        });
                  }
              );
            },
            child: Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 3.w,
                    ),
                    Icon(
                      Icons.sort_sharp,
                      color: Colors.black,
                      size: 18.sp,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Sort",
                      style:
                      TextStyle(color: Colors.black, fontSize: 13.sp),
                    ),
                    //Center(child: Text("00:$_start",style: TextStyle(color: Colors.black, fontSize: 16),)),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () => _key.currentState?.openDrawer(),
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_alt_sharp,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Filter",
                        style:
                        TextStyle(color: Colors.black, fontSize: 13.sp),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h,),
          FutureBuilder<NewArrivalModel>(
            future: _getNewArrival,
            builder: (context,snapshot){
              if(snapshot.hasData){
               if(widget.varName !="Recently Viewed"){
                 for (int i = 0; i < snapshot.data!.Data!.length; i++) {
                   _isFavoriteBest.add(snapshot.data!.Data![i]!.isAddedToWishList!);
                 }
              }

                if(snapshot.data!.Data!.isNotEmpty){
                  return GridView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.35),
                    ),
                    itemCount: snapshot.data!.Data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => ProductDetails(
                            itemId: snapshot.data!.Data![index]!.iskuItmId.toString(),
                            iskuOfferPrice: snapshot.data!.Data![index]!.iskuOfferPrice.toString(),
                            iskuMrp: snapshot.data!.Data![index]!.iskuMrp.toString(),
                            iskuId: snapshot.data!.Data![index]!.iskuId.toString(),
                          ));
                        },
                        child: Card(
                          elevation: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.475,
                            //color: Colors.red,
                            padding: const EdgeInsets.all(5),
                            //height: 50.h,
                            //margin: EdgeInsets.only(left: 8),
                            child: Stack(children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                    Center(
                                      child: FadeInImage(
                                        image: NetworkImage(
                                            snapshot.data!.Data![index]!.iskuImage_1!),
                                        width: 35.w,
                                        height: 18.h,
                                        placeholder: const AssetImage("images/headphone.jpg"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    // Image.asset(
                                    //   headphoneImages[index],
                                    //   fit: BoxFit.fill,
                                    //   width: 35.w,
                                    //   height: 18.h,
                                    // ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Icon(
                                  //       Icons.timer,
                                  //       color: Colors.red,
                                  //       size: 18.sp,
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 8,
                                  //     ),
                                  //     Center(
                                  //         child: Text(
                                  //           "${difference.inHours} : ${difference.inMinutes.remainder(60)} : ${difference.inSeconds.remainder(60)}",
                                  //           style:
                                  //           TextStyle(color: Colors.black, fontSize: 12.sp),
                                  //         )),
                                  //     //Center(child: Text("00:$_start",style: TextStyle(color: Colors.black, fontSize: 16),)),
                                  //   ],
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data!.Data![index]!.itmName!,
                                      //"boAt Rockerz 510 Super Extra Bass Bluetooth headphone",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 11.sp, color: darkThemeBlue),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        padding: const EdgeInsets.only(left: 5),
                                        height: 3.5.h,
                                        width: 19.w,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(
                                                5) // use instead of BorderRadius.all(Radius.circular(20))
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 11.sp,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 5.0, top: 1),
                                              child: Text(
                                                "4.5 Star",
                                                style: TextStyle(
                                                    fontSize: 8.5.sp,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.share_outlined,
                                        color: darkThemeBlue,
                                        size: 14.sp,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0, top: 3),
                                        child: Text(
                                          "Share",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: darkThemeBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0, top: 8),
                                        child: Text(
                                          " \u20B9 ${snapshot.data!.Data![index]!.iskuOfferPrice}",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0, top: 8),
                                        child: Text(
                                          " \u20B9 ${snapshot.data!.Data![index]!.iskuMrp}",
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                //right: 0,
                                child: ClipOval(
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    width: 5.h,
                                    height: 5.h,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(202, 85, 44, 1) //(202, 85, 44)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "45%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              widget.varName !="Recently Viewed" ?
                              Positioned(
                                top: 0,
                                //left: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    if (_isFavoriteBest[index] != true) {
                                      Map body = {
                                        "wl_cus_id": userId,
                                        "wl_itm_id": snapshot.data!.Data![index]!.iskuItmId,
                                        "wl_isku_id": snapshot.data!.Data![index]!.iskuId
                                      };
                                      _favoriteAddBloc.favoriteAdd(body);
                                      _isFavoriteBest[index] = !_isFavoriteBest[index];
                                      Fluttertoast.showToast(
                                          msg: "Successfully Added to Wishlist",
                                          fontSize: 14,
                                          backgroundColor: Colors.white,
                                          gravity: ToastGravity.BOTTOM,
                                          textColor: darkThemeBlue,
                                          toastLength: Toast.LENGTH_LONG);
                                    }
                                  },
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: Colors.white,
                                    child: SizedBox(
                                      height: 4.h,
                                      width: 4.h,
                                      child: Center(
                                        child: _isFavoriteBest[index]
                                            ? Icon(
                                          Icons.favorite_rounded,
                                          size: 17.sp,
                                          color: Colors.red,
                                        )
                                            : Icon(
                                          Icons.favorite_rounded,
                                          size: 17.sp,
                                          color: const Color.fromRGBO(
                                              176, 176, 176, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ):
                              Container(),
                              Positioned(
                                top: 6.h,
                                //left: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => const CartPage());
                                  },
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius. circular(20),
                                    ),
                                    color: Colors.white,
                                    child: SizedBox(
                                      height: 4.h,
                                      width: 4.h,
                                      child: const Center(
                                        child:  Icon(
                                          Icons.shopping_cart,
                                          color: Color.fromRGBO(176, 176, 176, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      );
                    },
                  );
                }else{
                  return const Center(
                      child: Text(
                        "No Item ",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black),
                      ));
                }

              }
              else if(snapshot.hasError){
                if (kDebugMode) {
                  print("Error:- ${snapshot.error}");
                }
                return const Center(
                    child: Text(
                      "No Data ",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ));
              }
              else {
                return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(
                  darkThemeOrange,
                ),));
              }
            },

          ),
        ],
      ),
    );
  }
}


