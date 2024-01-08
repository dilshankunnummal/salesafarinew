import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../core/colors/importedTheme.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.passingdocument,
  }) : super(key: key);

  final DocumentSnapshot passingdocument;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              shadowColor: primaryColor500.withOpacity(0.1),
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                highlightColor: primaryColor500.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                splashColor: primaryColor500.withOpacity(0.5),
                child: Container(

                  //padding: EdgeInsets.all(10),
                  child: Column(
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: CachedNetworkImage(

                              imageUrl: passingdocument['image_url'],
                              height: 130,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width/2.3,
                              fit: BoxFit.cover,
                            ),),
                        ),

                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          height: 52,
                          child: Column(
                            children: [
                              const Padding(padding: EdgeInsets.symmetric(
                                  vertical: 3)),
                              Row(
                                children: [
                                  Text(
                                    passingdocument['product_name'],
                                    maxLines: 2,
                                    style: descTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.symmetric(
                                  vertical: 1)),
                              Row(
                                children: [
                                  Text(
                                    'Rs.${passingdocument['product_price']} ',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: facilityTextStyle,

                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text('${passingdocument['rating'].toStringAsFixed(1)}',style: bottomNavTextStyle.copyWith(color: Colors.blueGrey),),
                                      const Icon(
                                        Icons.star_sharp,
                                        size: 17,
                                        color: Colors.yellow,
                                      )
                                    ],
                                  )

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









          // Container(
          //   width: size.width * .4,
          //   height: size.width * .4,
          //   decoration: BoxDecoration(
          //     borderRadius: const BorderRadius.all(Radius.circular(10)),
          //     color: Colors.blue.shade200,
          //     image: DecorationImage(
          //       image: NetworkImage(passingdocument['image_url']),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          // Text(
          //   passingdocument['product_name'],
          //   textAlign: TextAlign.center,
          //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Container(
          //       width: 50,
          //       height: 30,
          //       decoration: BoxDecoration(
          //           color: Colors.blueAccent,
          //           borderRadius: BorderRadius.circular(5)),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text('${passingdocument['rating'].toStringAsFixed(1)}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
          //           const Icon(
          //             Icons.star_sharp,
          //             size: 17,
          //             color: Colors.yellow,
          //           )
          //         ],
          //       ),
          //     ),
          //     Text(
          //       'Rs.${passingdocument['product_price']}/-',
          //       style: const TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
