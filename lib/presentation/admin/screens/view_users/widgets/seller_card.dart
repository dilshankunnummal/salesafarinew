import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/Colors.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salesafari/presentation/testdetails.dart';

class SellerCard extends StatelessWidget {
  final DocumentSnapshot passingdocument;

  SellerCard({Key? key, required this.passingdocument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ExpansionTile(
          leading: const CircleAvatar(
            radius: 40,
            child: Icon(Icons.currency_rupee_outlined),
          ),
          title: Text(
            '${passingdocument['name']}'.toUpperCase(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          subtitle: Text("${passingdocument['companyname']}"),
          children: [
            buildCustomerDetails(context),
          ],
        ),
      ),
    );
  }

  Widget buildCustomerDetails(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(
                label: Text(
                  'Field',
                  style: TextStyle(fontSize: 20, color: Colors.lightBlue),
                ),
              ),
              DataColumn(
                label: Text(
                  'Details',
                  style: TextStyle(fontSize: 20, color: Colors.lightBlue),
                ),
              ),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text(
                    'Full Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                  DataCell(Text(passingdocument['name'])),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text(
                    'Company Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                  DataCell(Text(passingdocument['companyname'])),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text(
                    'Address',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                  DataCell(
                    Text(
                      passingdocument['address'],
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text(
                    'PIN Code',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                  DataCell(Text(passingdocument['pincode'])),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text(
                    'Email ID',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                  DataCell(Text(passingdocument['email'])),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text(
                    'Phone No',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                  DataCell(Text(passingdocument['phone'])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildButton(
          label: 'Remove Customer',
          icon: Icons.close,
          color: Colors.red,
          onPressed: () {
            // set user type to removed customer
            // store.collection("Users").doc(passingdocument.id).update({
            //     'userType':'rc'})
          },
        ),
        buildButton(
          label: 'View Orders',
          icon: Icons.shopping_cart_outlined,
          color: Colors.blue,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(color),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
