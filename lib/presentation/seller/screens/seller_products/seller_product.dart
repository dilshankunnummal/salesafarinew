import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salesafari/presentation/seller/screens/seller_products/widgets/seller_product_card.dart';

import '../../../../core/colors/importedTheme.dart';


class SellerProductPage extends StatefulWidget {
  const SellerProductPage({super.key});

  @override
  State<SellerProductPage> createState() => _SellerProductPageState();
}

class _SellerProductPageState extends State<SellerProductPage> {
  Stream<QuerySnapshot<Object?>>? stream;
  final curruser = FirebaseAuth.instance.currentUser;
  String? cat = '';
  num? price = 0;
  String? type = 'r';
  String? priceValue = 'All Price';
  

//TextEditingController ksearch = TextEditingController();
  // String? catvalue = 'All Catogery';
  // String? priceValue = 'Any Price';

  // final _catList = ['All Catogery', 'Food', 'Hand Crafts'];

  // final _priceList = ['Any Price', '< 500', '< 750', '< 1000', '> 1000'];

  // final _productNameList = [
  //   'Paper Bags',
  //   'Gift Wrappings',
  //   'Embroidary Threads',
  //   'Paper Bags',
  //   'Gift Wrappings',
  //   'Embroidary Threads',
  //   'Paper Bags',
  //   'Gift Wrappings',
  //   'Embroidary Threads',
  //   'Penholder Paper Craft'
  // ];

  // final _imageUrlList = [
  //   'assets/images/decorators.jpeg',
  //   'assets/images/gift wrappings.jpeg',
  //   'assets/images/color threads.jpeg',
  //   'assets/images/decorators.jpeg',
  //   'assets/images/gift wrappings.jpeg',
  //   'assets/images/color threads.jpeg',
  //   'assets/images/decorators.jpeg',
  //   'assets/images/gift wrappings.jpeg',
  //   'assets/images/color threads.jpeg',
  //   'assets/images/pencilholder.jpeg'
  // ];

  // final _productPriceList = [50, 40, 99, 50, 40, 99, 50, 40, 99, 55];

  @override
  Widget build(BuildContext context) {
        final size=MediaQuery.of(context).size;

  
  if(curruser!=null){
    if (cat == '') {
    if (price == 0) {
      (type == 'w')
          ? stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .where('sell_type', isEqualTo: 'w')
              .snapshots()
          : stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .where('sell_type', isEqualTo: 'r')
              .snapshots();
    } else if (price == 1) {
      (type == 'w')
          ? stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .where('product_price', isGreaterThan: 1000)
              .where('sell_type', isEqualTo: 'w')
              .snapshots()
          : stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .where('product_price', isGreaterThan: 1000)
              .where('sell_type', isEqualTo: 'r')
              .snapshots();
    } else {
      (type == 'w')
          ? stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .where('product_price', isLessThan: price)
              .where('sell_type', isEqualTo: 'w')
              .snapshots()
          : stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .where('product_price', isLessThan: price)
              .where('sell_type', isEqualTo: 'r')
              .snapshots();
    }
  } else if (cat!.isNotEmpty) {
    if (price == 0) {
      // stream = FirebaseFirestore.instance
      //     .collection("Products")
      //     .where('category', isEqualTo: cat)
      //     .snapshots();
      (type == 'w')
          ? stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .where('category', isEqualTo: cat)
              .where('sell_type', isEqualTo: 'w')
              .snapshots()
          : stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('category', isEqualTo: cat)
              .where('sell_type', isEqualTo: 'r')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .snapshots();
    } else if (price == 1) {
      (type == 'w')
          ? stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .where('category', isEqualTo: cat)
              .where('product_price', isGreaterThan: 1000)
              .where('sell_type', isEqualTo: 'w')
              .snapshots()
          : stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .where('category', isEqualTo: cat)
              .where('product_price', isGreaterThan: 1000)
              .where('sell_type', isEqualTo: 'r')
              .snapshots();
    } else {
      (type == 'w')
          ? stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .where('category', isEqualTo: cat)
              .where('product_price', isLessThan: price)
              .where('sell_type', isEqualTo: 'w')
              .snapshots()
          : stream = FirebaseFirestore.instance
              .collection("Products")
              .where("status", isEqualTo: 'active')
              .where('product_seller_id', isEqualTo: curruser!.uid)
              .where('category', isEqualTo: cat)
              .where('product_price', isLessThan: price)
              .where('sell_type', isEqualTo: 'r')
              .snapshots();
    }
  }
  }

print(curruser?.uid);
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'addProdForm');
          //   showModalBottomSheet(
          //       context: context,
          //       //background color for modal bottom screen
          //       //elevates modal bottom screen
          //       elevation: 20,
          //       // gives rounded corner to modal bottom screen
          //       shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(30),
          //             topRight: Radius.circular(30)),
          //       ),
          //       builder: (BuildContext context) {
          //         return Padding(
          //           padding: EdgeInsets.all(20),
          //           child: AddProductForm(),
          //         );
          //       }

          //       //(BuildContext context) {
          //       //   // UDE : SizedBox instead of Container for whitespaces
          //       //   return SizedBox(
          //       //     height: 200,
          //       //     child: Center(
          //       //       child: Column(
          //       //         mainAxisAlignment: MainAxisAlignment.center,
          //       //         children: const <Widget>[
          //       //           AddProduct(),
          //       //         ],
          //       //       ),
          //       //     ),
          //       //   );
          //       // },
          //       );
        },
        child: Text("Add Product",
            style: buttonTextStyle.copyWith(color: Colors.green)),
      ),
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
                      return ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(
                                height: 10,
                              ),
                          itemBuilder: (context, index) {
                            DocumentSnapshot document =
                                snapshot.data!.docs[index];
                            return SellerProductCard(
                              passingdocument: document,
                            );
                          });
                    } else {
                      return Center(
                        child: Lottie.asset('assets/lottie/empty_box.json',width:size.width*.75),
                      );
                    }
                }
              },
            ),
          ),

          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 10, right: 10),
          //     child: GridView.count(
          //         crossAxisCount: 2,
          //         childAspectRatio: 3 / 4,
          //         mainAxisSpacing: 10,
          //         crossAxisSpacing: 10,
          //         children: List.generate(10, (index) {
          //           return InkWell(
          //             onTap: () => Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => ProductFullViewPage(
          //                   title: _productNameList[index],
          //                   imageUrl: _imageUrlList[index],
          //                 ),
          //               ),
          //             ),
          //             child: ProductTile(
          //               price: _productPriceList[index],
          //               productname: _productNameList[index],
          //               imageUrl: _imageUrlList[index],
          //             ),
          //           );
          //         },),),
          //   ),
          // ),
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
