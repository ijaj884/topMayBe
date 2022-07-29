import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:topmaybe/constant.dart';

import '../CartPage/GetCart/get_cart_model.dart';
import '../CartPage/GetCart/get_cart_repository.dart';
import '../CartPage/cart_page.dart';
class CartIconWidget extends StatefulWidget {
  const CartIconWidget({Key? key}) : super(key: key);

  @override
  _CartIconWidgetState createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> {
  Future<GetCartModel>? _getCart;
  late GetCartRepository _getCartRepository;

  // ignore: non_constant_identifier_names
  String cart_id = "";
  // ignore: non_constant_identifier_names
  String user_id = "";
  // ignore: non_constant_identifier_names
  String coupon_code = "";
  String vendorLat="";
  String vendorLong="";
  late SharedPreferences prefs;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    // print("cartId at Cart page1" + prefs.getString("cart_id"));
    cart_id = prefs.getString("cart_id")!;
    user_id = prefs.getString("user_id")!;
    coupon_code = prefs.getString("coupon_code")!;
    _getCartRepository =GetCartRepository();
    Map body={};
    _getCart=_getCartRepository.getCart(body, user_id);
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
   // _cartRepository = new CartRepository();
    createSharedPref();

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(() => const CartPage());
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
           Padding(
             padding: const EdgeInsets.only(top: 14.0,right: 8.0,left: 8.0),
             child: Icon(
                Icons.shopping_cart,
                color: darkThemeBlue,
                size: 18.sp,
              ),
           ),

          //Image.asset(cartIcon,width: 20,height: 20),
          FutureBuilder<GetCartModel>(
            future: _getCart,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.Data!.itemListModels!.isNotEmpty) {
                  return Positioned(
                    right: 0,
                    top: 2,
                    child: CircleAvatar(
                      radius: 8.5,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 7.5,
                        backgroundColor: darkThemeOrange,
                        child: Text('${snapshot.data!.Data!.itemListModels!.length}', style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  );
                } else {
                  return const Text(
                    "",
                  );
                }
              } else if (snapshot.hasError) {
                return const Text("");
              } else {
                return const Center(
                  heightFactor: 0,
                  widthFactor: 0,
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                );
              }
            },
          ),

        ],
      ),
    );
  }
// cartPosition() {
//
//   if(cartCount==""){
//     return Text("");
//
//   }else {
//     return Positioned(
//       left: 12,
//       bottom: 11,
//       child: CircleAvatar(
//         radius: 8.5,
//         backgroundColor: Colors.black,
//         child: CircleAvatar(
//           radius: 7.5,
//           backgroundColor: themeRedColor,
//           child: Text('$cartCount', style: TextStyle(
//               fontSize: 12.0,
//               color: Colors.white
//           ),),
//         ),
//       ),
//     );
//   }
// }
}

