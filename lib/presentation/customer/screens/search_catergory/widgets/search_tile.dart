import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/importedTheme.dart';

class SearchTile extends StatelessWidget {
  SearchTile({super.key, required this.passingdocument});
  DocumentSnapshot passingdocument;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 10, top: 10),
      child: Material(
        elevation: 0.5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 100,
          width: width/1.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: colorWhite),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius:
                BorderRadius.circular(10),
                child: Image.network(passingdocument['image_url'],
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover),
              ),
              const SizedBox(width: 8,),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      passingdocument['product_name'],
                      maxLines: 1,
                      style: subTitleTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            'Rs. ${passingdocument['product_price']} ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: addressTextStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Spacer(),
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
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
