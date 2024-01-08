import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/presentation/customer/screens/search_catergory/widgets/product_full_view.dart';
import 'package:salesafari/presentation/customer/screens/search_catergory/widgets/product_tile.dart';
import 'package:salesafari/presentation/customer/screens/search_catergory/widgets/search_product.dart';

import '../../../../core/colors/importedTheme.dart';

class SearchAndCategoryPage extends StatefulWidget {
  const SearchAndCategoryPage({super.key});

  @override
  State<SearchAndCategoryPage> createState() => _SearchAndCategoryPageState();
}

class _SearchAndCategoryPageState extends State<SearchAndCategoryPage> {
  Stream<QuerySnapshot<Object?>>? stream;

  String? cat = '';
  num? price = 0;
  String? type = 'r';
  // String? catvalue = 'Any Category';
  String? priceValue = 'All Price';

  // final _catList = ['Any Category', 'Fashion', 'Food', 'Others'];

  // final _priceList = ['All Price', '< Rs.500', '< Rs.1000', '> Rs.1000'];

  @override
  Widget build(BuildContext context) {
    if (cat == '') {
      if (price == 0) {
        (type == 'w')
            ? stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('sell_type', isEqualTo: 'w')
                .snapshots()
            : stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('sell_type', isEqualTo: 'r')
                .snapshots();
      } else if (price == 1) {
        (type == 'w')
            ? stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('product_price', isGreaterThan: 1000)
                .where('sell_type', isEqualTo: 'w')
                .snapshots()
            : stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('product_price', isGreaterThan: 1000)
                .where('sell_type', isEqualTo: 'r')
                .snapshots();
      } else {
        (type == 'w')
            ? stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('product_price', isLessThan: price)
                .where('sell_type', isEqualTo: 'w')
                .snapshots()
            : stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('product_price', isLessThan: price)
                .where('sell_type', isEqualTo: 'r')
                .snapshots();
      }
    } else if (cat!.isNotEmpty) {
      if (price == 0) {
        (type == 'w')
            ? stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('category', isEqualTo: cat)
                .where('sell_type', isEqualTo: 'w')
                .snapshots()
            : stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('category', isEqualTo: cat)
                .where('sell_type', isEqualTo: 'r')
                .snapshots();
      } else if (price == 1) {
        (type == 'w')
            ? stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('category', isEqualTo: cat)
                .where('product_price', isGreaterThan: 1000)
                .where('sell_type', isEqualTo: 'w')
                .snapshots()
            : stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('category', isEqualTo: cat)
                .where('product_price', isGreaterThan: 1000)
                .where('sell_type', isEqualTo: 'r')
                .snapshots();
      } else {
        (type == 'w')
            ? stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('category', isEqualTo: cat)
                .where('product_price', isLessThan: price)
                .where('sell_type', isEqualTo: 'w')
                .snapshots()
            : stream = FirebaseFirestore.instance
                .collection("Products")
                .where("status", isEqualTo: 'active')
                .where('category', isEqualTo: cat)
                .where('product_price', isLessThan: price)
                .where('sell_type', isEqualTo: 'r')
                .snapshots();
      }
    }

    return Scaffold(

      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey.shade300,
          foregroundColor: Colors.white,
          child: Icon(
            Icons.search_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchProductPage(),
              ),
            );
          }),
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
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width /3.5,
                  margin: const EdgeInsets.only(left: 10),
                  child: DropdownButton(
                    underline: Divider(color: Colors.black12.withOpacity(0),),
                    // hint: const Text('Category'),
                    value: cat,
                    items: [
                      DropdownMenuItem(
                        child: Text('All Category', style: facilityTextStyle,),
                        value: '',
                      ),
                      DropdownMenuItem(
                        child: Text('Textiles', style: facilityTextStyle,),
                        value: 'textiles',
                      ),
                      DropdownMenuItem(
                        child: Text('Handcrafts', style: facilityTextStyle,),
                        value: 'handcrafts',
                      ),
                      DropdownMenuItem(
                        child: Text('Food & \nBeverages', style: facilityTextStyle,),
                        value: 'food',
                      ),
                      DropdownMenuItem(
                        child: Text('Others', style: facilityTextStyle,),
                        value: 'others',
                      )
                    ],
                    onChanged: (value) => setState(() {
                      cat = value;
                    }),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width /3.5,
                  margin: const EdgeInsets.only(left: 10),
                  child: DropdownButton<String>(
                    underline: Divider(color: Colors.black12.withOpacity(0),),
                    // hint: const Text('Category'),
                    items: [
                      DropdownMenuItem(
                        child: Text('Any Price', style: facilityTextStyle,),
                        value: '0',
                      ),
                      DropdownMenuItem(
                        child: Text('Less than\nRs.500', style: facilityTextStyle,),
                        value: '500',
                      ),
                      DropdownMenuItem(
                        child: Text('Less than\nRs.1000', style: facilityTextStyle,),
                        value: '1000',
                      ),
                      DropdownMenuItem(
                        child: Text('Greater than\nRs.1000', style: facilityTextStyle,),
                        value: '1',
                      ),
                    ],
                    value: price.toString(),
                    onChanged: (value) => setState(() {
                      price = num.parse(value!);
                    }),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width /3.5,
                  margin: const EdgeInsets.only(left: 10),
                  child: DropdownButton(
                    underline: Divider(color: Colors.black12.withOpacity(0),),
                    // hint: const Text('Sale Type'),
                    value: type,
                    items: [
                      DropdownMenuItem(
                        child: Text('Retail', style: facilityTextStyle,),
                        value: 'r',
                      ),
                      DropdownMenuItem(
                        child: Text('Wholesale', style: facilityTextStyle,),
                        value: 'w',
                      ),
                    ],
                    onChanged: (value) => setState(() {
                      type = value;
                    }),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return GridView.count(
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                          crossAxisCount: 2,
                          childAspectRatio: 3/3.4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: List.generate(snapshot.data!.docs.length,
                              (index) {
                            DocumentSnapshot document =
                                snapshot.data!.docs[index];
                            return StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(document['product_seller_id'])
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
                                final sellerdata = snapshot.data!;
                                return InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductFullViewPage(
                                        passingdocument: document,
                                        sellerdata: sellerdata,
                                        minQuantity: int.parse(
                                            document['min_quantity']),
                                      ),
                                    ),
                                  ),
                                  child: ProductTile(
                                    passingdocument: document,
                                  ),
                                );
                              },
                            );
                          }));
                    } else {
                      return Center(
                        child: const Text(
                          'No Product Items',
                        ),
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 15),
        ),
      );
}
