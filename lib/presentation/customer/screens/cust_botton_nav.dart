import 'package:flutter/material.dart';
import 'package:salesafari/presentation/chat/chat_list.dart';
import 'package:salesafari/presentation/customer/screens/homepage/customer_home.dart';
import 'package:salesafari/presentation/customer/screens/order/cust_tabbar.dart';
import 'package:salesafari/presentation/customer/screens/search_catergory/search_category.dart';
import 'package:salesafari/presentation/customer/screens/user%20profile/customer_profile.dart';
// import 'package:sample_project/screens/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = [
    CustHomePage(),
    const SearchAndCategoryPage(),
    const CustOrderTabBar(),
    CustProfilePage(),

  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,

          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          items:  [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: (selectedIndex==0)?30:25),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_mall_outlined, size: (selectedIndex==1)?30:25),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: (selectedIndex==2)?30:25),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded, size: (selectedIndex==3)?30:25),
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
