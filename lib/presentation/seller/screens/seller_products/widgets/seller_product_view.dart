import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:salesafari/core/colors/Colors.dart';
import 'package:salesafari/presentation/seller/screens/seller_products/widgets/editproduct.dart';
import 'package:salesafari/presentation/user_model.dart';

import '../../../../../core/colors/importedTheme.dart';
import '../../../../authentication/login.dart';

class SellerProductView extends StatelessWidget {
  SellerProductView({super.key,required this.passingdocument});
  DocumentSnapshot passingdocument;
  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 20,
    );

    final size = MediaQuery.of(context).size;
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
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => EditProductForm(
              productId: passingdocument.id,
            ),
          ));

        }, child: Text('Edit Product'),
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

                    imageUrl: passingdocument['image_url'],
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
                              Text(passingdocument['product_name'], style: greetingTextStyle,),
                            ]),
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
                                child: Text(passingdocument['description'], style: normalTextStyle, overflow: TextOverflow.ellipsis, maxLines: 10,),
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
                            Text('Rs.${passingdocument['product_price']}', style: normalTextStyle,),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Icon(Icons.star, size: 20, color: Colors.blueAccent,),
                            SizedBox(width: 10,),
                            Text('${passingdocument['rating'].toStringAsFixed(1)} (${passingdocument['rating_count']} Ratings)', style: normalTextStyle,),
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
  }
}
