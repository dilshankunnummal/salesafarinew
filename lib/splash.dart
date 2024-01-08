import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salesafari/presentation/admin/screens/admin_home.dart';
import 'package:salesafari/presentation/authentication/login.dart';
import 'package:salesafari/presentation/customer/screens/cust_botton_nav.dart';
import 'package:salesafari/presentation/seller/screens/seller_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      navigateUser();
    }

        // ()=>Navigator.pushReplacement(context,
        // MaterialPageRoute(builder:
        //     (context) => LoginPage()
        // )
        //  )
        );
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var type = prefs.getString('type');
    print(type);
    if (type==null) {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    } else if (type == 'customer') {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    } else if (type == 'seller') {
      Navigator.pushReplacement(
          context,MaterialPageRoute(builder: (BuildContext context) => SellerHomePage()));
    }else if(type=='admin'){
       Navigator.pushReplacement(context,  MaterialPageRoute(builder: (BuildContext context) => AdminHomePage()));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/splashIcon.png'),
          Lottie.asset('assets/lottie/loadig_screen.json',width:60)
        ],
      ),
    );
  }
}
