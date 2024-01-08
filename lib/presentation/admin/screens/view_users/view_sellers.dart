// import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:salesafari/presentation/admin/screens/view_users/widgets/seller_card.dart';

var user = FirebaseAuth.instance.currentUser;

class ViewSellersPage extends StatelessWidget {
  const ViewSellersPage({super.key});

  @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemBuilder: (context, index) => const WaitingCard(),
//       itemCount: 2000,
//     );
//   }
// }

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .where('userType', isEqualTo: 's')
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
              return Padding(
                padding: const EdgeInsets.only(
                    bottom: 15, left: 10, right: 10, top: 15),
                child: ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      return SellerCard(
                        passingdocument: document,
                      );
                    }),
              );
            } else {
              return Center(
                child: const Text(
                  'empty',
                ),
              );
            }
        }
      },
    );
  }
}
