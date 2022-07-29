import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_html/htmlfile.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topmaybe/Screens/ProductDetails/product_details_model.dart';
import 'package:topmaybe/Screens/ProductDetails/product_details_repository.dart';
import 'package:topmaybe/Screens/customWidgets/leanerprogressindicator.dart';
import 'package:http/http.dart' as http;

//import 'package:percent_indicator/percent_indicator.dart';
import '../../api_base/api_response.dart';
import '../../constant.dart';
import '../CartPage/SetCart/SetCartBloc.dart';
import '../CartPage/SetCart/setcart_model.dart';
import '../CartPage/cart_page.dart';
import '../CustomerReviews/GetItemReview/get_item_review_model.dart';
import '../CustomerReviews/GetItemReview/get_item_review_repository.dart';
import '../WishList/WishListAdded/FavoriteAddBloc.dart';
import '../WishList/WishListAdded/FavoriteAddModel.dart';
import '../customWidgets/carticon_widget.dart';
//import '../customWidgets/htmlfile.dart';
//import '../customWidgets/htmlfile.dart';

class ProductDetails extends StatefulWidget {
  final String itemId;
  final String iskuOfferPrice;
  final String iskuMrp;
  final String iskuId;

  const ProductDetails(
      {Key? key, required this.itemId, required this.iskuOfferPrice, required this.iskuMrp, required this.iskuId})
      : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool viewMore = false;
  bool highlightsViewMore = false;
  bool showDescription = false;
  bool showSpecifications = false;
  bool _isFavorite =true;
  bool gotCrt=false;
  bool setCart=false;
  bool setCart1=false;
  bool addWishlist=false;
  List<String> bannerImagesAPI = [
    "images/headphone.jpg",
    "images/dualmodeheadph.jpeg",
    "images/dualmodeheadph.jpeg",
    "images/dualmodeheadph.jpeg",
    "images/dualmodeheadph.jpeg",
  ];
  List<String?> ?bannerImages=[];
  List<String?> ?bannerImagesColor=[];

  @override
  void initState() {
    super.initState();
    createSharedPref();
  }

  late SharedPreferences prefs;
  late  int _current = 0;
  final CarouselController _controller = CarouselController();
  Future<ProductDetailsModel>? _getProductDetails;
  late ProductDetailsRepository _productDetailsRepository;
  final SetCartBloc _setCartBloc=SetCartBloc();

  Future<GetItemReviewModel>? _getItemReview;
  late GetItemReviewRepository _getItemReviewRepository;

  String userId="";
  int ? value;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userId=prefs.getString("user_id")!;
    if (kDebugMode) {
      print("User_______________________Id:---------------$userId");
    }
    _productDetailsRepository=ProductDetailsRepository();
    _getProductDetails=_productDetailsRepository.getProductDetails(widget.itemId);

    _getItemReviewRepository= GetItemReviewRepository();
    _getItemReview=_getItemReviewRepository.getReview(widget.itemId);

