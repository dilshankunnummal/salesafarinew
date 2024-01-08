import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:salesafari/presentation/chat/chat_list.dart';
import 'package:salesafari/presentation/seller/screens/seller_orders/seller_tabbar.dart';
import 'package:salesafari/presentation/seller/screens/seller_products/seller_product.dart';
import 'package:salesafari/presentation/seller/screens/seller_profile/seller_prof.dart';

class SellerHomePage extends StatefulWidget {
  const SellerHomePage({super.key});

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  final pages = [
    const SellerProductPage(),
    SellerOrderTabBar(),
    SellerProfilePage()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.lightBlue,
          type: BottomNavigationBarType.fixed,
          items:  [
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.boxes, size: 25),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_outlined, size: 25),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded, size: 25),
              label: '',
            )
          ],
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
