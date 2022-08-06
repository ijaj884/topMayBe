
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../CartPage/cart_page.dart';
import '../HomeScreen/GetBannerforHomePage/get_banner2_model.dart';
import '../HomeScreen/GetBannerforHomePage/get_bannerfor_homepage_repository.dart';
import '../Product/product.dart';
import '../Product/product_model.dart';
import '../Product/product_repository.dart';
import 'get_all_active_sub_by_main_model.dart';
import 'get_all_active_sub_by_main_repository.dart';
// ignore: must_be_immutable
class ProductByCategory extends StatefulWidget{
  final String categoryName;
  final String categoryId;
  const ProductByCategory({Key? key, required this.categoryName, required this.categoryId}) : super(key: key);

  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  //String categoryid;

  //_ProductByCategoryState(this.categoryid);

   Future<GetAllActiveSubByMainModel>? _getSubMainCategory;
  late GetAllActiveSubByMainRepository _getAllActiveSubByMainRepository;

   Future<GetBanner2Model>? _getBanner2;//
   late GetBannerforHomePageRepository _getBannerforHomePageRepository;

   Future<void> createSharedPref() async {

     _getAllActiveSubByMainRepository=GetAllActiveSubByMainRepository();
     Map body = {};
     _getSubMainCategory = _getAllActiveSubByMainRepository.getSubCategory(body, widget.categoryId);
     _getBannerforHomePageRepository=GetBannerforHomePageRepository();
     //_body = {};
     _getBanner2=_getBannerforHomePageRepository.getBanner2(body);

     setState(() {});
   }
   String wistList="";
   List<String> bannerImagesAPI2 = [];

