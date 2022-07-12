//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:narapaper_user/NewUserProfile/NewUserProfile.dart';
// import 'package:narapaper_user/api_base/api_response.dart';
// import 'package:narapaper_user/constants/color.dart';
// import 'package:narapaper_user/constants/imageAssets.dart';
// import 'package:narapaper_user/constants/textStyle.dart';
// import 'package:narapaper_user/homeController/homeController.dart';
// import 'package:narapaper_user/homeScreen/homeScreen.dart';
// import 'package:pinput/pin_put/pin_put.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
// //import 'package:otp_count_down/otp_count_down.dart';
// import 'LoginWithPhone/LoginWithPhoneBloc.dart';
// import 'LoginWithPhone/LoginWithPhoneModel.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';
//
//
// class OTPScreen extends StatefulWidget {
//   final String phone;
//   final String c;
//   OTPScreen(this.phone, this.c);
//   @override
//   _OTPScreenState createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> {
//
//
//
//   late SharedPreferences prefs;
//
//   late Timer _timer;
//   int _start = 45;
//
//
//   void startTimer() {
//     const oneSec = const Duration(seconds: 1);
//     _timer = new Timer.periodic(
//       oneSec,
//           (Timer timer) {
//         if (_start == 0) {
//           setState(() {
//             timer.cancel();
//           });
//         } else {
//           setState(() {
//             _start--;
//           });
//         }
//       },
//     );
//   }
//   String DeviceID="";
//
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   // Future<void> createSharedPref() async {
//   //   prefs = await SharedPreferences.getInstance();
//   //   prefs.setString("phone",widget.phone.toString());
//   //
//   // }
//
//   Future<void> managedSharedPref(LoginModel data) async {
//
//     prefs = await SharedPreferences.getInstance();
//     prefs.setString("user_phone",widget.phone.toString());
//     prefs.setString("coupon_code", "");
//
//     prefs.setString("cart_id", "${data.cartId}");
//     print("cart id at login : ${data.cartId}");
//     prefs.setString("user_id", "${data.data?.id}");
//     prefs.setString("name", "${data.data?.name}");
//     // userName=data.data.n/ame;
//     //print("${data.data.name}");
//     prefs.setBool("user_login", true);
//     prefs.setString("email", "${data.data?.email}");
//     prefs.setString("profilePic", "${data.data?.profilePic}");
//     prefs.setString("user_token", "${data.success?.token}");
//     print(data.success?.token);
//     print(prefs.getString("user_token"));
//     userLogin = true;
//
//     var tokenFirebase="";
//     _firebaseMessaging.getToken().then((token) async {
//       tokenFirebase=token!;
//       print(token);
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setString("device_id",tokenFirebase);
//       DeviceID=tokenFirebase;
//       print("sf");
//      // String? device_id = prefs.getString("device_id");
//       print(DeviceID);
//     });
//
//
//   }
//   LoginWithPhoneBloc _addMobileBloc=LoginWithPhoneBloc();
//   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
//   late String _verificationCode;
//   final TextEditingController _pinPutController = TextEditingController();
//   final FocusNode _pinPutFocusNode = FocusNode();
//   final BoxDecoration pinPutDecoration = BoxDecoration(
//     color:  themeRedColor,
//     borderRadius: BorderRadius.circular(5.0),
//     border: Border.all(color:themeRedColor),
//   );
//   @override
//   Widget build(BuildContext context) {
//     final scH = MediaQuery.of(context).size.height;
//     final scW = MediaQuery.of(context).size.width;
//     return Scaffold(
//
//       key: _scaffoldkey,
//
//       backgroundColor: Colors.white,
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(backgroundImageFull),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: ListView(
//           physics: ScrollPhysics(),
//           shrinkWrap: true,
//           children: [
//
//
//             StreamBuilder<ApiResponse<LoginModel>>(
//                 stream: _addMobileBloc.userLoginStream,
//                 builder: (context, snapshot2) {
//                   if (snapshot2.hasData) {
//                     switch (snapshot2.data?.status) {
//                       case Status.LOADING:
//                         print("Loading");
//                         // print(snapshot);
//                         // return CircularProgressIndicator(
//                         //   valueColor: new AlwaysStoppedAnimation<Color>(
//                         //     Color.fromRGBO(255, 241, 232, 1),
//                         //   ),
//                         // );
//                         break;
//                       case Status.COMPLETED:
//                         print("Number Added");
//                         managedSharedPref(snapshot2.data!.data);
//                         Future.delayed(Duration(seconds: 1),()
//                         async {
//                           if(snapshot2.data!.data.data!.name==null){
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => NewUserProfile()));
//                           }else{
//                             Navigator.pushAndRemoveUntil(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => HomeController()),
//                                     (route) => false);
//                           }
//
//                         }
//                         );
//                         break;
//                       case Status.ERROR:
//                         print("Number not added-- error--${snapshot2.data!.message}");
//                         break;
//                     }
//                   }
//                   return Container();
//                 }
//             ),
//             SizedBox(
//               height: (11.0.h - 38),
//             ),
//             Image.asset(
//               appLogo,
//               height: 40,
//               alignment: Alignment.centerLeft,
//             ),
//             Container(
//               margin: EdgeInsets.only(top: scH* 0.12,left: scW*0.05),
//               child: Text(
//                 "Verification Code",
//                 style: TextStyle(color: Colors.black, fontSize: scH * 0.035),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: scH* .008,left: scW*0.05),
//               child: Text(
//                 "Please enter verification code sent to your mobile",
//                 style:TextStyle(
//                     color: Colors.grey, fontSize: scH * 0.02),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: scH* .008,left: scW*0.05),
//               child: Text(
//                 'number $countryCode ${widget.phone}',
//                 style: TextStyle(color: Colors.grey, fontSize: scH * 0.02),
//               ),
//             ),
//
//             Padding(
//               padding: EdgeInsets.only(left: scW* .07, right: scW * .07,top: scH*0.05),
//               child: PinPut(
//                 fieldsCount: 6,
//                 textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
//                 eachFieldWidth: 45.0,
//                 eachFieldHeight: 50.0,
//                 focusNode: _pinPutFocusNode,
//                 controller: _pinPutController,
//                 submittedFieldDecoration: pinPutDecoration,
//                 selectedFieldDecoration: pinPutDecoration,
//                 followingFieldDecoration: pinPutDecoration,
//                 pinAnimationType: PinAnimationType.fade,
//                 onSubmit: (pin) async {
//                   try {
//                     await FirebaseAuth.instance
//                         .signInWithCredential(PhoneAuthProvider.credential(
//                         verificationId: _verificationCode, smsCode: pin))
//                         .then((value) async {
//                       if (value.user != null) {
//                         print(value.user);
//                         Map body = {
//                           "mobile_number":"$countryCode${widget.phone}",
//                           "deviceid":"$DeviceID",
//                         };
//                         _addMobileBloc.userLogin(body);
//
//                         // Navigator.pushAndRemoveUntil(
//                         //     context,
//                         //     MaterialPageRoute(builder: (context) => HomeController()),
//                         //     (route) => false);
//                       }
//                     });
//                   } catch (e) {
//                     FocusScope.of(context).unfocus();
//                     _scaffoldkey.currentState!
//                         .showSnackBar(SnackBar(content: Text('invalid OTP')));
//                   }
//                 },
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 _verifyPhone();
//               },
//               child: Container(
//                 margin: EdgeInsets.only(top: scH*0.05,),
//                 // alignment: Alignment.center,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Didn't receive otp code?",
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                     ),
//                     Text(
//                       " Resend OTP  ",
//                       style: TextStyle(color: themeOrangeColor, fontSize: 16),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Center(child: Text("00:$_start",style: TextStyle(color: themeGreenColor, fontSize: 16),)),
//             // (_countDown=="00:00")?
//             // RichText(
//             //   textAlign: TextAlign.center,
//             //   text: TextSpan(
//             //       text: "Didn't receive the code? ",
//             //       style: TextStyle(color: Colors.white70, fontSize: scW*0.037),
//             //       children: [
//             //         TextSpan(
//             //             text: " RESEND",
//             //             recognizer: onTapRecognizer,
//             //             style: TextStyle(
//             //                 color: themeOrangeColor,
//             //                 fontWeight: FontWeight.w400,
//             //                 fontSize: scW*0.037))
//             //       ]),
//             // )
//             //     :
//             // RichText(
//             //   textAlign: TextAlign.center,
//             //   text: TextSpan(
//             //       text: "OTP Verified In ",
//             //       style: TextStyle(color: Colors.white70, fontSize: scW*0.037),
//             //       children: [
//             //         TextSpan(
//             //             text: "$_countDown",
//             //             style: TextStyle(
//             //                 color: themeOrangeColor,
//             //                 fontWeight: FontWeight.w400,
//             //                 fontSize: scW*0.037))
//             //       ]),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _verifyPhone() async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: '$countryCode${widget.phone}',
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
//             if (value.user != null) {
//               Map body = {
//                 "mobile_number":"$countryCode${widget.phone}",
//                 "deviceid":"$DeviceID",
//               };
//               _addMobileBloc.userLogin(body);
//               // Navigator.pushAndRemoveUntil(
//               //     context,
//               //     MaterialPageRoute(builder: (context) => HomeController()),
//               //     (route) => false);
//             }
//           });
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           print(e.message);
//         },
//         codeSent: (String verificationID, int? resendToken) {
//           setState(() {
//             _verificationCode = verificationID;
//           });
//         },
//         codeAutoRetrievalTimeout: (String verificationID) {
//           setState(() {
//             _verificationCode = verificationID;
//           });
//         },
//         timeout: Duration(seconds: 120));
//   }
//   var onTapRecognizer;
//   //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   final int _otpTimeInMS = 1000 * 1 * 30;  // time in milliseconds for count down
//   String _countDown="00:30";
//   //late OTPCountDown _otpCountDown;
//   late FirebaseAuth _auth;
//   String ? countryCode;
//
//
//
//   // void _startCountDown() {
//   //   _otpCountDown = OTPCountDown.startOTPTimer(
//   //     timeInMS: _otpTimeInMS,
//   //     currentCountDown: (String countDown) {
//   //       _countDown = countDown;
//   //       setState(() {});
//   //     },
//   //     onFinish: () {
//   //       print("Count down finished!");
//   //     },
//   //   );
//   // }
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if(widget.c==""){
//       countryCode="+1";
//     }else{
//       countryCode=widget.c;
//     }
//     _verifyPhone();
//     startTimer();
//     //_startCountDown();
//     // onTapRecognizer = TapGestureRecognizer()
//     //   ..onTap = () {
//     //     //_startCountDown();
//     //     _verifyPhone();
//     //   };
//     //createSharedPref();
//   }
// }
