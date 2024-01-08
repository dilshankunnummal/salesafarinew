import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/importedTheme.dart';
import 'package:salesafari/presentation/customer/screens/search_catergory/widgets/product_full_view.dart';
import 'package:salesafari/presentation/customer/screens/search_catergory/widgets/search_tile.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  String _search = '';
  @override
  Widget build(BuildContext context) {

    dynamic streamSearch =
        FirebaseFirestore.instance.collection("Products").where('status',isEqualTo: 'active').snapshots();

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: TextFormField(
                  onChanged: (value) => setState(() {
                    _search = value;
                  }),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search, color: Colors.black),
                    hintText:
                      'Search Products here...',
                      hintStyle: facilityTextStyle,

                    border: InputBorder.none
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: streamSearch,
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
                          return ListView.builder(itemCount:snapshot.data!.docs.length,
                          itemBuilder:(context, index) {
                            DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                var data =
                                    snapshot.data!.docs[index].data() as Map<String,dynamic>;
                                if(_search.isEmpty)
                                {
                                  return StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(document['product_seller_id'])
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
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
                                      child: SearchTile(
                                        passingdocument: document,
                                      ),
                                    );
                                  },
                                );
                                }

                                if(document['product_name'].toString().toLowerCase().startsWith(_search.toLowerCase())){
                                  print(data['product_name']);
                                  print(_search);
                                    return 
                                    StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(document['product_seller_id'])
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
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

                                    print(sellerdata['name']);
                                    print(document['min_quantity']);
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
                                      child: SearchTile(
                                        passingdocument: document,
                                      ),
                                    );
                                  },
                                );
                                }
                                return Container();
                          },);
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
            ),
          ],
        ),
      ),
    );
  }
}

