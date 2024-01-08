import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/presentation/customer/screens/search_catergory/widgets/product_full_view.dart';
// import 'package:sample_project/presentation/customer/screens/search_catergory/widgets/product_full_view.dart';
import 'package:salesafari/presentation/customer/widgets/item.dart';
import '../../../../core/colors/importedTheme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

final user = FirebaseAuth.instance.currentUser;
final db = FirebaseFirestore.instance;
final docRef = db.collection("Users").doc(user!.uid);

Future<String> getUsername() async {
  String userName = '';
  final docRef = db.collection("Users").doc(user!.uid);
  await docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      userName = data['name'];
      print('$userName');
    },
    onError: (e) => print("Error getting document: $e"),
  );
  return userName;
}

List imageList = [
  {"id": 1, "image_path": 'assets/images/banner.png'},
  {"id": 2, "image_path": 'assets/images/bannerpage.png'},
  {"id": 3, "image_path": 'assets/images/banner.png'}
];

final CarouselController carouselController = CarouselController();
int currentIndex = 0;

class CustHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        onTap: () =>
                            {Navigator.pushNamed(context, 'chatlistpage')},
                        child: Icon(
                          Icons.chat,
                          size: 30,
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/images/salesafaritext.png',
                        width: 120,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(color: backgroundColor),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment(-0.9, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back,",
                              style: greetingTextStyle,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            FutureBuilder<String>(
                              future: getUsername(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!,
                                    style: titleTextStyle,
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Text('');
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      //       child: Card(
                      //         semanticContainer: true,
                      //         clipBehavior: Clip.antiAliasWithSaveLayer,
                      //         child: Image.asset(
                      //           'assets/images/bannerpage.png',fit: BoxFit.fill,
                      //           width: 300,
                      //           height: 200,
                      //         ),
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10.0),
                      //   ),
                      //   elevation: 5,
                      //   margin: EdgeInsets.all(10),
                      // ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              print(currentIndex);
                            },
                            child: CarouselSlider(
                              items: imageList
                                  .map(
                                    (item) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                        shadowColor: Colors.white,
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          //height: 500,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      item['image_path']),
                                                  fit: BoxFit.fill)),
                                        ),
                                        //       child: Image.asset(
                                        //   item['image_path'],
                                        //   fit: BoxFit.cover,
                                        //
                                        //   //width: double.infinity,
                                        // ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              carouselController: carouselController,
                              options: CarouselOptions(
                                scrollPhysics: const BouncingScrollPhysics(),
                                autoPlay: true,
                                aspectRatio: 1.6,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  currentIndex = index;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Popular Products",
                            style: subTitleTextStyle,
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 250,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Products')
                                .where('status', isEqualTo: 'active')
                                .orderBy('rating', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              }
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.blue),
                                  );
                                default:
                                  if (snapshot.data!.docs.isNotEmpty) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.docs.length,
                                        physics: ScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot document =
                                              snapshot.data!.docs[index];

                                          return StreamBuilder<
                                                  DocumentSnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .doc(document[
                                                      'product_seller_id'])
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot>
                                                      snapshot) {
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                }

                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: Colors.blue),
                                                  );
                                                }

                                                if (!snapshot.hasData) {
                                                  return Text(
                                                      'Document does not exist');
                                                }
                                                // Extract data from the snapshot and display it
                                                final sellerdata =
                                                    snapshot.data!;
                                                return GestureDetector(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductFullViewPage(
                                                        passingdocument:
                                                            document,
                                                        sellerdata: sellerdata,
                                                        minQuantity: int.parse(
                                                            document[
                                                                'min_quantity']),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      10)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 0, 10, 10),
                                                        child: Material(
                                                          shadowColor:
                                                              primaryColor500
                                                                  .withOpacity(
                                                                      0.1),
                                                          elevation: 10,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: InkWell(
                                                            highlightColor:
                                                                primaryColor500
                                                                    .withOpacity(
                                                                        0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            splashColor:
                                                                primaryColor500
                                                                    .withOpacity(
                                                                        0.5),
                                                            child: Container(
                                                              //padding: EdgeInsets.all(10),
                                                              child: Column(
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10)),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              document['image_url'],
                                                                          height:
                                                                              160,
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 2.5,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      //padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                                                                      height:
                                                                          52,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Padding(
                                                                              padding: EdgeInsets.symmetric(vertical: 3)),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                document['product_name'],
                                                                                maxLines: 2,
                                                                                style: descTextStyle,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const Padding(
                                                                              padding: EdgeInsets.symmetric(vertical: 1)),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                'Rs.${document['product_price']} ',
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: facilityTextStyle,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  // child: Column(
                                                  //   children: [
                                                  //       Container(
                                                  //         margin: EdgeInsets.only(
                                                  //             right: 8, left: 8, top: 0, bottom: 0),
                                                  //         width: 100,
                                                  //         height: 100,
                                                  //         decoration:  BoxDecoration(
                                                  //           borderRadius:
                                                  //               BorderRadius.all(Radius.circular(14)),
                                                  //           color: Colors.black,
                                                  //           image: DecorationImage(
                                                  //             image: NetworkImage(
                                                  //                 document['image_url']),
                                                  //                fit: BoxFit.cover,
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //
                                                  //     const SizedBox(
                                                  //       height: 10,
                                                  //     ),
                                                  //      Text(document['product_name']),
                                                  //     const SizedBox(
                                                  //       height: 8,
                                                  //     ),
                                                  //     Text('Rs.${document['product_price']} /-',style: TextStyle(fontSize: 11,fontWeight:FontWeight.bold,),),
                                                  //   ],
                                                  // ),
                                                );
                                              });
                                        });
                                  } else {
                                    return Center(
                                      child: const Text(
                                        'No Products',
                                      ),
                                    );
                                  }
                              }
                            })),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text("New Products",
                                  style: subTitleTextStyle)),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 250,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Products')
                                .where('status', isEqualTo: 'active')
                                .orderBy('upload_time', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              }
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.blue),
                                  );
                                default:
                                  if (snapshot.data!.docs.isNotEmpty) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.docs.length,
                                        physics: ScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot document =
                                              snapshot.data!.docs[index];

                                          return StreamBuilder<
                                                  DocumentSnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .doc(document[
                                                      'product_seller_id'])
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<
                                                          DocumentSnapshot>
                                                      snapshot) {
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                }

                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: Colors.blue),
                                                  );
                                                }

                                                if (!snapshot.hasData) {
                                                  return Text(
                                                      'Document does not exist');
                                                }
                                                // Extract data from the snapshot and display it
                                                final sellerdata =
                                                    snapshot.data!;
                                                return GestureDetector(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductFullViewPage(
                                                        passingdocument:
                                                            document,
                                                        sellerdata: sellerdata,
                                                        minQuantity: int.parse(
                                                            document[
                                                                'min_quantity']),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      10)),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 0, 10, 10),
                                                        child: Material(
                                                          shadowColor:
                                                              primaryColor500
                                                                  .withOpacity(
                                                                      0.1),
                                                          elevation: 10,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: InkWell(
                                                            highlightColor:
                                                                primaryColor500
                                                                    .withOpacity(
                                                                        0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            splashColor:
                                                                primaryColor500
                                                                    .withOpacity(
                                                                        0.5),
                                                            child: Container(
                                                              //padding: EdgeInsets.all(10),
                                                              child: Column(
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius: const BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10),
                                                                            topRight: Radius.circular(10)),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          imageUrl:
                                                                              document['image_url'],
                                                                          height:
                                                                              130,
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 3,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      //padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                                                                      height:
                                                                          52,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Padding(
                                                                              padding: EdgeInsets.symmetric(vertical: 3)),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                document['product_name'],
                                                                                maxLines: 2,
                                                                                style: descTextStyle,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const Padding(
                                                                              padding: EdgeInsets.symmetric(vertical: 1)),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                'Rs.${document['product_price']} ',
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: facilityTextStyle,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        });
                                  } else {
                                    return Center(
                                      child: const Text(
                                        'No Products',
                                      ),
                                    );
                                  }
                              }
                            })),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final List<Item> _choices = [
    Item("All", Icon(Icons.clear_all_rounded)),
    Item("Men", Icon(Icons.person)),
    Item("Women", Icon(Icons.emoji_people_sharp)),
    Item("Fashion", Icon(Icons.shopping_bag)),
    Item("Baby", Icon(Icons.child_care)),
    Item("Kids", Icon(Icons.face_sharp))
  ];
}