  @override
  void initState() {
    super.initState();
    createSharedPref();

  }



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
        title: Text(widget.categoryName,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500)),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
              padding:  EdgeInsets.only(left: 12.0,bottom: 12.0,right: 12.0,top: 3.h),
              child: FutureBuilder<GetAllActiveSubByMainModel>(
                future: _getSubMainCategory,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        // ListView.builder(
                        //     scrollDirection: Axis.vertical,
                        //     shrinkWrap: true,
                        //     itemCount: snapshot.data!.Data!.length,
                        //     itemBuilder: (BuildContext ctxt, int index){
                        //
                        //       return InkWell(
                        //                 onTap: () {
                        //                   Get.to(() => Product(categoryName: snapshot.data!.Data![index]!.catName!,
                        //                     categoryId: snapshot.data!.Data![index]!.catId.toString(),
                        //                   ));
                        //                 },
                        //
                        //               child: Card(
                        //                   elevation: 3,
                        //                   shadowColor: Colors.red,
                        //                   shape: RoundedRectangleBorder(
                        //                     borderRadius: BorderRadius.circular(10.0),
                        //                   ),
                        //                   child: Row(
                        //                     children: [
                        //                       Container(
                        //                         margin: const EdgeInsets.all(8.0),
                        //                         height: 65.0,
                        //                         width: 65.0,
                        //
                        //                         decoration: const BoxDecoration(
                        //                           borderRadius: BorderRadius.only(
                        //                               topLeft: Radius.circular(10.0),
                        //                               topRight: Radius.circular(10.0),
                        //                               bottomLeft: Radius.circular(10.0),
                        //                               bottomRight: Radius.circular(
                        //                                   10.0)),
                        //
                        //                         ),
                        //                         child: FadeInImage(
                        //                           image: NetworkImage(
                        //                             snapshot.data!.Data![index]!.catImage!,
                        //                           ),
                        //                           placeholder: const AssetImage("images/categoryimage.png"),
                        //                           fit: BoxFit.fill,
                        //                         ),
                        //                       ),
                        //
                        //                       Expanded(
                        //                         // flex: 3,
                        //                         child: Padding(
                        //                           padding: const EdgeInsets.fromLTRB(
                        //                               10.0, 5.0, 5.0, 5.0),
                        //                           child: Column(
                        //                             crossAxisAlignment: CrossAxisAlignment
                        //                                 .start,
                        //                             children: [
                        //                               Text(
                        //                                 snapshot.data!.Data![index]!.catName!,
                        //                                 style: const TextStyle(
                        //                                     color: Colors.black,
                        //                                     fontSize: 16.0,
                        //                                     fontWeight: FontWeight.bold),
                        //                               ),
                        //
                        //                               // Text(
                        //                               //   snapshot.data.data[index].vendor[index1].address ,
                        //                               //   style: new TextStyle(
                        //                               //       color: Colors.black,
                        //                               //       fontSize: 14.0),
                        //                               // ),
                        //
                        //                             ],),
                        //                         ),
                        //                       )
                        //                     ]
                        //                     ,
                        //                   )
                        //               )
                        //               ,
                        //             );
                        //
                        //     }),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 3.0,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height / 1.37),

                          ),
                          itemCount: snapshot.data!.Data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                _modalBottomSheetMenu(snapshot.data!.Data![index]!.catName!,snapshot.data!.Data![index]!.catId.toString());

                              },

                              child: Card(
                                  elevation: 0,
                                  //shadowColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(8.0),
                                        height: 65.0,
                                        width: 75.0,

                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                        child: FadeInImage(
                                          image: NetworkImage(
                                            snapshot.data!.Data![index]!.catImage!,
                                          ),
                                          placeholder: const AssetImage("images/categoryimage.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10.0, 5.0, 5.0, 5.0),
                                        child: Text(
                                          snapshot.data!.Data![index]!.catName!,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style:  TextStyle(
                                              color: Colors.black,
                                              fontSize: 9.0.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ]
                                    ,
                                  )
                              )
                              ,
                            );
                          },
                        ),
                      ],
                    );
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

              )

          ),
          SizedBox(height: 3.h,),
          bannerSlider2(),


        ],
      ),
    );
  }
   Widget bannerSlider2() {
     return FutureBuilder<GetBanner2Model>(
       future: _getBanner2,
       builder: (context, snapshot) {
         if (snapshot.hasData) {
           for(int i=0;i<snapshot.data!.Data!.length;i++){
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
                   style: TextStyle(
                       fontSize: 17, fontWeight: FontWeight.bold),
                 )),
           );
         } else {
           return const Center(child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation<Color>(
             darkThemeOrange,
           ),));
         }
       },
     );
   }
   void _modalBottomSheetMenu(String catName, String catId){
     showModalBottomSheet(
         context: context,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(5.0),
         ),
         backgroundColor: Colors.white,
         elevation: 2,
         isScrollControlled: true,

         //barrierColor: Colors.blue.withOpacity(0),
         builder: (builder){
           return  ChildCat(catName: catName,catId: catId,);
         }
     );
   }
}
class ChildCat extends StatefulWidget {
  final String catName;
  final String catId;
  const ChildCat({Key? key, required this.catName, required this.catId}) : super(key: key);

  @override
  _ChildCatState createState() => _ChildCatState();
}

class _ChildCatState extends State<ChildCat> {

  Future<ProductModel>? _getChildCategory;
  late GetAllActiveChildBySubRepository _getAllActiveChildBySubRepository;

  Future<void> createSharedPref() async {

    _getAllActiveChildBySubRepository=GetAllActiveChildBySubRepository();
    Map body = {};
    _getChildCategory = _getAllActiveChildBySubRepository.getChildCategory(body, widget.catId);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text("jii"),
        // ),
        body: Container(
          //height: 10.h,
          decoration:  const BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0))),
          child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: 5.h,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(

                children: [
                  SizedBox(width: 3.w,),
                  Text(widget.catName,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: (){
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

            ),
            FutureBuilder<ProductModel>(
              future: _getChildCategory,
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return GridView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.87),
                    ),
                    itemCount: snapshot.data!.Data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => Product(categoryName: snapshot.data!.Data![index]!.catName!,
                            categoryId: snapshot.data!.Data![index]!.catId.toString(),
                          ));
                        },
                        child: Card(
                          elevation: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.475,
                            //color: Colors.red,
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                  Center(
                                    child: FadeInImage(
                                      image: NetworkImage(
                                          snapshot.data!.Data![index]!.catImage!),
                                      width: 35.w,
                                      height: 15.h,
                                      placeholder: const AssetImage("images/headphone.jpg"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.1.h,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data!.Data![index]!.catName!,
                                    //"boAt Rockerz 510 Super Extra Bass Bluetooth headphone",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 11.sp, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
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
        ),
      ),
    );
  }
}




