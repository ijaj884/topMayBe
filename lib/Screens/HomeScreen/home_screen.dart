import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:topmaybe/Screens/ProductDetails/product_details.dart';
import '../../constant.dart';
import 'dart:async';
import '../BecomeAseller/become_a_seller.dart';
import '../CartPage/cart_page.dart';
import '../Login/login_page.dart';
import '../MyAddress/manage_addresses.dart';
import '../MyOrderHistory/my_order_history.dart';
import '../ProductByCategory/product_by_category.dart';
import '../WishList/WishListAdded/FavoriteAddBloc.dart';
import '../WishList/WishlistPage/WishlistPage.dart';
import 'GetAllActiveDeals/GetAllActiveDealsOfTheDay/get_all_active_deals_of_the_day_model.dart';
import 'GetAllActiveDeals/get_all_active_deals_repository.dart';
import 'GetAllActiveDeals/get_best_seller.dart';
import 'GetAllActiveDeals/new_arrival_model.dart';
import 'GetBannerforHomePage/get_banner2_model.dart';
import 'GetBannerforHomePage/get_bannerfor_home_page_model.dart';
import 'GetBannerforHomePage/get_bannerfor_homepage_repository.dart';
import 'GetMainCategoryModel/get_main_category_model.dart';
import 'GetMainCategoryModel/get_main_category_repository.dart';
import 'GetRecentlyViewed/get_recently_viewed.dart';
import 'GetRecentlyViewed/get_recently_viewed_repository.dart';
import 'GetTopOffers/get_top_offers_model.dart';
import 'GetTopOffers/get_top_offers_repository.dart';
import 'GetUnderPrice/get_under_price_model.dart';
import 'GetUnderPrice/get_under_price_repository.dart';
import 'customWidgets/ProductFrameCircleWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> catImages = [
    'images/categoryimage.png',
    'images/categoryimage.png',
    'images/categoryimage.png',
    'images/categoryimage.png',
    'images/categoryimage.png',
    'images/categoryimage.png',
    'images/categoryimage.png',
    'images/categoryimage.png',
  ];
  List catName = [
    "Category",
    "Category",
    "Category",
    "Category",
    "Category",
    "Category",
    "Category",
    "Category",
  ];
  List<String> bannerImagesAPI = [];
  List<String> bannerImagesAPI2 = [];
  List<String> itemByPrice = [];
  List<String> bannerImages = [
    "images/bn1.jpg",
    "images/bn2.jpg",
    "images/bn3.jpg",
  ];
  List<String> shopbycatImages = [
    "images/cat1.jpg",
    "images/cat1.jpg",
    "images/cat1.jpg",
    "images/cat1.jpg",
  ];
  List<String> headphoneImages = [
    "images/headphone.jpg",
    "images/headphone.jpg",
    "images/headphone.jpg",
    "images/headphone.jpg",
    "images/headphone.jpg",
    "images/headphone.jpg",
  ];

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (kDebugMode) {
      print(position);
    }
    userLat = position.latitude;
    userLong = position.longitude;
    //List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);
    List<Placemark> newPlace =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // this is all you need
    Placemark placeMark = newPlace[0];
    String? name = placeMark.street;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    String addressess =
        "$name$subLocality, $locality, $administrativeArea $postalCode, $country";

    print(addressess);

    setState(() {
      address = addressess; // update _address
    });
  }

  late Timer _timer;
  int _start = 86400;
  late DateTime _now;
  late DateTime _auction;

  //late Timer _timer;

  void startTimer() {
    _now = DateTime.now();
    // Sets the date time of the auction.
    _auction = _now.add(const Duration(days: 1));

    // Creates a timer that fires every second.
    _timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (timer) {
        setState(() {
          // Updates the current date time.
          _now = DateTime.now();

          // If the auction has now taken place, then cancels the timer.
          if (_auction.isBefore(_now)) {
            timer.cancel();
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool _isFavorite = true;

  final List<bool> _isFavoriteBest = [];
  final List<bool> _isFavoriteDeals = [];
  final List<bool> _isFavoriteNew = [];
  final List<bool> _isFavoriteRecentView = [];
  final FavoriteAddBloc _favoriteAddBloc = FavoriteAddBloc();

  @override
  void initState() {
    super.initState();
    createSharedPref();
    //getLocation();
    startTimer();

    // _now = DateTime.now();
    // // Sets the date time of the auction.
    // _auction = _now.add(Duration(days: 1));
    //
    // // Creates a timer that fires every second.
    // _timer = Timer.periodic(
    //   Duration(
    //     seconds: 1,
    //   ),
    //       (timer) {
    //     setState(() {
    //       // Updates the current date time.
    //       _now = DateTime.now();
    //
    //       // If the auction has now taken place, then cancels the timer.
    //       if (_auction.isBefore(_now)) {
    //         timer.cancel();
    //       }
    //     });
    //   },
    // );
  }

  late SharedPreferences prefs;
  late Map _body;
  Future<GetBannerforHomePageModel>? _getBannerforHomePage;
  Future<GetBanner2Model>? _getBanner2; //
  late GetBannerforHomePageRepository _getBannerforHomePageRepository;

  Future<GetMainCategoryModel>? _getMainCategoryModel;
  late GetMainCategoryRepository _getMainCategoryRepository;

  Future<GetUnderPriceModel>? _getunderprice;
  late GetUnderPriceRepository _getUnderPriceRepository;

  Future<GetAllActiveDealsOfTheDayModel>? _getDealsOfTheDay;
  Future<GetBestSellerModel>? _getBestSeller;
  Future<NewArrivalModel>? _getNewArrival;
  late GetAllActiveDealsRepository _getAllActiveDealsRepository;

  Future<GetTopOffersModel>? _getTopOffer;
  late GetTopOfferRepository _getTopOfferRepository;

  Future<GetRecentlyViewedModel>? _getRecentlyView;
  late GetRecentlyViewedRepository _getRecentlyViewedRepository;

  String userId = "0";

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    if (userLogin) {
      userId = prefs.getString("user_id")!;
    }
    _getBannerforHomePageRepository = GetBannerforHomePageRepository();
    _body = {};
    _getBannerforHomePage = _getBannerforHomePageRepository.getBanner(_body);
    _getBanner2 = _getBannerforHomePageRepository.getBanner2(_body);

    _getMainCategoryRepository = GetMainCategoryRepository();
    _getMainCategoryModel = _getMainCategoryRepository.getMainCategory(_body);

    _getUnderPriceRepository = GetUnderPriceRepository();
    _getunderprice = _getUnderPriceRepository.getUnderPrice(_body);

    _getAllActiveDealsRepository = GetAllActiveDealsRepository();
    _getDealsOfTheDay = _getAllActiveDealsRepository.getDealsOfTheDay(userId);
    _getBestSeller = _getAllActiveDealsRepository.getBestSeller(userId);
    _getNewArrival = _getAllActiveDealsRepository.getNewArrival(userId);

    _getTopOfferRepository = GetTopOfferRepository();
    _getTopOffer = _getTopOfferRepository.getTopOfer(userId);

    _getRecentlyViewedRepository = GetRecentlyViewedRepository();
    _getRecentlyView = _getRecentlyViewedRepository.getRecentlyViewed(userId);

    setState(() {});
  }

  clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final difference = _auction.difference(_now);
    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: drawer(),
        ),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Column(
              children: [
                AppBar(
                  centerTitle: false,
                  titleSpacing: 0,
                  backgroundColor: Colors.white,
                  bottomOpacity: 0.0,
                  elevation: 0.0,
                  leading: IconButton(
                    onPressed: () => _key.currentState?.openDrawer(),
                    icon: const Icon(
                      Icons.menu,
                      color: darkThemeBlue,
                      //size: 18.sp,
                    ),
                  ),
                  title: Container(
                    padding: EdgeInsets.only(left: 5.w),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    // height: 75.0,
                    child: Text("MyStore",
                        style: TextStyle(
                            color: darkThemeBlue,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500)),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(right: 8.0),
                    //       child: Icon(
                    //         Icons.location_on,
                    //         color: Color.fromRGBO(90, 90, 90, 1),
                    //         size: 16.sp,
                    //       ),
                    //     ),
                    //     Expanded(
                    //         child: address == null
                    //             ? Text('',
                    //                 style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 15,
                    //                     fontWeight: FontWeight.bold))
                    //             : Text(address!,
                    //                 style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 15,
                    //                     fontWeight: FontWeight.bold))),
                    //   ],
                    // ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => const CartPage());
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: darkThemeBlue,
                        size: 18.sp,
                      ),
                    ),
                    userLogin
                        ? Container()
                        : IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.person,
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
                Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                  height: 6.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          // onChanged: (_) {
                          //   Navigator.push(context, MaterialPageRoute(builder:
                          //       (context) => SearchBarPage()));
                          // },
                          onTap: () {},
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,

                              // prefixIcon: new Icon(Icons.search, color: Colors.grey[600]),
                              hintText: "Search any product...",
                              hintStyle: TextStyle(color: Colors.grey[600])),
                        ),
                      ),
                      Icon(
                        Icons.search_rounded,
                        color: darkThemeBlue,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ],
            )),
        body: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            category(),

            bannerSlider(),
            const SizedBox(
              height: 3,
            ),
            shopbycategory(),
            underprice(),
            Container(
              height: 3,
              color: Colors.grey[100],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0, left: 12, top: 8, bottom: 8),
                  child: Text(
                    "Deals of the day",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                        color: Colors.black),
                  ),
                ),
                Icon(
                  Icons.timer,
                  color: Colors.red,
                  size: 18.sp,
                ),
                const SizedBox(
                  width: 5,
                ),
                Center(
                    child: Text(
                  "${difference.inHours} : ${difference.inMinutes.remainder(60)} : ${difference.inSeconds.remainder(60)}",
                  style: TextStyle(color: Colors.black, fontSize: 12.sp),
                )),
              ],
            ),
            dealsOfDay(difference),
            Container(
              height: 3,
              color: Colors.grey[100],
            ),
            bannerSlider2(),
            Container(
              height: 3,
              color: Colors.grey[100],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 12, top: 8, bottom: 8),
              child: Text(
                "Top Offers",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    color: Colors.black),
              ),
            ),
            topOffer(),
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 12, top: 8, bottom: 8),
              child: Text(
                "Best Seller",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    color: Colors.black),
              ),
            ),
            bestseller(difference),
            Container(
              height: 3,
              color: Colors.grey[100],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 12, top: 8, bottom: 8),
              child: Text(
                "New Arrival",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    color: Colors.black),
              ),
            ),
            // Container(
            //   height: 3,
            //   color: Colors.grey[100],
            // ),
            newArrival(difference),
            Container(
              height: 3,
              color: Colors.grey[100],
            ),
            // userLogin
            //     ? Padding(
            //         padding: const EdgeInsets.only(
            //             right: 8.0, left: 12, top: 8, bottom: 8),
            //         child: Text(
            //           "Recently Viewed",
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 13.sp,
            //               color: Colors.black),
            //         ),
            //       )
            //     : Container(),
            userLogin ? recentlyView() : Container(),
            userLogin
                ? Container(
                    height: 3,
                    color: Colors.grey[100],
                  )
                : Container(),
            //productDeals(),
            Container(
              height: 30,
              color: Colors.orange[50],
            ),
          ],
        ),
      ),
    );
  }

  drawer() {
    return ListView(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 7.0.h,
            color: lightThemeBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.5.w, top: 1.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 17.sp,
                      ),
                      SizedBox(
                        width: 5.9.w,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 4.0.w),
                  child: Image.asset(
                    "images/favicon-topmaybe.png",
                    fit: BoxFit.fill,
                    width: 8.5.w,
                    height: 4.h,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
          child: ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              horizontalTitleGap: 8,
              title: const Text("My Account"),
              onTap: () {
                /* react to the tile being tapped */
              }),
        ),
        SizedBox(
          height: 5.h,
          child: ListTile(
              leading: const Icon(
                Icons.list, //dashboard_customize,
                color: Colors.black,
              ),
              horizontalTitleGap: 8,
              title: const Text("My Orders"),
              onTap: () {
                Get.to(() => const MyOrder());
              }),
        ),
        SizedBox(
          height: 5.h,
          child: ListTile(
              leading: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              title: const Text("My Cart"),
              horizontalTitleGap: 8,
              onTap: () {
                Get.to(() => const CartPage());
              }),
        ),
        SizedBox(
          height: 5.h,
          child: ListTile(
              leading: const Icon(
                Icons.card_giftcard,
                color: Colors.black,
              ),
              horizontalTitleGap: 8,
              title: const Text("My Coupons"), //style: ListTileStyle.list,
              onTap: () {}),
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(thickness: 0.7),
        SizedBox(
          height: 5.h,
          child: ListTile(
              leading: const Icon(
                Icons.shop,
                color: darkThemeBlue,
              ),
              horizontalTitleGap: 8,
              title: const Text("Become a Seller"),
              textColor: darkThemeBlue,
              style: ListTileStyle.drawer,
              onTap: () {
                Get.to(() => const BecomeASeller());
              }),
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          thickness: 0.7,
        ),
        SizedBox(
          height: 5.h,
          child: ListTile(
              leading: const Icon(
                Icons.favorite_rounded,
                color: Colors.black,
              ),
              horizontalTitleGap: 8,
              title: const Text("My Wishlist"), //style: ListTileStyle.list,
              onTap: () {
                Get.to(() => const WishList());
              }),
        ),
        SizedBox(
          height: 5.h,
          child: ListTile(
              leading: const Icon(
                Icons.star,
                color: Colors.black,
                //size: 18.sp,
              ),
              horizontalTitleGap: 8,
              title: const Text("My Reviews & Ratings"),
              //style: ListTileStyle.list,
              onTap: () {}),
        ),
        SizedBox(
          height: 5.h,
          child: ListTile(
              leading: const Icon(
                Icons.location_history_rounded,
                color: Colors.black,
              ),
              horizontalTitleGap: 8,
              title: const Text("Manage Addresses"),
              //style: ListTileStyle.list,
              onTap: () {
                Get.to(() => const ManageAddressList());
              }),
        ),
        SizedBox(
          height: 5.h,
          child: ListTile(
              leading: const Icon(
                Icons.credit_card_sharp,
                color: Colors.black,
              ),
              horizontalTitleGap: 8,
              title: const Text("Saved Cards"), //style: ListTileStyle.list,
              onTap: () {}),
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          thickness: 0.7,
        ),
        SizedBox(
          // margin: EdgeInsets.only(bottom: 1.h),
          // padding: EdgeInsets.all(8),
          height: 5.h,
          child: ListTile(
              leading: const Icon(
                Icons.logout,
                color: darkThemeBlue,
              ),
              horizontalTitleGap: 8,
              title: const Text("Logout"),
              textColor: darkThemeBlue,
              style: ListTileStyle.drawer,
              onTap: () {
                clearData();
              }),
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(thickness: 0.7),
        const Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              bottom: 8.0,
            ),
            child: Text(
              "About Us",
              style: TextStyle(color: Colors.grey),
            )),
        const Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
            child: Text(
              "Help Center",
              style: const TextStyle(color: Colors.grey),
            )),
        const Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
            child: Text(
              "Privacy Policy",
              style: const TextStyle(color: Colors.grey),
            )),
        const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
            child: Text(
              "Termsand conditions",
              style: TextStyle(color: Colors.grey),
            )),
        const Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
            child: Text(
              "Shipping Policy",
              style: const TextStyle(color: Colors.grey),
            )),
        const Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
            child: Text(
              "Return Policy",
              style: const TextStyle(color: Colors.grey),
            )),
        const Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
            child: const Text(
              "Refund Policy",
              style: TextStyle(color: Colors.grey),
            )),
      ],
    );
  }

  Widget bannerSlider() {
    return FutureBuilder<GetBannerforHomePageModel>(
      future: _getBannerforHomePage,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data!.Data!.length; i++) {
            bannerImagesAPI.add(snapshot.data!.Data![i]!.bnrImage!);
          }
          return CarouselSlider(
            options: CarouselOptions(
              //height: MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height * 0.21,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: true,
            ),
            items: bannerImagesAPI
                .map((item) => Container(
                      child: Center(
                        child: FadeInImage(
                          image: NetworkImage(item),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          placeholder: const AssetImage("images/bn1.jpg"),
                          fit: BoxFit.fill,
                        ),

                        // Image.asset(
                        //   item,
                        //   fit: BoxFit.cover,
                        //   width: MediaQuery.of(context).size.width,
                        //   height: MediaQuery.of(context).size.height * 0.3,
                        // )
                      ),
                    ))
                .toList(),
          );
        } else if (snapshot.hasError) {
          print("hello");
          return Container(
            child: const Center(
                child: Text(
              "No Data ",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              darkThemeOrange,
            ),
          ));
        }
      },
    );
  }

  Widget bannerSlider2() {
    return FutureBuilder<GetBanner2Model>(
      future: _getBanner2,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data!.Data!.length; i++) {
            bannerImagesAPI2.add(snapshot.data!.Data![i]!.bnrImage!);
          }
          return Container(
            //padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: CarouselSlider(
              options: CarouselOptions(
                //height: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height * 0.21,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: true,
              ),
              items: bannerImagesAPI2
                  .map((item) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(item),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(
                                6) // use instead of BorderRadius.all(Radius.circular(20))
                            ),
                        // child: Center(
                        //   child: FadeInImage(
                        //     image: NetworkImage(
                        //         item),
                        //     width: MediaQuery.of(context).size.width,
                        //     height: MediaQuery.of(context).size.height * 0.3,
                        //     placeholder: const AssetImage("images/bn1.jpg"),
                        //     fit: BoxFit.fill,
                        //   ),
                        //
                        //   // Image.asset(
                        //   //   item,
                        //   //   fit: BoxFit.cover,
                        //   //   width: MediaQuery.of(context).size.width,
                        //   //   height: MediaQuery.of(context).size.height * 0.3,
                        //   // )
                        // ),
                      ))
                  .toList(),
            ),
          );
        } else if (snapshot.hasError) {
          print("hello");
          return Container(
            child: const Center(
                child: Text(
              "No Data ",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              darkThemeOrange,
            ),
          ));
        }
      },
    );
  }

  Widget category() {
    return Container(
      height: 11.5.h,
      color: Colors.orange[50],
      child: FutureBuilder<GetMainCategoryModel>(
        future: _getMainCategoryModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding:
                  EdgeInsets.only(top: 8, bottom: 0, left: 4.0.w, right: 4.0.w),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data!.Data!.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.to(() => ProductByCategory(
                        categoryName: snapshot.data!.Data![index]!.catName!,
                        categoryId:
                            snapshot.data!.Data![index]!.catId.toString(),
                      ));
                },
                child: ProductFrameCircle(
                  productImage: snapshot.data!.Data![index]!.catImage!,
                  productName: snapshot.data!.Data![index]!.catName!,
                  textStyle: productsNameStyleSmall,
                  containerHeight: 70,
                  containerWidth: 63,
                  imageHeight: 52,
                  containerPadding: EdgeInsets.only(top: 2, right: 2.5.w),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print("hello");
            return const Center(
                child: Text(
              "No Data ",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ));
          } else {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                darkThemeOrange,
              ),
            ));
          }
        },
      ),
    );
  }

  Widget shopbycategory() {
    return Container(
      color: Colors.orange[50],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                  top: 10.0,
                  bottom: 5.0,
                  left: 11,
                ),
                child: Text(
                  "Shop by category",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: Colors.black),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(right: 10, left: 10, top: 8),
                height: 4.h,
                width: 17.w,
                color: darkThemeBlue,
                child: Text(
                  "View all",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10.5.sp,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.75),
            ),
            itemCount: shopbycatImages.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 2.h,),
                    Container(
                      margin: const EdgeInsets.all(8),
                      height: 18.5.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage(shopbycatImages[index]),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(
                              5) // use instead of BorderRadius.all(Radius.circular(20))
                          ),
                      // child: Image.asset(
                      //   shopbycatImages[index],
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Min. 70% Off",
                        style: TextStyle(fontSize: 12.sp, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Container(
          //   height: 22.0.h,
          //   child: ListView.builder(
          //     //padding: EdgeInsets.only(top: 8, bottom: 0, left: 4.0.w, right: 4.0.w),
          //     scrollDirection: Axis.horizontal,
          //     shrinkWrap: true,
          //     itemCount: bannerImages.length,
          //     itemBuilder: (context, index) => InkWell(
          //       onTap: (){
          //         // Get.to(() => ProductByCategory(snapshot.data!.data![0]!.subcategory![index]!.id!));
          //       },
          //       child: Container(
          //         width: MediaQuery.of(context).size.width,
          //         child: Image.asset(
          //           bannerImages[index],
          //           fit: BoxFit.fill,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget underprice() {
    return FutureBuilder<GetUnderPriceModel>(
      future: _getunderprice,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.Data!.ItemByPrice1 != null) {
            itemByPrice.add(snapshot.data!.Data!.ItemByPrice1.toString());
            itemByPrice.add(snapshot.data!.Data!.ItemByPrice2.toString());
            itemByPrice.add(snapshot.data!.Data!.ItemByPrice3.toString());
            itemByPrice.add(snapshot.data!.Data!.ItemByPrice4.toString());
            itemByPrice.add(snapshot.data!.Data!.ItemByPrice5.toString());
            itemByPrice.add(snapshot.data!.Data!.ItemByPrice6.toString());
            itemByPrice.add(snapshot.data!.Data!.ItemByPrice7.toString());
            itemByPrice.add(snapshot.data!.Data!.ItemByPrice8.toString());
          }
          return SizedBox(
            height: 17.5.h,
            child: ListView.builder(
              //padding: EdgeInsets.only(top: 8, bottom: 0, left: 4.0.w, right: 4.0.w),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              physics: const ScrollPhysics(),

              itemCount: itemByPrice.length.reactive(8),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  // Get.to(() => ProductByCategory(snapshot.data!.data![0]!.subcategory![index]!.id!));
                },
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              height: 8.5.h,
                              width: 8.5.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey[700]!),
                                  borderRadius: BorderRadius.circular(
                                      12) // use instead of BorderRadius.all(Radius.circular(20))
                                  ),
                              child: Center(
                                child: Text(
                                  "\u20B9${itemByPrice[index]}",
                                  style: TextStyle(
                                      fontSize: 16.5.sp,
                                      color: darkThemeOrange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 3),
                          child: Text(
                            "Under \u20B9${itemByPrice[index]}",
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          print("Error");
          return Container(
            child: const Center(
                child: Text(
              "No Data ",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              darkThemeOrange,
            ),
          ));
        }
      },
    );
  }

  dealsOfDay(Duration difference) {
    return SizedBox(
      height: 42.0.h,
      child: FutureBuilder<GetAllActiveDealsOfTheDayModel>(
        future: _getDealsOfTheDay,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.Data!.length; i++) {
              _isFavoriteDeals.add(snapshot.data!.Data![i]!.isAddedToWishList!);
            }
            return ListView.builder(
              //padding: EdgeInsets.only(top: 8, bottom: 0, left: 4.0.w, right: 4.0.w),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data!.Data!.length,
              itemBuilder: (context, index) {
                //_isFavoriteDeals.add(snapshot.data!.Data![index]!.isAddedToWishList!);
                return InkWell(
                  onTap: () {
                    Get.to(() => ProductDetails(
                          itemId:
                              snapshot.data!.Data![index]!.iskuItmId.toString(),
                          iskuOfferPrice: snapshot
                              .data!.Data![index]!.iskuOfferPrice
                              .toString(),
                          iskuMrp:
                              snapshot.data!.Data![index]!.iskuMrp.toString(),
                          iskuId:
                              snapshot.data!.Data![index]!.iskuId.toString(),
                        ));
                  },
                  child: Card(
                    elevation: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.475,
                      padding: const EdgeInsets.all(0),
                      //margin: EdgeInsets.only(left: 8),
                      child: Stack(children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: FadeInImage(
                                  image: NetworkImage(snapshot
                                      .data!.Data![index]!.iskuImage_1!),
                                  width: 35.w,
                                  height: 20.h,
                                  placeholder:
                                      const AssetImage("images/headphone.jpg"),
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
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.red,
                                  size: 18.sp,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Center(
                                    child: Text(
                                  "${difference.inHours} : ${difference.inMinutes.remainder(60)} : ${difference.inSeconds.remainder(60)}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.sp),
                                )),
                                //Center(child: Text("00:$_start",style: TextStyle(color: Colors.black, fontSize: 16),)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data!.Data![index]!.itmName!,
                                //"boAt Rockerz 510 Super Extra Bass Bluetooth headphone",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11.sp, color: darkThemeBlue),
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
                                        padding: const EdgeInsets.only(
                                            left: 5.0, top: 1),
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
                                  padding:
                                      const EdgeInsets.only(left: 5.0, top: 3),
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
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 8),
                                  child: Text(
                                    " \u20B9 ${snapshot.data!.Data![index]!.iskuOfferPrice!}",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 12.0, top: 8),
                                  child: Text(
                                    " \u20B9 ${snapshot.data!.Data![index]!.iskuMrp!}",
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
                              width: 4.5.h,
                              height: 4.5.h,
                              decoration: const BoxDecoration(
                                  color: const Color.fromRGBO(
                                      202, 85, 44, 1) //(202, 85, 44)
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
                        Positioned(
                          top: 0,
                          //left: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              // _isFavoriteDeals[index]=!_isFavoriteDeals[index];
                              if (_isFavoriteDeals[index] != true) {
                                Map body = {
                                  "wl_cus_id": userId,
                                  "wl_itm_id":
                                      snapshot.data!.Data![index]!.iskuItmId,
                                  "wl_isku_id":
                                      snapshot.data!.Data![index]!.iskuId
                                };
                                _favoriteAddBloc.favoriteAdd(body);
                                _isFavoriteDeals[index] =
                                    !_isFavoriteDeals[index];
                                Fluttertoast.showToast(
                                    msg: "Successfully Added to Wishlist",
                                    fontSize: 14,
                                    backgroundColor: Colors.white,
                                    gravity: ToastGravity.BOTTOM,
                                    textColor: darkThemeBlue,
                                    toastLength: Toast.LENGTH_LONG);
                              }
                              //_isFavorite = !_isFavorite;
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
                                  child: _isFavoriteDeals[index]
                                      ? Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.red,
                                          //Color.fromRGBO(176, 176, 176, 1),
                                          size: 17.sp,
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
                        ),
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.white,
                              child: SizedBox(
                                height: 4.h,
                                width: 4.h,
                                child: Center(
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 15.sp,
                                    color:
                                        const Color.fromRGBO(176, 176, 176, 1),
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
          } else if (snapshot.hasError) {
            print("hello");
            return Container(
              child: const Center(
                  child: Text(
                "No Data ",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                darkThemeOrange,
              ),
            ));
          }
        },
      ),
    );
  }

  Widget topOffer() {
    return SizedBox(
      height: 32.0.h,
      child: FutureBuilder<GetTopOffersModel>(
        future: _getTopOffer,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if(snapshot.data!.Data!.ItemByPrice1 !=null){
            //   itemByPrice.add(snapshot.data!.Data!.ItemByPrice1!.toString());
            //   itemByPrice.add(snapshot.data!.Data!.ItemByPrice2!.toString());
            // }
            return ListView.builder(
              //padding: EdgeInsets.only(top: 8, bottom: 0, left: 4.0.w, right: 4.0.w),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data!.Data!.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.to(() => ProductDetails(
                        itemId:
                            snapshot.data!.Data![index]!.iskuItmId.toString(),
                        iskuOfferPrice: snapshot
                            .data!.Data![index]!.iskuOfferPrice
                            .toString(),
                        iskuMrp:
                            snapshot.data!.Data![index]!.iskuMrp.toString(),
                        iskuId: snapshot.data!.Data![index]!.iskuId.toString(),
                      ));
                },
                child: Card(
                  elevation: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.475,
                    padding: const EdgeInsets.all(1),
                    //margin: EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: FadeInImage(
                              image: NetworkImage(
                                  snapshot.data!.Data![index]!.iskuImage_1!),
                              width: 35.w,
                              height: 18.h,
                              placeholder:
                                  const AssetImage("images/headphone.jpg"),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            snapshot.data!.Data![index]!.itmName!,
                            //"boAt Rockerz 510 Super Extra Bass Bluetooth headphone",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.black),
                          ),
                        ),
                        Text(
                          "From Rs. ${snapshot.data!.Data![index]!.iskuOfferPrice!}",
                          //"boAt Rockerz 510 Super Extra Bass Bluetooth headphone",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.green,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print("hello");
            return Container(
              child: const Center(
                  child: Text(
                "No Data ",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                darkThemeOrange,
              ),
            ));
          }
        },
      ),
    );
  }

  bestseller(Duration difference) {
    return SizedBox(
      height: 42.0.h,
      child: FutureBuilder<GetBestSellerModel>(
        future: _getBestSeller,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if(snapshot.data!.Data!.ItemByPrice1 !=null){
            //   itemByPrice.add(snapshot.data!.Data!.ItemByPrice1!.toString());
            //   itemByPrice.add(snapshot.data!.Data!.ItemByPrice2!.toString());
            // }
            for (int i = 0; i < snapshot.data!.Data!.length; i++) {
              _isFavoriteBest.add(snapshot.data!.Data![i]!.isAddedToWishList!);
            }
            return ListView.builder(
              //padding: EdgeInsets.only(top: 8, bottom: 0, left: 4.0.w, right: 4.0.w),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data!.Data!.length,
              itemBuilder: (context, index) {
                //print("issssssssss ffffffffffffffaaaaaaa $_isFavoriteBest");

                return InkWell(
                  onTap: () {
                    Get.to(() => ProductDetails(
                          itemId:
                              snapshot.data!.Data![index]!.iskuItmId.toString(),
                          iskuOfferPrice: snapshot
                              .data!.Data![index]!.iskuOfferPrice
                              .toString(),
                          iskuMrp:
                              snapshot.data!.Data![index]!.iskuMrp.toString(),
                          iskuId:
                              snapshot.data!.Data![index]!.iskuId.toString(),
                        ));
                  },
                  child: Card(
                    elevation: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.475,
                      padding: const EdgeInsets.all(0),
                      //margin: EdgeInsets.only(left: 8),
                      child: Stack(children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: FadeInImage(
                                  image: NetworkImage(snapshot
                                      .data!.Data![index]!.iskuImage_1!),
                                  width: 35.w,
                                  height: 20.h,
                                  placeholder:
                                      const AssetImage("images/headphone.jpg"),
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
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.red,
                                  size: 18.sp,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Center(
                                    child: Text(
                                  "${difference.inHours} : ${difference.inMinutes.remainder(60)} : ${difference.inSeconds.remainder(60)}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.sp),
                                )),
                                //Center(child: Text("00:$_start",style: TextStyle(color: Colors.black, fontSize: 16),)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data!.Data![index]!.itmName!,
                                //"boAt Rockerz 510 Super Extra Bass Bluetooth headphone",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11.sp, color: darkThemeBlue),
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
                                        padding: const EdgeInsets.only(
                                            left: 5.0, top: 1),
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
                                  padding:
                                      const EdgeInsets.only(left: 5.0, top: 3),
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
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 8),
                                  child: Text(
                                    " \u20B9 ${snapshot.data!.Data![index]!.iskuOfferPrice!}",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 12.0, top: 8),
                                  child: Text(
                                    " \u20B9 ${snapshot.data!.Data![index]!.iskuMrp!}",
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
                              width: 4.5.h,
                              height: 4.5.h,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(
                                      202, 85, 44, 1) //(202, 85, 44)
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
                        Positioned(
                          top: 0,
                          //left: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              if (_isFavoriteBest[index] != true) {
                                Map body = {
                                  "wl_cus_id": userId,
                                  "wl_itm_id":
                                      snapshot.data!.Data![index]!.iskuItmId,
                                  "wl_isku_id":
                                      snapshot.data!.Data![index]!.iskuId
                                };
                                _favoriteAddBloc.favoriteAdd(body);
                                _isFavoriteBest[index] =
                                    !_isFavoriteBest[index];
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
                        ),
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.white,
                              child: SizedBox(
                                height: 4.h,
                                width: 4.h,
                                child: Center(
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 15.sp,
                                    color:
                                        const Color.fromRGBO(176, 176, 176, 1),
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
          } else if (snapshot.hasError) {
            print("hello");
            return Container(
              child: const Center(
                  child: Text(
                "No Data ",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                darkThemeOrange,
              ),
            ));
          }
        },
      ),
    );
  }

  newArrival(Duration difference) {
    return SizedBox(
      height: 42.0.h,
      child: FutureBuilder<NewArrivalModel>(
        future: _getNewArrival,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.Data!.length; i++) {
              _isFavoriteNew.add(snapshot.data!.Data![i]!.isAddedToWishList!);
            }
            return ListView.builder(
              //padding: EdgeInsets.only(top: 8, bottom: 0, left: 4.0.w, right: 4.0.w),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data!.Data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => ProductDetails(
                          itemId:
                              snapshot.data!.Data![index]!.iskuItmId.toString(),
                          iskuOfferPrice: snapshot
                              .data!.Data![index]!.iskuOfferPrice
                              .toString(),
                          iskuMrp:
                              snapshot.data!.Data![index]!.iskuMrp.toString(),
                          iskuId:
                              snapshot.data!.Data![index]!.iskuId.toString(),
                        ));
                  },
                  child: Card(
                    elevation: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.475,
                      padding: const EdgeInsets.all(0),
                      //margin: EdgeInsets.only(left: 8),
                      child: Stack(children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: FadeInImage(
                                  image: NetworkImage(snapshot
                                      .data!.Data![index]!.iskuImage_1!),
                                  width: 35.w,
                                  height: 20.h,
                                  placeholder:
                                      const AssetImage("images/headphone.jpg"),
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
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.red,
                                  size: 18.sp,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Center(
                                    child: Text(
                                  "${difference.inHours} : ${difference.inMinutes.remainder(60)} : ${difference.inSeconds.remainder(60)}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.sp),
                                )),
                                //Center(child: Text("00:$_start",style: TextStyle(color: Colors.black, fontSize: 16),)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data!.Data![index]!.itmName!,
                                //"boAt Rockerz 510 Super Extra Bass Bluetooth headphone",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11.sp, color: darkThemeBlue),
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
                                        padding: const EdgeInsets.only(
                                            left: 5.0, top: 1),
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
                                  padding:
                                      const EdgeInsets.only(left: 5.0, top: 3),
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
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 8),
                                  child: Text(
                                    " \u20B9 ${snapshot.data!.Data![index]!.iskuOfferPrice!}",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 12.0, top: 8),
                                  child: Text(
                                    " \u20B9 ${snapshot.data!.Data![index]!.iskuMrp!}",
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
                              width: 4.5.h,
                              height: 4.5.h,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(
                                      202, 85, 44, 1) //(202, 85, 44)
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
                        Positioned(
                          top: 0,
                          //left: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              if (_isFavoriteNew[index] != true) {
                                _isFavoriteNew[index] = !_isFavoriteNew[index];
                                Map body = {
                                  "wl_cus_id": userId,
                                  "wl_itm_id":
                                      snapshot.data!.Data![index]!.iskuItmId,
                                  "wl_isku_id":
                                      snapshot.data!.Data![index]!.iskuId
                                };
                                _favoriteAddBloc.favoriteAdd(body);
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
                                  child: _isFavoriteNew[index]
                                      ? Icon(
                                          Icons.favorite_rounded,
                                          size: 17.sp,
                                          color: Colors
                                              .red, // Color.fromRGBO(176, 176, 176, 1),
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
                        ),
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.white,
                              child: SizedBox(
                                height: 4.h,
                                width: 4.h,
                                child: Center(
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 15.sp,
                                    color:
                                        const Color.fromRGBO(176, 176, 176, 1),
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
          } else if (snapshot.hasError) {
            print("hello");
            return Container(
              child: const Center(
                  child: Text(
                "No Data ",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                darkThemeOrange,
              ),
            ));
          }
        },
      ),
    );
  }

  recentlyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<GetRecentlyViewedModel>(
          future: _getRecentlyView,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //   for(int i=0; i< snapshot.data!.Data!.length; i++){
              //     _isFavoriteNew.add(snapshot.data!.Data![i]!.isAddedToWishList!);
              //   }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  snapshot.data!.Data != null ? Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 12, top: 8, bottom: 8),
                    child: Text(
                      "Recently Viewed",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          color: Colors.black),
                    ),
                  ): Container(),
                  snapshot.data!.Data != null ? SizedBox(
                    height: 42.0.h,
                    child: ListView.builder(
                      //padding: EdgeInsets.only(top: 8, bottom: 0, left: 4.0.w, right: 4.0.w),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data!.Data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => ProductDetails(
                                  itemId:
                                      snapshot.data!.Data![index]!.itmId.toString(),
                                  iskuOfferPrice: snapshot
                                      .data!.Data![index]!.iskuOfferPrice
                                      .toString(),
                                  iskuMrp: snapshot.data!.Data![index]!.iskuMrp
                                      .toString(),
                                  iskuId: snapshot.data!.Data![index]!.iskuId
                                      .toString(),
                                ));
                          },
                          child: Card(
                            elevation: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.475,
                              padding: const EdgeInsets.all(0),
                              //margin: EdgeInsets.only(left: 8),
                              child: Stack(children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: FadeInImage(
                                          image: NetworkImage(snapshot
                                              .data!.Data![index]!.iskuImage_1!),
                                          width: 35.w,
                                          height: 20.h,
                                          placeholder: const AssetImage(
                                              "images/headphone.jpg"),
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
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: Colors.red,
                                          size: 18.sp,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        // Center(child: Text(
                                        //       "${difference.inHours} : ${difference
                                        //           .inMinutes.remainder(
                                        //           60)} : ${difference.inSeconds
                                        //           .remainder(60)}",
                                        //       style:
                                        //       TextStyle(
                                        //           color: Colors.black, fontSize: 12.sp),
                                        //     )),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data!.Data![index]!.itmName!,
                                        //"boAt Rockerz 510 Super Extra Bass Bluetooth headphone",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11.sp, color: darkThemeBlue),
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
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, top: 1),
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
                                          padding: const EdgeInsets.only(
                                              left: 5.0, top: 3),
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
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8),
                                          child: Text(
                                            " \u20B9 ${snapshot.data!.Data![index]!.iskuOfferPrice!}",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0, top: 8),
                                          child: Text(
                                            " \u20B9 ${snapshot.data!.Data![index]!.iskuMrp!}",
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black,
                                              decoration:
                                                  TextDecoration.lineThrough,
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
                                      width: 4.5.h,
                                      height: 4.5.h,
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(
                                              202, 85, 44, 1) //(202, 85, 44)
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
                                // Positioned(
                                //   top: 0,
                                //   //left: 0,
                                //   right: 0,
                                //   child: InkWell(
                                //     onTap: () {
                                //       if(_isFavoriteRecentView[index] != true) {
                                //         _isFavoriteRecentView[index] = !_isFavoriteRecentView[index];
                                //         Map body = {
                                //           "wl_cus_id": userId,
                                //           "wl_itm_id":
                                //           snapshot.data!.Data![index]!.itmId,
                                //           "wl_isku_id":
                                //           snapshot.data!.Data![index]!.iskuId
                                //         };
                                //         _favoriteAddBloc.favoriteAdd(body);
                                //         Fluttertoast.showToast(
                                //             msg: "Successfully Added to Wishlist",
                                //             fontSize: 14,
                                //             backgroundColor: Colors.white,
                                //             gravity: ToastGravity.BOTTOM,
                                //             textColor: darkThemeBlue,
                                //             toastLength: Toast.LENGTH_LONG);
                                //       }
                                //     },
                                //     child: Card(
                                //       elevation: 10,
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(20),
                                //       ),
                                //       color: Colors.white,
                                //       child: SizedBox(
                                //         height: 4.h,
                                //         width: 4.h,
                                //         child: Center(
                                //           child: _isFavoriteRecentView[index]
                                //               ? Icon(
                                //             Icons.favorite_rounded,
                                //             size: 17.sp,
                                //             color: Colors.red,// Color.fromRGBO(176, 176, 176, 1),
                                //           )
                                //               : Icon(
                                //             Icons.favorite_rounded,
                                //             size: 17.sp,
                                //             color: const Color.fromRGBO(176, 176, 176, 1),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      color: Colors.white,
                                      child: SizedBox(
                                        height: 4.h,
                                        width: 4.h,
                                        child: Center(
                                          child: Icon(
                                            Icons.shopping_cart,
                                            size: 15.sp,
                                            color: const Color.fromRGBO(
                                                176, 176, 176, 1),
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
                    ),
                  )
                      :Container(),
                ],
              );
            } else if (snapshot.hasError) {
              print("hello");
              return Container(
                child: const Center(
                    child: Text(
                  "No Data ",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                )),
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  darkThemeOrange,
                ),
              ));
            }
          },
        ),
      ],
    );
  }
}

final TextStyle productsNameStyleSmall = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontSize: 9.5.sp,
);
