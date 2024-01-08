import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/Colors.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salesafari/presentation/testdetails.dart';

class FeedbackCard extends StatelessWidget {
  DocumentSnapshot passingdocument;
  FeedbackCard({Key? key, required this.passingdocument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var name = (passingdocument['name']);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(8),
          childrenPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          leading: const CircleAvatar(radius: 40, child: Icon(Icons.person)),
          title: Text(
            "User Name : ${passingdocument['name']}",
            style: textStyleHead,
          ),
          subtitle: Text(
            'Title : ${passingdocument['companyname']}',
            style: textStyleSubhead,
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Feedback : ${passingdocument['address']}',
              style: subTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
