import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/Colors.dart';
import 'package:salesafari/core/colors/importedTheme.dart';
import 'package:salesafari/presentation/admin/screens/view_users/view_customers.dart';
import 'package:salesafari/presentation/admin/screens/view_users/view_sellers.dart';

class ViewTabBar extends StatelessWidget {
  const ViewTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: Text(
              'Admin Dashboard',
              style: titleTextStyle
            ),
            actions: [
              IconButton(
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, 'adminprofile');
                },
                icon: const Icon(
                  Icons.admin_panel_settings_rounded,
                ),
              ),
            ],
            // ignore: prefer_const_constructors
            bottom:TabBar(tabs: 
             [
              Tab(child: Text('View Sellers',style: facilityTextStyle,),),
              Tab(child: Text('View Customers',style: facilityTextStyle,),),
            ]
            ),
          ),
          body:const TabBarView(
            children: [
              ViewSellersPage(),
              ViewCustPage()
            ]
            ),
      ),
    );
  }
}