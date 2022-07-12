//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/HomeScreen/home_screen.dart';
import 'Screens/Login/login_page.dart';
import 'constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
   final SharedPreferences prefs = await SharedPreferences.getInstance();
  Set keys = prefs.getKeys();
  if (keys.contains("user_token")) {
    // print("token exist" + prefs.getString("token"));
    if (prefs.getString("user_token") != "" && prefs.getString("user_token") != null) {
      // userLogin=prefs.getBool("user_login");
      print("login");
      userLogin = true;
    }else{
      userLogin=false;
      print("Not login");

    }
  } else{
    prefs.setString("user_token", "");
    print("Not login");
    userLogin=false;
  }
  //*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        title: 'Topmaybe',
        getPages: [
          // GetPage(name: "/login", page: () => LoginPage()),
          // GetPage(name: "/enterNumber", page: () => EnterNumber()),
          // GetPage(name: "/registration", page: () => RegistrationPage()),
          // GetPage(name: "/homeController", page: () => HomeController()),
          GetPage(name: "/home", page: () => const HomeScreen()),
        ],

        home:  userLogin ? const HomeScreen():const LoginPage(),
      );
    });
  }
}
