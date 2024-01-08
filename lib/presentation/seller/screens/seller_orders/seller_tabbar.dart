import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:salesafari/core/colors/Colors.dart';
import 'package:salesafari/presentation/seller/screens/seller_orders/seller_cancelled_order.dart';
import 'package:salesafari/presentation/seller/screens/seller_orders/seller_complete_orders.dart';
import 'package:salesafari/presentation/seller/screens/seller_orders/seller_pending_orders.dart';

import '../../../../core/colors/importedTheme.dart';

class SellerOrderTabBar extends StatefulWidget {
  const SellerOrderTabBar({super.key});

  @override
  State<SellerOrderTabBar> createState() => Seller_OrderTabBarState();
}

class Seller_OrderTabBarState extends State<SellerOrderTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child:Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 2, 20, 2),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(

                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //SizedBox(width: ,),
                      InkWell(
                        onTap: () => {Navigator.pushNamed(context, 'chatlistpage')},
                        child: Icon(
                          Icons.chat,
                          size: 30,
                        ),
                      ),
                      Spacer(),
                      Image.asset('assets/images/salesafaritext.png', width: 120,),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey.withOpacity(0.1),
            child: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'Pending',
                      style: facilityTextStyle,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Completed',
                      style: facilityTextStyle,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Cancelled',
                      style: facilityTextStyle,
                    ),
                  ),
                ]),
          ),
          Expanded(
            child: TabBarView(
              children: [
                SellerOrderPending(),
                SellerOrderComplete(),
                SellerOrderCancelled()
              ],
            ),
          ),
        ],
      ),
    )
     );

     
  }
}
