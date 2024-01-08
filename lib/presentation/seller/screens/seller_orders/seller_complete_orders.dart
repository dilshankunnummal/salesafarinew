
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salesafari/presentation/seller/screens/seller_orders/widgets/seller_order_card.dart';


class SellerOrderComplete extends StatelessWidget {
  SellerOrderComplete({super.key});
  final user=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
        final size=MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Orders')
          .where('seller_id', isEqualTo: user?.uid )
          .orderBy('datetime',descending: true)
          .where('status',whereIn: ['s','r'])
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          default:
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot orderdoc = snapshot.data!.docs[index];
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Products')
                            .doc(orderdoc['product_id'])
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.blue),
                            );
                          }
                          if (!snapshot.hasData) {
                            return Text('Document does not exist');
                          }
                          // Extract data from the snapshot and display it
                          final productdoc = snapshot.data!;

                          return Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              SellerOrderCard(orderdoc: orderdoc,productdoc: productdoc,),
                            ],
                          );
                        });
                  });
            } else {
              return Center(
                child: Lottie.asset('assets/lottie/empty_box.json',width:size.width*.75),
              );
            }
        }
      },
    );  
    // ListView.builder(
    //       itemBuilder: (context, index) => const Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: SellerOrderCard(),
    //       ), itemCount: orders.length );
  }
}