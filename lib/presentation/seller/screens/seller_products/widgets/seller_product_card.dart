import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/importedTheme.dart';
import 'package:salesafari/presentation/seller/screens/seller_products/widgets/seller_product_view.dart';
import 'package:salesafari/presentation/user_model.dart';

class SellerProductCard extends StatelessWidget {
  SellerProductCard({Key? key, required this.passingdocument})
      : super(key: key);
  DocumentSnapshot passingdocument;



  Future<void> deactivateProductAndCancelOrders(String productId) async {
    final productRef =
        FirebaseFirestore.instance.collection("Products").doc(productId);
    final pendingOrdersQuery = FirebaseFirestore.instance
        .collection("Orders")
        .where("product_id", isEqualTo: productId)
        .where("status", isEqualTo: "pending");

    final batch = FirebaseFirestore.instance.batch();
    final pendingOrders = await pendingOrdersQuery.get();

    batch.update(productRef, {"status": "inactive"});

    for (final order in pendingOrders.docs) {
      final orderRef =
          FirebaseFirestore.instance.collection("Orders").doc(order.id);
      batch.update(orderRef, {"status": "c"});
    }

    await batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              //border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: size.width * .03),
                      Container(
                        width: size.width * .3,
                        height: size.width * .3,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue.shade200,
                          image: DecorationImage(
                            image: NetworkImage(passingdocument['image_url']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 10),
                          child: SizedBox(
                            width: size.width * .5,
                            child: Text(
                              passingdocument['product_name']!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: titleTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.width * .01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: size.width * .03),
                        Container(
                          width: size.width * .35,
                          child: Text(
                            'Rs. ${passingdocument['product_price']!}',
                            style: facilityTextStyle.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.width * .01),
                    Row(
                      children: [
                        SizedBox(width: size.width * .03),
                        Container(
                          width: size.width * .2,
                          height: size.width * .05,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(3)),
                          child: Center(
                            child: Text(
                                (passingdocument['sell_type'] == 'w')
                                    ? 'Wholesale'
                                    : 'Retail',
                                style: facilityTextStyle.copyWith(color: Colors.white)
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.width * .015),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * .03,
                        ),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration:BoxDecoration(
                              color: Colors.blueGrey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(3)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.blueGrey,size: 15,),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                '${passingdocument['rating']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: facilityTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.width * .015),
                    Row(
                      children: [
                        SizedBox(width: size.width * .03),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SellerProductView(
                                      passingdocument: passingdocument),
                                ));
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Text(
                            'Show Product',
                            style: buttonTextStyle.copyWith(fontSize: 12, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: size.width * .03),
                        TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Confirm Delete"),
                                    content: Text("Product deletion will automatically cancel all the existing orders of the product"),
                                    actions: [
                                      TextButton(
                                        child: Text("CANCEL"),
                                        onPressed: () {
                                           Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                           deactivateProductAndCancelOrders(passingdocument.id);
                                           Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            child: Text('Delete', style: buttonTextStyle.copyWith(fontSize: 12, color: Colors.white),)
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
