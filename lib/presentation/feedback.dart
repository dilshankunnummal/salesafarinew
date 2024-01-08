import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/importedTheme.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackBox extends StatelessWidget {
  final cmail=Uri.parse('mailto:salesafariecommerce@gmail.com');
  final cphone=Uri.parse('tel:+91 8891160597');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Feedback',style: greetingTextStyle.copyWith(fontSize: 20),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    launchUrl(
                      cmail
                    );
                  },
                  child: _buildContactButton(
                    icon: Icons.email,
                    text: 'Email',
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    launchUrl(cphone);
                  },
                  child: _buildContactButton(
                    icon: Icons.phone,
                    text: 'Phone',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                _buildContactField(
                  label: 'Email',
                  value: 'salesafariecommerce@gmail.com',
                ),
                _buildContactField(
                  label: 'Phone',
                  value: '+91 9061702785',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.black,
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: facilityTextStyle.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactField({required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: priceTextStyle,
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: facilityTextStyle,
          ),
        ],
      ),
    );
  }
}
