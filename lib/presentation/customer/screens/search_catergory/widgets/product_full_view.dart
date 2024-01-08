

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:salesafari/core/colors/Colors.dart';
import 'package:salesafari/core/colors/importedTheme.dart';
import 'package:salesafari/presentation/authentication/login.dart';
import 'package:salesafari/presentation/chat/chat_message_page.dart';


class ProductFullViewPage extends StatefulWidget {
  final DocumentSnapshot passingdocument;
  final DocumentSnapshot sellerdata;
  
  int minQuantity;

  ProductFullViewPage(
      {super.key,
       required this.passingdocument,
       required this.sellerdata,
       required this.minQuantity,
      });
      
        
  @override
  State<ProductFullViewPage> createState() => _ProductFullViewPageState();
}

class _ProductFullViewPageState extends State<ProductFullViewPage> {


void decrement() {
    setState(() {
      if (widget.minQuantity > int.parse(widget.passingdocument['min_quantity'])) {
        widget.minQuantity--;
      }
    });
  }
  void increment() {
    setState(() {
      if (widget.minQuantity < int.parse(widget.passingdocument['max_quantity'])) {
        widget.minQuantity++;
      }
    });
  }

  @override
   Widget build(BuildContext context)  {  

    const sizedBox = SizedBox(
      height: 20,
    );
    
    final size = MediaQuery.of(context).size;
    
    
    
    print(widget.passingdocument['product_price']);

    double width = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(6, 6, 0, 0),
        child: CircleAvatar(
          radius: 20,
          child: FloatingActionButton(
            backgroundColor: Color(0xffF5F9FF),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: ElevatedButton(onPressed: () {
          final firestore = FirebaseFirestore.instance;
          final user= FirebaseAuth.instance.currentUser;
          num totalprice = widget.minQuantity *widget.passingdocument['product_price'];

          firestore.collection('Orders').doc().set({
            'customer_id':user?.uid,
            'seller_id':widget.passingdocument['product_seller_id'],
            'product_id':widget.passingdocument.id,
            'datetime':DateTime.now(),
            'status':'p',
            'quantity':widget.minQuantity,
            'totalprice': totalprice
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: NewSnackbar(
                errortext:
                'Your Order is Placed\nCheckout your Orders!\nTotal Price : $totalprice',
                errorcolor: Colors.lightBlue,
              ),
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
            ),
          );

        }, child: Text('Book Now'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(

                    imageUrl: widget.passingdocument['image_url'],
                    height: 325,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 200,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                        image: DecorationImage(scale: 2, image: AssetImage('assets/images/imageloading.gif'),fit: BoxFit.fill, opacity: 0.6),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                    ),
                  ),
                  Positioned(child: Container(
                    height: 25,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(40.0),
                          bottomLeft: Radius.circular(0)),
                    ),
                  ),
                    top: 306,
                  ),


                  Container(

                    margin: EdgeInsets.fromLTRB(20, 330, 20, 30),
                    child: Column(
                      children: [
                        Row(
                            children: [
                              SizedBox(width: 10,),
                              Flexible(
                                flex: 2,
                                child: Text(
                                  widget.passingdocument['product_name'],
                                  style: greetingTextStyle,
                                  maxLines: 2, // Maximum number of lines to display
                                  overflow: TextOverflow.ellipsis, // What to do when the text overflows
                                ),
                              ),
                              Spacer(),
                              Spacer(),
                              Spacer(),
                              Spacer(),
                              Container(
                                height: 50,
                                width: width/8,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  splashRadius: 1,
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (ctx) => ChatMessagePage(
                                          id:widget.sellerdata.id,
                                          // name:widget.sellerdata['companyname'],
                                          passingdocument: widget.sellerdata,
                                        )));

                                  },
                                  icon: Icon(Icons.chat,color: Colors.white,),
                                ),
                              ),
                            ]
                        ),

                        SizedBox(height: 35,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Align(child: Text('Description:', style: subTitleTextStyle,),
                              alignment: Alignment(-0.93, 0),
                            ),
                          ],
                        ),
                        //SizedBox(height: 3,),
                        Row(
                          children: [
                            Flexible(
                              child: Padding(padding: EdgeInsets.all(10),
                                child: Text(widget.passingdocument['description'], style: normalTextStyle, overflow: TextOverflow.ellipsis, maxLines: 10,),
                              ),
                            ),
                          ],
                        ),SizedBox(height: 30,),
                        Align(child: Text('Pricing and Rating:', style: subTitleTextStyle,),
                          alignment: Alignment(-0.93, 0),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Icon(Icons.price_change_rounded, size: 20, color: Colors.blueAccent,),
                            SizedBox(width: 10,),
                            Text('Rs.${widget.passingdocument['product_price']}', style: normalTextStyle,),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Icon(Icons.star, size: 20, color: Colors.blueAccent,),
                            SizedBox(width: 10,),
                            Text('${widget.passingdocument['rating'].toStringAsFixed(1)} (${widget.passingdocument['rating_count']} Ratings)', style: normalTextStyle,),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text('Seller Information:', style: subTitleTextStyle,),
                          alignment: Alignment(-0.93, 0),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Icon(Icons.sell_rounded, size: 20, color: Colors.blueAccent,),
                            SizedBox(width: 10,),
                            Text('Sold by ${widget.sellerdata['companyname']}', style: normalTextStyle,),
                          ],
                        ),

                        SizedBox(height: 15,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Icon(Icons.location_on, size: 20, color: Colors.blueAccent,),
                            SizedBox(width: 10,),
                            Text(widget.sellerdata['address'], style: normalTextStyle),
                          ],
                        ),

                        SizedBox(height: 30,),
                        Align(child: Text('Order Quantity:', style: subTitleTextStyle,),
                          alignment: Alignment(-0.93, 0),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            InkWell(
                                splashColor: Colors.redAccent,
                                onTap: decrement,
                                child: Icon(Icons.indeterminate_check_box_rounded, size: 30, color: Colors.black12,)),
                            SizedBox(width: 30,),
                            Text('${widget.minQuantity}', style: normalTextStyle),
                            SizedBox(width: 30,),
                            InkWell(
                                splashColor: Colors.greenAccent,
                                onTap: increment,
                                child: Icon(Icons.add_box_rounded, size: 30, color: Colors.black12,)),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],

              ),

            ],
          ),
        ),
      ),
    );
    // SafeArea(
    //   child: Scaffold(
    //     body: Column(
    //       children: [
    //         Expanded(
    //           child: SingleChildScrollView(
    //             child: Column(
    //               children: [
    //                 //Image Product
    //                 Padding(
    //                   padding: const EdgeInsets.all(10),
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(20),
    //                     child: Image.network(
    //                       widget.passingdocument['image_url'],
    //                       fit: BoxFit.fill,
    //                     ),
    //                   ),
    //                 ),
    //
    //                 //Product Hero
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 10),
    //                   child: Row(
    //                     children: [
    //                       //ProductName
    //                       Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             SizedBox(
    //                                 width: size.width * .55,
    //                                 child: Text(
    //                                   '${widget.passingdocument['product_name']}',
    //                                   style: TextStyle(
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.w400),
    //                                 )),
    //                             SizedBox(
    //                                 width: size.width * .55,
    //                                 child: Text(
    //                                   'Sold by ${widget.sellerdata['companyname']}',
    //                                   style: TextStyle(
    //                                       fontSize: 15,
    //                                       fontWeight: FontWeight.w500),
    //                                 )),
    //                           ],
    //                         ),
    //                       ),
    //
    //                       //Price
    //                       Column(
    //                         children: [
    //                           Text(
    //                             'Rs.${widget.passingdocument['product_price']}/-',
    //                             style: TextStyle(
    //                                 fontSize: 25, fontWeight: FontWeight.bold),
    //                           ),
    //                           //rating row
    //                           Row(
    //                             children: [
    //                               const Icon(
    //                                 Icons.star,
    //                                 color: Colors.amber,
    //                               ),
    //                               Text('${widget.passingdocument['rating'].toStringAsFixed(1)} ( ${widget.passingdocument['rating_count']} Ratings )'),
    //                             ],
    //                           )
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 //Chat Button
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: SizedBox(
    //                     width: size.width * .9,
    //                     height: size.width * .13,
    //                     child: ElevatedButton(
    //                         onPressed: () {
    //                           Navigator.of(context).push(MaterialPageRoute(
    //                               builder: (ctx) => ChatMessagePage(
    //                                 id:widget.sellerdata.id,
    //                                 // name:widget.sellerdata['companyname'],
    //                                 passingdocument: widget.sellerdata,
    //                               )));
    //                         },
    //                         style: ElevatedButton.styleFrom(
    //                             backgroundColor: Colors.lightBlue,
    //                             shape: RoundedRectangleBorder(
    //                                 borderRadius: BorderRadius.circular(30))),
    //                         child: const Text(
    //                           'Chat with Seller',
    //                           style: TextStyle(color: textColor),
    //                         )),
    //                   ),
    //                 ),
    //                 //Product Desc
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal:15,vertical: 10),
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                         border: Border.all(color: Colors.black),
    //                         borderRadius: BorderRadius.circular(20)),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.symmetric(vertical:15,horizontal: 10),
    //                           child: const Text("Product Discription",style: TextStyle(fontSize: 20)),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 15,right:15,bottom: 10),
    //                           child: Text(widget.passingdocument['description']),
    //                         ),
    //
    //                         Padding(
    //                           padding: const EdgeInsets.symmetric(vertical:15,horizontal: 10),
    //                           child: const Text("Shop Address",style: TextStyle(fontSize: 20)),
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 15,right:15,bottom: 10),
    //                           child: Text(widget.sellerdata['address']),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //         Container(
    //           width: double.infinity,
    //           height: size.width * .2,
    //           decoration: const BoxDecoration(
    //             color: Colors.lightBlue,
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 15),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 ElevatedButton(
    //                   onPressed: decrement,
    //                   style: ElevatedButton.styleFrom(
    //                       backgroundColor: Colors.amber.shade700,
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(50))),
    //                   child: const Icon(
    //                     LineAwesomeIcons.minus,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: EdgeInsets.symmetric(horizontal: 8),
    //                   child: Text('${widget.minQuantity}',
    //                       style: TextStyle(color: textColor, fontSize: 18)),
    //                 ),
    //                 ElevatedButton(
    //                   onPressed: increment,
    //                   style: ElevatedButton.styleFrom(
    //                       backgroundColor: Colors.amber.shade700,
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(50))),
    //                   child: const Icon(
    //                     LineAwesomeIcons.plus,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //                 const Spacer(),
    //                 SizedBox(
    //                   width: size.width * .4,
    //                   height: size.width * .12,
    //                   child: ElevatedButton(
    //                       onPressed: () {
    //                         final firestore = FirebaseFirestore.instance;
    //                         final user= FirebaseAuth.instance.currentUser;
    //                         num totalprice = widget.minQuantity *widget.passingdocument['product_price'];
    //
    //                         firestore.collection('Orders').doc().set({
    //                           'customer_id':user?.uid,
    //                           'seller_id':widget.passingdocument['product_seller_id'],
    //                           'product_id':widget.passingdocument.id,
    //                           'datetime':DateTime.now(),
    //                           'status':'p',
    //                           'quantity':widget.minQuantity,
    //                           'totalprice': totalprice
    //                         });
    //                         ScaffoldMessenger.of(context).showSnackBar(
    //                           SnackBar(
    //                             content: NewSnackbar(
    //                               errortext:
    //                               'Your Order is Placed\nCheckout your Orders!\nTotal Price : $totalprice',
    //                               errorcolor: Colors.lightBlue,
    //                             ),
    //                             elevation: 0,
    //                             behavior: SnackBarBehavior.floating,
    //                             backgroundColor: Colors.transparent,
    //                           ),
    //                         );
    //
    //                       },
    //                       style: ElevatedButton.styleFrom(
    //                           backgroundColor: Colors.amber.shade700,
    //                           shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(50))),
    //                       child: const Text(
    //                         'Order',
    //                         style: TextStyle(color: textColor),
    //                       )),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
