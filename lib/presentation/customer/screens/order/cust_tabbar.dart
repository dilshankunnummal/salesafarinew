import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/Colors.dart';
import 'package:salesafari/core/colors/importedTheme.dart';
import 'package:salesafari/presentation/customer/screens/order/cust_order_cancel.dart';
import 'package:salesafari/presentation/customer/screens/order/cust_order_complete.dart';
import 'package:salesafari/presentation/customer/screens/order/cust_order_pending.dart';

class CustOrderTabBar extends StatefulWidget {
  const CustOrderTabBar({super.key});

  @override
  State<CustOrderTabBar> createState() => _CustOrderTabBarState();
}

class _CustOrderTabBarState extends State<CustOrderTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child:Scaffold(
      backgroundColor: backgroundColor,






      // appBar: AppBar(
      //   elevation: 0,
      //     automaticallyImplyLeading: false,
      //     backgroundColor: Colors.white,
      //     foregroundColor: Colors.black,
      //     // title: const Text(
      //     //   'DirecTrade',
      //     //   style: TextStyle(
      //     //     fontSize: 27,
      //     //   ),
      //     // ),
      //     // actions: [
      //     //   InkWell(
      //     //   onTap: () => {Navigator.pushNamed(context, 'custprofile')},
      //     //   child: const CircleAvatar(
      //     //     radius: 20,
      //     //     backgroundColor: Colors.black,
      //     //     foregroundColor: Colors.white,
      //     //     child: Icon(
      //     //       Icons.person_pin,
      //     //       size: 30,
      //     //     ),
      //     //   ),
      //     // ),
      //     // const SizedBox(
      //     //   width: 10,
      //     // )
      //     // ],
      //   bottom: TabBar(tabs: const [
      //     Tab(
      //       child: Text(
      //         'Pending',
      //         style: TextStyle(color: textColor),
      //       ),
      //     ),
      //     Tab(
      //       child: Text(
      //         'Completed',
      //         style: TextStyle(color: textColor),
      //       ),
      //     ),
      //     Tab(
      //       child: Text(
      //         'Cancelled',
      //         style: TextStyle(color: textColor),
      //       ),
      //     ),
      //   ]),
      // ),
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
                CustOrderPendingPage(),
                CustOrderCompletePage(),
                CustOrderCancelPage()
              ],
            ),
          ),
        ],
      ),
    )
     );

     
  }
}