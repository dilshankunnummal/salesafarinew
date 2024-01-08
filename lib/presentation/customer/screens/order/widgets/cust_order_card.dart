import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:salesafari/core/colors/importedTheme.dart';
import 'package:salesafari/presentation/chat/chat_message_page.dart';

class CustOrderCard extends StatelessWidget {
  const CustOrderCard(
      {required this.orderdoc, required this.productdoc, super.key});
  final DocumentSnapshot orderdoc;
  final DocumentSnapshot productdoc;

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    double rating = 0;
    String formatTimestamp(Timestamp timestamp) {
      var format =
          new DateFormat('hh:mm a dd MMM yyyy'); // <- use skeleton here
      return format.format(timestamp.toDate());
    }

    Widget buildRating() => RatingBar.builder(
        minRating: 1,
        itemSize: 40,
        updateOnDrag: true,
        itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
        onRatingUpdate: (value) {
          rating = value;
        });

    showRating() => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Rate the Order'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please leave a star rating',
                  style: TextStyle(fontSize: 20),
                ),
                buildRating(),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    num curr_rating =productdoc['rating'];
                    num no_rating = productdoc['rating_count'];
                    // num curr_no = ++no_rating;
                    num finalrating =
                        ((curr_rating * no_rating) + rating) / (no_rating + 1);
                    print(finalrating);

                    db
                        .collection('Products')
                        .doc(orderdoc['product_id'])
                        .update({
                      'rating': finalrating,
                      'rating_count': FieldValue.increment(1)
                    });
                    db
                        .collection('Orders')
                        .doc(orderdoc.id)
                        .update({'status': 'r'});

                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        );

    String orderdatetime = formatTimestamp(orderdoc['datetime']);

    final visibility = (orderdoc['status'] == 's') ? true : false;
    final cVisibility = (orderdoc['status'] == 'p') ? true : false;
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(orderdoc['seller_id'])
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }

          if (!snapshot.hasData) {
            return Text('Document does not exist');
          }
          // Extract data from the snapshot and display it
          final sellerdoc = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(width: size.width * .03),
                                Container(
                                  width: size.width * .25,
                                  height: size.width * .25,
                                  decoration: BoxDecoration(

                                    image: DecorationImage(
                                      image: NetworkImage(productdoc['image_url']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: size.width * .4,
                                        child: Text(
                                          productdoc['product_name'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: titleTextStyle,
                                        ),
                                      ),
                                      Container(
                                        width: size.width * .2,
                                        height: size.width * .06,
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade300,
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            (productdoc['sell_type'] == 'w')
                                                ? 'Wholesale'
                                                : 'Retail',
                                            style: descTextStyle.copyWith(color: Colors.white)
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: size.width * .02),
                                  Text(
                                    'Quantity : ${orderdoc['quantity']}',
                                    style: descTextStyle
                                  ),
                                  SizedBox(height: size.width * .02),
                                  Text(
                                    (orderdoc['status'] == 's' ||
                                            orderdoc['status'] == 'r')
                                        ? 'Status : Success'
                                        : (orderdoc['status'] == 'p')
                                            ? 'Status : Pending'
                                            : 'Status : Cancelled',
                                    style: descTextStyle,
                                  ),
                                  SizedBox(height: size.width * .02),
                                  Text(
                                    'Total Price : Rs.${orderdoc['totalprice']}',
                                    style: descTextStyle,
                                  ),
                                  SizedBox(height: size.width * .02),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text('Sold By : ${sellerdoc['companyname']}',
                            style: descTextStyle),
                        SizedBox(height: size.width * .02),
                        Text('PIN Code : ${sellerdoc['pincode']}',
                            style: descTextStyle),
                        SizedBox(height: size.width * .02),
                        Text('Shop Address :\n\t${sellerdoc['address']}',
                            style: descTextStyle),
                        SizedBox(height: size.width * .02),
                        Text('Ordered Time : $orderdatetime',
                            style: descTextStyle),
                        SizedBox(height: size.width * .02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatMessagePage(
                                              id: sellerdoc.id,
                                              // name: sellerdoc['name'],
                                              passingdocument: sellerdoc),
                                        ));
                                  },

                                  child: Text(
                                    'Contact Seller',
                                    style: buttonTextStyle.copyWith(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: visibility,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      showRating();
                                    },
                                    child: Text(
                                      'Rate Order',
                                      style: buttonTextStyle.copyWith(color: Colors.green),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: cVisibility,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      db
                                          .collection('Orders')
                                          .doc(orderdoc.id)
                                          .update({'status': 'c'});
                                    },

                                    child: Text(
                                      'Cancel',
                                      style: buttonTextStyle.copyWith(color: Colors.redAccent),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
