import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:topmaybe/constant.dart';

import '../../api_base/api_response.dart';
import '../HomeScreen/home_screen.dart';
import '../customWidgets/TextFormFieldWidget.dart';
import 'SendOtpVerification/OtpVerification/otp_verification_bloc.dart';
import 'SendOtpVerification/OtpVerification/otp_verification_model.dart';
import 'SendOtpVerification/send_otp_bloc.dart';
import 'SendOtpVerification/send_otp_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool isChecked = false;
  final GetOtpBloc _getOtpBloc = GetOtpBloc();
  final OtpVerificationBloc _otpVerificationBloc=OtpVerificationBloc();
  bool _getOtp = false;
  bool otpVer=false;
  late Timer _timer;
  int _start = 45;
  FocusNode _focusNodePhone =  FocusNode();
  bool validatePhone = false;
  bool idfetched = false;
  String? phoneValidator(String? value) {
    //using regex

    // String pattern = "";
    // switch(countyryCode){
    //   case "+91" : pattern = r'^(\+91[\-\s]?)?[0]?(91)?[56789]\d{9}$';
    //   break;
    //   case "+1" : pattern = r'^(\+91[\-\s]?)?[0]?(91)?[56789]\d{9}$';
    //   break;
    //   case "+95" : pattern = r'^(\+91[\-\s]?)?[0]?(91)?[56789]\d{9}$';
    //   break;
    //   case "+91" : pattern = r'^(\+91[\-\s]?)?[0]?(91)?[56789]\d{9}$';
    //   break;
    //   case "+91" : pattern = r'^(\+91[\-\s]?)?[0]?(91)?[56789]\d{9}$';
    //   break;
    //   case "+91" : pattern = r'^(\+91[\-\s]?)?[0]?(91)?[56789]\d{9}$';
    //   break;
    //   default: pattern = "";
    // }

    String pattern = r'^(\+91[\-\s]?)?[0]?(91)?[56789]\d{9}$';
    //Indian Phone Numbers Only
    if (value == null || value.trim().isEmpty) {
      return "Please enter phone number";
    }
    RegExp regex =  RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Please give valid phone number";
    } else {
      return null;
    }

  }
  void whiteSpaceRemoverForPhone(){
    _phoneController.text = _phoneController.text.replaceAll(" ", "");
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    _focusNodePhone.addListener((){
      if(!_focusNodePhone.hasFocus){
        whiteSpaceRemoverForPhone();
      }
    });
  }

  late SharedPreferences prefs;
  Future<void> managedSharedPref(OtpVerificationModel data) async {

    prefs = await SharedPreferences.getInstance();
    prefs.setString("user_phone", "${data.Data!.cusMobile}");
    prefs.setString("coupon_code", "");

    //prefs.setString("cart_id", "${data.cartId}");
    prefs.setString("user_id", "${data.Data!.cusId}");
    prefs.setString("name", "${data.Data!.cusFirstName}");
    prefs.setString("lastname", "${data.Data!.cusLastName}");
    // userName=data.data.n/ame;
    //print("${data.data.name}");
    prefs.setBool("user_login", true);
    prefs.setString("email", "${data.Data!.cusEmail}");
    prefs.setString("profilePic", "${data.Data!.cusProfilePic}");
    prefs.setString("user_token", "${data.Data!.custToken}");
    print(data.Data!.custToken);
    print(prefs.getString("user_token"));
    userLogin = true;

    // var tokenFirebase="";
    // _firebaseMessaging.getToken().then((token) async {
    //   tokenFirebase=token!;
    //   print(token);
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString("device_id",tokenFirebase);
    //   DeviceID=tokenFirebase;
    //   print("sf");
    //   // String? device_id = prefs.getString("device_id");
    //   print(DeviceID);
    // });


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          // padding: EdgeInsets.symmetric(horizontal: 6.0.w),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10.0.h,
            ),
            Center(
              child: Image.asset(
                "images/logo.png",
                height: 20.h,
                alignment: Alignment.centerLeft,
              ),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0.w),
              child: Column(
                ///Column for if client want welcome and login to continue in left site,
                // crossAxisAlignment: CrossAxisAlignment.start, ///remove //
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Login to continue",
                    style: TextStyle(fontSize: 13.sp, color: Colors.black),
                  ),
                  SizedBox(
                    height: 5.5.h,
                  ),
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: _phoneController,
                    focusNode: _focusNodePhone,
                    keyboardType: TextInputType.phone,
                    //inputFormatters: textInputFormatter ?? [],
                    // obscureText: obscureText,
                    // obscuringCharacter: "*",
                    enableInteractiveSelection: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(15),
                        color: darkThemeBlue,
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                      errorText: validatePhone ? phoneValidator(_phoneController.text) : null,
                      prefixIconConstraints: const BoxConstraints(minWidth: 55, minHeight: 48),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      helperStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp,
                      ),
                      errorStyle: TextStyle(
                        color: darkThemeBlue,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp,
                      ),
                      hintText: "Phone",
                      enabled: !idfetched,
                      fillColor: const Color.fromRGBO(242, 242, 242, 1),
                      filled: true,
                      // enabledBorder/: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(5.0),
                      //   borderSide: BorderSide(color: Colors.black38, width: 0.3),
                      // ),
                      border: InputBorder.none,
                    ),
                  ),
                  // TextFormFieldWidget(
                  //     textController: _passwordController,
                  //     prefixIcon: Image.asset("images/lock.png", width: 8, height: 8,fit: BoxFit.contain,),
                  //     hintText: "Password",
                  //     prefixBoxColor: darkThemeBlue,
                  //     obscureText: true,
                  //     textInputAction: TextInputAction.done,
                  //     textInputType: TextInputType.text),
                  SizedBox(
                    height: 0.0.h,
                  ),
                ],
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.only(left: 2.2.w, right: 6.0.w),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         // mainAxisAlignment: MainAxisAlignment.center,
            //         // crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Checkbox(
            //             value: isChecked,
            //             activeColor: darkThemeBlue,
            //             checkColor: Colors.white,
            //             onChanged: (value) {
            //               setState(() {
            //                 isChecked = value!;
            //               });
            //
            //               // if (isChecked) {
            //               //   setRememberance(emailInputController.text,
            //               //       pwdInputController.text);
            //               //   rememberUserLogin = true;
            //               // } else {
            //               //   clearRememberMeData();
            //               // }
            //             },
            //           ),
            //           Text(
            //             "Remember me",
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontWeight: FontWeight.w400,
            //               fontSize: 11.5.sp,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Text(
            //         "Forget Password?",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontWeight: FontWeight.w400,
            //           fontSize: 11.5.sp,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 5.0.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0.w),
              child: RawMaterialButton(
                onPressed: () async {
                  setState(() {
                    _phoneController.text.isEmpty
                        ? validatePhone = true
                        : _phoneController.text.isNotEmpty
                        ? validatePhone = true
                        : validatePhone = false;
                  });
                  if (phoneValidator(_phoneController.text.trim()) == "Please enter phone number") {
                    Fluttertoast.showToast(
                        msg: "Please enter phone number",
                        fontSize: 14,
                        backgroundColor: Colors.white,
                        gravity: ToastGravity.CENTER,
                        textColor: darkThemeBlue,
                        toastLength: Toast.LENGTH_LONG);
                  } else if (phoneValidator(_phoneController.text.trim()) == "Please give valid phone number") {
                    Fluttertoast.showToast(
                        msg: "Please give valid phone number",
                        fontSize: 14,
                        backgroundColor: Colors.white,
                        gravity: ToastGravity.CENTER,
                        textColor: darkThemeBlue,
                        toastLength: Toast.LENGTH_LONG);
                  }else{
                    _getOtp = true;
                    Map body = {
                      "cus_mobile": "${_phoneController.text}",
                    };
                    _getOtpBloc.getOtp(body);
                  }

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
                child: StreamBuilder<ApiResponse<SendOtpModel>>(
                  stream: _getOtpBloc.getOtpStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status) {
                        case Status.LOADING:
                          return const CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  darkThemeOrange));

                          break;
                        case Status.COMPLETED:
                          {
                            //String Otp =snapshot.data!.data!.Data!;
                            // if (kDebugMode) {
                            //   print(Otp);
                            // }
                            // _getOtp=false;
                            if (_getOtp) {
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) {
                                      return AlertDialog(
                                        // title: Text("Give the code?"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: InkWell(
                                                    child: const Icon(
                                                      Icons.cancel,
                                                      color: darkThemeOrange,
                                                    ),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    }),
                                              ),
                                              Column(
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0,
                                                            left: 10),
                                                    child: TextFormField(
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      controller:
                                                          _otpController,
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      //obscuringCharacter: "*",
                                                      enableInteractiveSelection:
                                                          true,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.sp,
                                                      ),
                                                      //textInputAction: TextInputType.phone!,
                                                      decoration:
                                                          const InputDecoration(
                                                              filled: true,
                                                              //fillColor: Colors.blueGrey,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              disabledBorder:
                                                                  InputBorder
                                                                      .none),
                                                      // keyboardType: TextInputType.phone,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.red,
                                              ),
                                              Center(
                                                child: RawMaterialButton(
                                                  onPressed: () {

                                                    userLogin=true;
                                                    otpVer=true;
                                                    Map body ={
                                                      "cus_mobile": "${_phoneController.text}",
                                                      "cus_otp": "${_otpController.text}"
                                                    };
                                                    _otpVerificationBloc.otpVerification(body);
                                                    //
                                                    // if(snapshot.data!.data.Data == _otpController.text){
                                                    //   userLogin=true;
                                                    //   otpVer=true;
                                                    //   Map body ={
                                                    //     "cus_mobile": "${_phoneController.text}",
                                                    //     "cus_otp": "${snapshot.data!.data.Data}"
                                                    //   };
                                                    //   _otpVerificationBloc.otpVerification(body);
                                                    //
                                                    // }else{
                                                    //   Fluttertoast.showToast(
                                                    //       msg: "Incorrect OTP",
                                                    //       fontSize: 14,
                                                    //       backgroundColor: Colors.white,
                                                    //       gravity: ToastGravity.CENTER,
                                                    //       textColor: darkThemeBlue,
                                                    //       toastLength: Toast.LENGTH_LONG);
                                                    // }
                                                  },
                                                  child: StreamBuilder<ApiResponse<OtpVerificationModel>>(
                                                    stream: _otpVerificationBloc.otpVerificationStream,
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
                                                              //managedSharedPref(snapshot2.data!.data);
                                                              if (otpVer) {

                                                                if(snapshot2.data!.data.Code != 0){
                                                                  managedSharedPref(snapshot2.data!.data);
                                                                  Future.delayed(Duration.zero, () {
                                                                    Get.offAll(() => const HomeScreen());

                                                                  });

                                                                }else{
                                                                  Fluttertoast.showToast(
                                                                      msg: "Incorrect OTP",
                                                                      fontSize: 14,
                                                                      backgroundColor: Colors.white,
                                                                      gravity: ToastGravity.CENTER,
                                                                      textColor: darkThemeBlue,
                                                                      toastLength: Toast.LENGTH_LONG);
                                                                }


                                                              }
                                                              otpVer = false;

                                                            }
                                                            break;
                                                          case Status.ERROR:
                                                            if (kDebugMode) {
                                                              print(snapshot.error);
                                                              Fluttertoast.showToast(
                                                                  msg: "Incorrect OTP",
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
                                                      return Ink(
                                                        //padding: padding,
                                                        height: 5.5.h,
                                                        decoration: const BoxDecoration(
                                                            gradient: LinearGradient(
                                                                begin: Alignment
                                                                    .centerLeft,
                                                                end: Alignment
                                                                    .centerRight,
                                                                colors: [
                                                                  darkThemeBlue,
                                                                  darkThemeBlue
                                                                ])),
                                                        child: Center(
                                                          child: Text(
                                                            "Continue",
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 13.sp,
                                                            ),
                                                            textAlign:
                                                            TextAlign.center,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),

                                                ),
                                              ),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              // Center(child: Text("00:$_start",style: const TextStyle(color: darkThemeOrange, fontSize: 16),)),
                                              InkWell(
                                                onTap: () {
                                                  _getOtp = true;
                                                  Map body = {
                                                    "cus_mobile": _phoneController.text,
                                                  };
                                                  _getOtpBloc.getOtp(body);

                                                },
                                                child: Container(
                                                  margin:  EdgeInsets.only(top: 3.h,),
                                                  // alignment: Alignment.center,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children:  [
                                                      Text(
                                                        "Didn't receive otp code?",
                                                        style: TextStyle(color: Colors.black, fontSize: 10.sp),
                                                      ),
                                                      Text(
                                                        " Resend OTP  ",
                                                        style: TextStyle(color: darkThemeOrange, fontSize: 10.sp),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              });
                              Fluttertoast.showToast(
                                  msg: "OTP send Successfully",
                                  fontSize: 14,
                                  backgroundColor: Colors.white,
                                  textColor: darkThemeBlue,
                                  toastLength: Toast.LENGTH_LONG);
                            }
                            _getOtp = false;

                          }
                          break;
                        case Status.ERROR:
                          if (kDebugMode) {
                            print(snapshot.error);
                            //   Error(
                            //   errorMessage: snapshot.data.message,
                            // );

                          }
                          break;
                      }
                    } else if (snapshot.hasError) {
                      print("error");
                    }
                    return Ink(
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
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15.0.h,
            ),
            // InkWell(
            //   onTap: () {
            //     // Get.to(() => EnterNumber());
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.only(bottom: 10, right: 6.0.w, left: 6.0.w),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       children: [
            //         Text(
            //           "Don't have an account? ",
            //           style: TextStyle(color: Colors.black, fontSize: 14.sp),
            //         ),
            //         Text(
            //           "Sign Up",
            //           style: TextStyle(color: darkThemeBlue, fontSize: 14.sp),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                Get.to(() => const HomeScreen());
              },
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: 10, right: 6.0.w, left: 6.0.w, top: 5),
                child: Center(
                  child: Container(
                    width: 20.w,
                    height: 4.5.h,
                    color: Colors.blue[100],
                    child: Center(
                      child: Text(
                        "Skip ",
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