    if(userLogin){
      Map body = {
        "irecent_cus_id": userId,
        "irecent_itm_id": widget.itemId,
        "irecent_isku_id": widget.iskuId
      };
      //print("boddddddddddddddddddddddddddddddddyyyyyyyyyyy $body");
      final response = await http.post(
          Uri.parse('http://rohan4-001-site1.ftempurl.com/CusApi/ItemSku/SetRecentlyViewed'),
          body: jsonEncode(body),headers: {
        "Accept": "application/json",
        "content-type":"application/json"
      });
      //final response = await _helper.post("/user/usersignin",body);
      //print("statusssssssssssssssssssssssssssssssssssss ${response.statusCode}");
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        // var _results = response.data;
        //return Album.fromJson(jsonDecode(response.body));
        final jsonData = json.decode(response.body);
        if (kDebugMode) {
          print(jsonData);
        }
      }
    }




    setState(() {});
  }
  final FavoriteAddBloc _favoriteAddBloc=FavoriteAddBloc();
  String itemPrice="";
  String itemOfferPrice="";
  bool priceSet=false;

  @override
  var _size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProductDetailsModel>(
        future: _getProductDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // for(int i=0;i<snapshot.data!.Data!.itemSkuDetailsModels!.length;i++){
            //   for(int j=0;j<snapshot.data!.Data!.itemSkuDetailsModels![i]!.iskuImages!.length;j++){
            //     bannerImages.add(snapshot.data!.Data!.itemSkuDetailsModels![i]!.iskuImages![j]!);
            //   }
            //
            // }

           // itemPrice=snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuOfferPrice.toString();

            /*
            if(snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuImage_1 !=null){
              bannerImages.add(snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuImage_1!);
              bannerImages.add(snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuImage_2!);
              bannerImages.add(snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuImage_3!);
              bannerImages.add(snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuImage_4!);
              bannerImages.add(snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuImage_5!);
            }
            */

            bannerImages=snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuImages!;

            // for(int i=0; i<snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuImages!.length;i++){
            //   bannerImages.add(snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuImages![i].)
            // }


            // final tagName = '${snapshot.data!.Data!.itmHighlights!}';
            // final split = tagName.split('.');
            // final Map<int, String> values = {
            //   for (int i = 0; i < split.length; i++)
            //     i: split[i]
            // };
            // print(values);  // {0: grubs, 1:  sheep}
            //
            // final value1 = values[0];
            // final value2 = values[1];
            // final value3 = values[2];
            //
            // print("des-----------------------------");
            // print(value1);  // grubs
            // print(value2);  //  sheep
            // print(value3);


            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  centerTitle: false,
                  titleSpacing: 0,
                  backgroundColor: //darkThemeBlue,
                  //Color.fromRGBO(202, 85, 44, 1),
                  Colors.white,
                  //bottomOpacity: 0.0,
                  elevation: 0.0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 18.sp,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  title: Text(
                    "Product Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  actions: [
                    const CartIconWidget(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: darkThemeBlue,
                        size: 18.sp,
                      ),
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
                body: ListView(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: EdgeInsets.only(left: 1.w, right: 1.w, bottom: 3.w),
                        //color: Colors.blue,
                        child: Column(
                          children: [
                            Stack(
                                children: <Widget>[
                                  //  Image.asset(
                                  //   widget.productPic,
                                  //   fit: BoxFit.fill,
                                  //    width: 65.w,
                                  //   height: 32.h,
                                  // ),

                                  /* CarouselSlider(

                            options: CarouselOptions(
                              //height: MediaQuery.of(context).size.height,
                              height: 35.h,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              autoPlay: false,


                            ),
                            items: bannerImagesAPI
                                .map((item) => Container(
                              child: Center(
                                child:
                                // FadeInImage(
                                //   image: NetworkImage(
                                //       item),
                                //   width: 65.w,
                                //   height: 32.h,
                                //   placeholder: const AssetImage("images/bn1.jpg"),
                                //   fit: BoxFit.fill,
                                // ),
                                Image.asset(
                                  item,
                                  fit: BoxFit.cover,
                                  width: 65.w,
                                 // height: 34.h,
                                )
                              ),
                            ))
                                .toList(),
                          ),*/
                                  priceSet ?
                                  CarouselSlider(
                                    items: bannerImagesColor!.map((item) => Center(
                                      child:
                                      FadeInImage(
                                        image: NetworkImage(
                                            item!),
                                        width: 80.w,
                                        height: 50.h,
                                        placeholder: const AssetImage("images/headphone.jpg"),
                                        fit: BoxFit.fill,
                                      ),
                                      // Image.asset(
                                      //   item,
                                      //   fit: BoxFit.cover,
                                      //   width: 65.w,
                                      //   // height: 34.h,
                                      // )

                                    ))
                                        .toList(),
                                    carouselController: _controller,
                                    options: CarouselOptions(
                                        height: 50.h,
                                        viewportFraction: 1.0,
                                        enlargeCenterPage: false,
                                        autoPlay: false,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        }),
                                  ):
                                  CarouselSlider(
                                    items: bannerImages!.map((item) => Center(
                                        child:
                                        FadeInImage(
                                          image: NetworkImage(
                                              item!),
                                          width: 89.w,
                                          height: 50.h,
                                          placeholder: const AssetImage("images/headphone.jpg"),
                                          fit: BoxFit.fill,
                                        ),
                                        // Image.asset(
                                        //   item,
                                        //   fit: BoxFit.cover,
                                        //   width: 65.w,
                                        //   // height: 34.h,
                                        // )

                                    ))
                                        .toList(),
                                    carouselController: _controller,
                                    options: CarouselOptions(
                                        height: 50.h,
                                        viewportFraction: 1.0,
                                        enlargeCenterPage: false,
                                        autoPlay: false,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        }),
                                  ),
                                  Positioned(
                                    top: 0,
                                    //left: 0,
                                    right: 10,
                                    child: InkWell(
                                      onTap: () {
                                        // _isFavorite[index]=!_isFavorite[index];
                                        addWishlist=true;
                                        Map body={
                                          "wl_cus_id": userId,
                                          "wl_itm_id": snapshot.data!.Data!.itmId,
                                          "wl_isku_id": snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuId
                                        };
                                        _favoriteAddBloc.favoriteAdd(body);
                                        setState(() {
                                          _isFavorite = !_isFavorite;
                                        });

                                      },
                                      child: StreamBuilder<ApiResponse<FavoriteAddModel>>(
                                        stream: _favoriteAddBloc.favoriteAddStream,
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
                                                  if (addWishlist) {

                                                    if(snapshot2.data!.data.Code != 0){
                                                      // managedSharedPref(snapshot2.data!.data);
                                                      Future.delayed(Duration.zero, () {
                                                       // Get.offAll(() => const CartPage());

                                                      });
                                                      Fluttertoast.showToast(
                                                          msg: "Successfully Added to Wishlist",
                                                          fontSize: 14,
                                                          backgroundColor: Colors.white,
                                                          gravity: ToastGravity.BOTTOM,
                                                          textColor: darkThemeBlue,
                                                          toastLength: Toast.LENGTH_LONG);

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
                                                  addWishlist = false;

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
                                          return Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius. circular(20),
                                            ),
                                            color: Colors.white,
                                            child: SizedBox(
                                              height: 4.5.h,
                                              width: 4.5.h,
                                              child: Center(
                                                child: _isFavorite
                                                    ? const Icon(
                                                  Icons.favorite_rounded,
                                                  color: Color.fromRGBO(176, 176, 176, 1),
                                                )
                                                    : const Icon(
                                                  Icons.favorite_rounded,
                                                  color: Colors
                                                      .red, // Color.fromRGBO(176, 176, 176, 1),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 7.h,
                                    //left: 0,
                                    right: 10,
                                    child: InkWell(
                                      onTap: () {
                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius. circular(20),
                                        ),
                                        color: Colors.white,
                                        child: SizedBox(
                                          height: 4.5.h,
                                          width: 4.5.h,
                                          child: const Center(
                                            child: Icon(
                                              Icons.share,
                                              color: Color.fromRGBO(176, 176, 176, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                            priceSet ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: bannerImagesColor!.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 10.0,
                                    height: 10.0,
                                    margin: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness == Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                  ),
                                );
                              }).toList(),
                            ):
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: bannerImages!.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 10.0,
                                    height: 10.0,
                                    margin: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness == Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        )
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data!.Data!.itmName!,
                        // maxLines: 2,
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14.5.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.only(left: 5),
                          height: 3.h,
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
                                padding: const EdgeInsets.only(left: 5.0, top: 1),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 3),
                          child: Text(
                            "45 Ratings & 35 Reviews",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: priceSet ? Text(
                            " \u20B9 $itemOfferPrice", //itemOfferPrice
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ) : Text(
                            " \u20B9 ${widget.iskuOfferPrice}",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 8),
                          child: Text(
                            " \u20B9 ${widget.iskuMrp}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                      child: Text(
                        "You saved  \u20B9 ${ double.parse(widget.iskuMrp) - double.parse(widget.iskuOfferPrice)}",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Divider(
                        thickness: 0.7,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Available offers",
                        // maxLines: 2,
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,top: 8,right: 8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.local_offer,
                                  size: 13.sp,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            TextSpan(
                                text: "Bank Offer ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
                                    color: Colors.black)),
                            TextSpan(
                                text:
                                " 10% off on ICICI Bank Credit Cards, up to \u20B91250. On orders of \u20B95000 and above",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Colors.black45)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,top: 8,right: 8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.local_offer,
                                  size: 13.sp,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            TextSpan(
                                text: "No Cost EMI ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
                                    color: Colors.black)),
                            TextSpan(
                                text:
                                "on Bajaj Finserv EMI Card on cart value above \u20B92999",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Colors.black45)),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: viewMore,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 8,right: 8),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.local_offer,
                                        size: 13.sp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                      text: "Bank Offer ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.sp,
                                          color: Colors.black)),
                                  TextSpan(
                                      text:
                                      " 10% off on ICICI Bank Credit Cards, up to \u20B91250. On orders of \u20B95000 and above",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          color: Colors.black45)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 8,right: 8),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.local_offer,
                                        size: 13.sp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                      text: "Bank Offer ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.sp,
                                          color: Colors.black)),
                                  TextSpan(
                                      text:
                                      " 10% off on ICICI Bank Credit Cards, up to \u20B91250. On orders of \u20B95000 and above",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          color: Colors.black45)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 8,right: 8),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.local_offer,
                                        size: 13.sp,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                      text: "Bank Offer ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.sp,
                                          color: Colors.black)),
                                  TextSpan(
                                      text:
                                      " 10% off on ICICI Bank Credit Cards, up to \u20B91250. On orders of \u20B95000 and above",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          color: Colors.black45)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            viewMore = !viewMore;
                          });
                        },
                        child: viewMore
                            ? Text(
                          "View less",
                          // maxLines: 2,
                          //overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: darkThemeBlue,
                              fontWeight: FontWeight.w600),
                        )
                            : Text(
                          "View more",
                          // maxLines: 2,
                          //overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: darkThemeBlue,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/boat-brand.jpg",
                            fit: BoxFit.fill,
                            height: 5.5.h,
                            width: 24.w,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "${snapshot.data!.Data!.itmWarranty} Replacement Warranty",
                            // maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11.5.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Color",
                              //"${snapshot.data!.Data!.itemSkuDetailsModels![0]!.primaryVarName}",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: SizedBox(
                              height: 10.h,
                              child: ListView.builder(
                                //padding: EdgeInsets.only(top: 8, bottom: 0, left: 4.0.w, right: 4.0.w),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: snapshot.data!.Data!.itemSkuDetailsModels!.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      priceSet=true;
                                      itemOfferPrice=snapshot.data!.Data!.itemSkuDetailsModels![index]!.iskuOfferPrice.toString();

                                      bannerImagesColor=snapshot.data!.Data!.itemSkuDetailsModels![index]!.iskuImages;

                                     // bannerImagesColor?.add(snapshot.data!.Data!.itemSkuDetailsModels![index]!.iskuImage_1!);
                                    });
                                  },
                                  child: Container(
                                    height: 7.h,
                                    width: 7.h,
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey[300]!)),
                                    child: FadeInImage(
                                      image: NetworkImage(
                                          snapshot.data!.Data!.itemSkuDetailsModels![index]!.iskuImage_1!),
                                      // width: 65.w,
                                      // height: 32.h,
                                      placeholder: const AssetImage("images/headphone.jpg"),
                                      fit: BoxFit.fill,
                                    ),
                                    // Image.asset(
                                    //   widget.productPic,
                                    //   fit: BoxFit.fill,
                                    //   // height: 5.5.h,
                                    //   // width: 24.w,
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Highlights",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                           SingleChildScrollView(
                             scrollDirection: Axis.horizontal,
                             physics: const NeverScrollableScrollPhysics(),
                             child: SizedBox(
                               width: 100.h,
                               child: Html(
                                 data: """${snapshot.data!.Data!.itmHighlights}""",
                               ),
                             ),
                           ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Expanded(
                    //         flex: 2,
                    //         child: Text(
                    //           "Highlights",
                    //           style: TextStyle(
                    //               fontSize: 13.sp,
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.w600),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         flex: 4,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           //mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 Icon(
                    //                   Icons.circle,
                    //                   color: Colors.black,
                    //                   size: 5.sp,
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(left: 8.0),
                    //                   child: Text(
                    //                     //snapshot.data!.Data!.itmDescription!,
                    //                     "With Mic: Yes",
                    //                     style: TextStyle(
                    //                         fontSize: 11.sp,
                    //                         color: Colors.black,
                    //                         fontWeight: FontWeight.w400),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Icon(
                    //                   Icons.circle,
                    //                   color: Colors.black,
                    //                   size: 5.sp,
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(left: 8.0),
                    //                   child: Text(
                    //                     "Bluetooth ersion: 4.1",
                    //                     style: TextStyle(
                    //                         fontSize: 11.sp,
                    //                         color: Colors.black,
                    //                         fontWeight: FontWeight.w400),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Icon(
                    //                   Icons.circle,
                    //                   color: Colors.black,
                    //                   size: 5.sp,
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(left: 8.0),
                    //                   child: Text(
                    //                     "Wireless range: 10 m",
                    //                     style: TextStyle(
                    //                         fontSize: 11.sp,
                    //                         color: Colors.black,
                    //                         fontWeight: FontWeight.w400),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Row(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Padding(
                    //                   padding:
                    //                   const EdgeInsets.only(top: 5.0, right: 8.0),
                    //                   child: Icon(
                    //                     Icons.circle,
                    //                     color: Colors.black,
                    //                     size: 5.sp,
                    //                   ),
                    //                 ),
                    //                 Expanded(
                    //                   child: Text(
                    //                     "Battery life: 10 hrs | Charging time: 2.5 hrs",
                    //                     style: TextStyle(
                    //                         fontSize: 11.sp,
                    //                         color: Colors.black,
                    //                         fontWeight: FontWeight.w400),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Visibility(
                    //               visible: highlightsViewMore,
                    //               child: Column(
                    //                 children: [
                    //                   Row(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             top: 5.0, right: 8.0),
                    //                         child: Icon(
                    //                           Icons.circle,
                    //                           color: Colors.black,
                    //                           size: 5.sp,
                    //                         ),
                    //                       ),
                    //                       Expanded(
                    //                         child: Text(
                    //                           "Extra bass: Add extra thump to your music",
                    //                           style: TextStyle(
                    //                               fontSize: 11.sp,
                    //                               color: Colors.black,
                    //                               fontWeight: FontWeight.w400),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   Row(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             top: 5.0, right: 8.0),
                    //                         child: Icon(
                    //                           Icons.circle,
                    //                           color: Colors.black,
                    //                           size: 5.sp,
                    //                         ),
                    //                       ),
                    //                       Expanded(
                    //                         child: Text(
                    //                           "Using simple touch controls answer phone calls, change music track and control volume",
                    //                           style: TextStyle(
                    //                               fontSize: 11.sp,
                    //                               color: Colors.black,
                    //                               fontWeight: FontWeight.w400),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   Row(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             top: 5.0, right: 8.0),
                    //                         child: Icon(
                    //                           Icons.circle,
                    //                           color: Colors.black,
                    //                           size: 5.sp,
                    //                         ),
                    //                       ),
                    //                       Expanded(
                    //                         child: Text(
                    //                           "Lightweight and comfortable ear tips which is available in 3 sizes provides comfortable musical experience for longer listing",
                    //                           style: TextStyle(
                    //                               fontSize: 11.sp,
                    //                               color: Colors.black,
                    //                               fontWeight: FontWeight.w400),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: InkWell(
                    //                 onTap: () {
                    //                   setState(() {
                    //                     highlightsViewMore = !highlightsViewMore;
                    //                   });
                    //                 },
                    //                 child: highlightsViewMore
                    //                     ? Text(
                    //                   "View less",
                    //                   // maxLines: 2,
                    //                   //overflow: TextOverflow.ellipsis,
                    //                   style: TextStyle(
                    //                       fontSize: 13.sp,
                    //                       color: darkThemeBlue,
                    //                       fontWeight: FontWeight.w600),
                    //                 )
                    //                     : Text(
                    //                   "View more",
                    //                   // maxLines: 2,
                    //                   //overflow: TextOverflow.ellipsis,
                    //                   style: TextStyle(
                    //                       fontSize: 13.sp,
                    //                       color: darkThemeBlue,
                    //                       fontWeight: FontWeight.w600),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          showDescription = !showDescription;
                        });
                      },
                      child: showDescription
                          ? Container(
                        height: 6.5.h,
                        //width:  55.w,
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10,),
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(5)
                          //border: Border.all(color: Colors.grey[300]!)
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Product Description",
                              style: TextStyle(
                                  color: darkThemeBlue,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.keyboard_arrow_up,
                              size: 18.sp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      )
                          : Container(
                        height: 6.5.h,
                        //width:  55.w,
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10,),
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Text(
                              "Product Description",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 18.sp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0,left: 8.0,bottom: 8.0),
                      child: Visibility(
                        visible: showDescription,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.0.w,right: 5.w),
                                  child: Html(
                                    data: """${snapshot.data!.Data!.itmDescription}""",
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          showSpecifications = !showSpecifications;
                        });
                      },
                      child: showSpecifications
                          ? Container(
                        height: 6.5.h,
                        //width:  55.w,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(5)
                          //border: Border.all(color: Colors.grey[300]!)
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Specifications",
                              style: TextStyle(
                                  color: darkThemeBlue,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.keyboard_arrow_up,
                              size: 18.sp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      )
                          : Container(
                        height: 6.5.h,
                        //width:  55.w,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Text(
                              "Specifications",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 18.sp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: showSpecifications,
                      child : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        //physics: const NeverScrollableScrollPhysics(),
                        child: SizedBox(
                          width: 70.h,
                        child: Padding(
                          padding:
                          EdgeInsets.only(left: 1.0.w, right: 8, top: 8, bottom: 8),
                          child: Html(
                            data: """${snapshot.data!.Data!.itmSpecifications}""",
                          ),
                        ),
                      ),
                     ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ratings & Reviews",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "4.5/5 ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 19.sp,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "45 Rating &",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "35 Reviews",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, left: 8, top: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            "5 ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 9.sp,
                                            color: Colors.black,
                                          ),
                                          LinearPercentIndicator(
                                            width: 38.w,
                                            lineHeight: 6.0,
                                            percent: 0.8,
                                            barRadius: const Radius.circular(5),
                                            progressColor: Colors.green[600],
                                          ),
                                          Text(
                                            "20 ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, left: 8, top: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            "4 ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 9.sp,
                                            color: Colors.black,
                                          ),
                                          LinearPercentIndicator(
                                            width: 38.w,
                                            lineHeight: 6.0,
                                            percent: 0.6,
                                            barRadius: const Radius.circular(5),
                                            progressColor: Colors.green[600],
                                          ),
                                          Text(
                                            "12 ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, left: 8, top: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            "3 ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 9.sp,
                                            color: Colors.black,
                                          ),
                                          LinearPercentIndicator(
                                            width: 38.w,
                                            lineHeight: 6.0,
                                            percent: 0.5,
                                            barRadius: const Radius.circular(5),
                                            progressColor: Colors.green[600],
                                          ),
                                          Text(
                                            "8 ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, left: 8, top: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            "2 ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 9.sp,
                                            color: Colors.black,
                                          ),
                                          LinearPercentIndicator(
                                            width: 38.w,
                                            lineHeight: 6.0,
                                            percent: 0.3,
                                            progressColor: Colors.yellow[700],
                                            barRadius: const Radius.circular(5),
                                          ),
                                          Text(
                                            "6 ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, left: 8, top: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            "1 ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 9.sp,
                                            color: Colors.black,
                                          ),
                                          LinearPercentIndicator(
                                            width: 38.w,
                                            lineHeight: 6.0,
                                            percent: 0.2,
                                            barRadius: const Radius.circular(5),
                                            progressColor: Colors.red[600],
                                          ),
                                          Text(
                                            "3 ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      //padding: EdgeInsets.only(top: 8, bottom: 0, left: 4.0.w, right: 4.0.w),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: 2,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          // Get.to(() => ProductByCategory(snapshot.data!.data![0]!.subcategory![index]!.id!));
                        },
                        child: Card(
                          elevation: 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 5, right: 5),
                                      height: 3.h,
                                      //width: 19.w,
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
                                              "4.5",
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
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0, top: 3),
                                      child: Text(
                                        "Mind-blowing purchas",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Good built quality , not a headphone with immense sound..u can hear the songs in full volume for long time...nd most important one it has a very good looks.. overall a worth buying one in this price",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "images/headphone.jpg",
                                      fit: BoxFit.fill,
                                      height: 6.h,
                                      width: 6.h,
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Image.asset(
                                      "images/dualmodeheadph.jpeg",
                                      fit: BoxFit.fill,
                                      height: 7.h,
                                      width: 6.h,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Adarsh Gupta ",
                                      style: TextStyle(
                                          fontSize: 10.5.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.grey,
                                      size: 12.sp,
                                    ),
                                    Text(
                                      " Certified Buyer, Noida Oct, 018",
                                      style: TextStyle(
                                          fontSize: 10.5.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16, bottom: 8),
                      child: Text(
                        "Questions and Answers",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListView.builder(
                      //padding: EdgeInsets.only(top: 8, bottom: 0, left: 4.0.w, right: 4.0.w),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: 2,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          // Get.to(() => ProductByCategory(snapshot.data!.data![0]!.subcategory![index]!.id!));
                        },
                        child: Card(
                          elevation: 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Q: this support realme c1 ",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "A: Obviously ",
                                  style: TextStyle(
                                      fontSize: 13.5.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.grey,
                                      size: 12.sp,
                                    ),
                                    Text(
                                      " Certified Buyer",
                                      style: TextStyle(
                                          fontSize: 10.5.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    //Container(height: 30,color: Colors.orange[50],),
                  ],
                ),
                bottomSheet: Container(
                  margin: const EdgeInsets.only(bottom: 0),
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.white,
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
                      gotCrt ? InkWell(
                        onTap: () {
                          Get.to(() => const CartPage());
                        },
                        child: Container(
                          width: 50.w,
                          decoration: const BoxDecoration(
                            color: darkThemeBlue,
                            // gradient: LinearGradient(
                            //   begin: Alignment.centerLeft,
                            //   end: Alignment.centerRight,
                            //   colors: <Color>[
                            //     darkThemeBlue,
                            //     darkThemeOrange,
                            //   ],
                            // ),
                          ),
                          child:   const Center(
                            child: Text(
                              'GO TO CART',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ):
                      InkWell(
                        onTap: () {
                          setState(() {
                            gotCrt=! gotCrt;
                          });
                          setCart1=true;
                          Map body ={
                            "cart_cus_id": userId,
                            "cart_seller_id": "${snapshot.data!.Data!.itemSkuDetailsModels![0]!.sstkSellerId!}",
                            "cart_itm_id": "${snapshot.data!.Data!.itmId!}",
                            "cart_isku_id": "${snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuId!}",
                            "cart_qty": "1"
                          };
                          _setCartBloc.setCart(body);
                        },
                        child: StreamBuilder<ApiResponse<SetCartModel>>(
                          stream: _setCartBloc.setCartStream,
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
                                    if (setCart1) {

                                      if(snapshot2.data!.data.Code != 0){
                                        // // managedSharedPref(snapshot2.data!.data);
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
                                    setCart1 = false;

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
                            return Container(
                              width: 50.w,
                              decoration: const BoxDecoration(
                                color: darkThemeBlue,
                                // gradient: LinearGradient(
                                //   begin: Alignment.centerLeft,
                                //   end: Alignment.centerRight,
                                //   colors: <Color>[
                                //     darkThemeBlue,
                                //     darkThemeOrange,
                                //   ],
                                // ),
                              ),
                              child: const Center(
                                child: Text(
                                  'ADD TO CART',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),

                      ),
                      InkWell(
                        onTap: () {
                          setCart=true;
                          Map body ={
                            "cart_cus_id": userId,
                            "cart_seller_id": "${snapshot.data!.Data!.itemSkuDetailsModels![0]!.sstkSellerId!}",
                            "cart_itm_id": "${snapshot.data!.Data!.itmId!}",
                            "cart_isku_id": "${snapshot.data!.Data!.itemSkuDetailsModels![0]!.iskuId!}",
                            "cart_qty": "1"
                          };
                          _setCartBloc.setCart(body);

                          //Get.to(() =>  const CartPage());
                        },
                        child: StreamBuilder<ApiResponse<SetCartModel>>(
                          stream: _setCartBloc.setCartStream,
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
                                    if (setCart) {

                                      if(snapshot2.data!.data.Code != 0){
                                       // managedSharedPref(snapshot2.data!.data);
                                        Future.delayed(Duration.zero, () {
                                          Get.offAll(() => const CartPage());

                                        });

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
                            return Container(
                              width: 50.w,
                              decoration: const BoxDecoration(
                                color: darkThemeOrange,
                                // gradient: LinearGradient(
                                //   begin: Alignment.centerLeft,
                                //   end: Alignment.centerRight,
                                //   colors: <Color>[
                                //     darkThemeBlue,
                                //     darkThemeOrange,
                                //   ],
                                // ),
                              ),
                              child: const Center(
                                child: Text(
                                  'BUY NOW',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),

                      ),
                    ],
                  ),
                ),
              ) ;
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
