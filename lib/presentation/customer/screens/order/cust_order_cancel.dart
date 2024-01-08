import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salesafari/presentation/customer/screens/order/widgets/cust_order_card.dart';

class CustOrderCancelPage extends StatelessWidget {
  const CustOrderCancelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Orders")
          .where('customer_id', isEqualTo: user?.uid)
          .where('status', isEqualTo: 'c')
          .orderBy('datetime', descending: true)
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
              return Container(
                //padding: EdgeInsets.all(10),
                child: ListView.builder(
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
                                SizedBox(height: 10,),
                                CustOrderCard(
                                    orderdoc: orderdoc, productdoc: productdoc),
                              ],
                            );
                          });
                    }),
              );
            } else {
              return Center(
                child: Lottie.asset('assets/lottie/empty_box.json',
                    width: size.width * .75),
              );
            }
        }
      },
    );
  }
}
