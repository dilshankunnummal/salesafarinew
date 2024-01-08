import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salesafari/presentation/authentication/login.dart';
import 'package:salesafari/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/colors/importedTheme.dart';

final user = FirebaseAuth.instance.currentUser;
final db = FirebaseFirestore.instance;
final docRef = db.collection("Users").doc(user!.uid);
var data;


class CustProfilePage extends StatelessWidget {
  const CustProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    print(user!.email);
    return Scaffold(
      backgroundColor: backgroundColor,
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
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: db.collection("Users").doc(user!.uid).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Text(
                            "Account",
                            style: subTitleTextStyle.copyWith(color: primaryColor500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 75,
                                  height: 75,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage("assets/images/user_profile_example.png",),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!['name'],
                                      style: subTitleTextStyle,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, 'editcust');
                                        //_showSnackBar(context, "You are using the beta verion of the app");
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: primaryColor100.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: primaryColor500)),
                                          child: Text(
                                            'Edit profile',
                                            style: descTextStyle.copyWith(
                                                color: primaryColor500),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),

                          InkWell(
                            onTap: () {},//launch("https://github.com/mikirinkode"),
                            splashColor: primaryColor100,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: Icon(Icons.mail, color: darkBlue300, size: 30, ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Email",
                                          style: normalTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          snapshot.data!['email'],
                                          style: descTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {},//launch("https://github.com/mikirinkode"),
                            splashColor: primaryColor100,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: Icon(Icons.phone, color: darkBlue300, size: 30, ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Phone",
                                          style: normalTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          snapshot.data!['phone'],
                                          style: descTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {},//launch("https://github.com/mikirinkode"),
                            splashColor: primaryColor100,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: Icon(FontAwesomeIcons.addressBook, color: darkBlue300, size: 30, ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Address",
                                          style: normalTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          snapshot.data!['address'],
                                          style: descTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {},//launch("https://github.com/mikirinkode"),
                            splashColor: primaryColor100,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: Icon(CupertinoIcons.pin, color: darkBlue300, size: 30, ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "PIN code",
                                          style: normalTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          snapshot.data!['pincode'],
                                          style: descTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'feedback');
                            },//launch("https://github.com/mikirinkode"),
                            splashColor: primaryColor100,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: Icon(Icons.feedback, color: darkBlue300, size: 30, ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Feedback",
                                          style: normalTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Tap to send feedback',
                                          style: descTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();

                              final pref = await SharedPreferences.getInstance();
                              await pref.clear();
                              Navigator.pushAndRemoveUntil<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          ScreenSplash()),
                                  ModalRoute.withName('/'));
                              //_onLogoutPressed();
                            },
                            splashColor: primaryColor100,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: Icon(Icons.logout_rounded, color: darkBlue300, size: 30, ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Log out",
                                          style: normalTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Tap to log out from your account",
                                          style: descTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 32,
                          ),

                          Text(
                            "Credits",
                            style: subTitleTextStyle.copyWith(color: primaryColor500),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'aboutus');
                            },
                            splashColor: primaryColor100,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: const Icon(
                                      CupertinoIcons.group,
                                      size: 24,
                                      color: darkBlue300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Developers",
                                          overflow: TextOverflow.visible,
                                          style: normalTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Tap to view developers",
                                          style: descTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},//launch("https://github.com/mikirinkode"),
                            splashColor: primaryColor100,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: Image.asset(
                                      "assets/icon/github.png",
                                      color: darkBlue300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Github",
                                          style: normalTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "github.com/salesafari",
                                          style: descTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {},//launch("https://github.com/mikirinkode"),
                            splashColor: primaryColor100,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: FaIcon(FontAwesomeIcons.instagram, color: darkBlue300, size: 30, ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Instagram",
                                          style: normalTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "instagram.com/salesafari",
                                          style: descTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},//launch("https://github.com/mikirinkode"),
                            splashColor: primaryColor100,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: Icon(CupertinoIcons.paperplane_fill, color: darkBlue300,),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Twitter",
                                          style: normalTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "twitter.com/salesafari",
                                          style: descTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            "About App",
                            style: subTitleTextStyle.copyWith(color: primaryColor500),
                          ),
                          InkWell(
                            onTap: () {
                              //_showSnackBar(context, "Newest Version");
                            },
                            splashColor: primaryColor100,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: colorWhite),
                                    child: const Icon(
                                      CupertinoIcons.info_circle_fill,
                                      size: 24,
                                      color: darkBlue300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "SaleSafari E-Commerce App",
                                          style: normalTextStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Version 1.0.0",
                                          style: descTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),


                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Created with ",
                                style: normalTextStyle,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "{code}",
                                style: subTitleTextStyle.copyWith(color: primaryColor500),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "and",
                                style: normalTextStyle,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Icon(
                                Icons.favorite_rounded,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
