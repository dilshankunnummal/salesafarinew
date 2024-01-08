import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/importedTheme.dart';
import 'package:salesafari/presentation/authentication/login.dart';
import 'package:salesafari/presentation/customer/screens/user%20profile/customer_profile.dart';

// class CustEdit extends StatefulWidget {
//   const CustEdit({super.key});

//   @override
//   State<CustEdit> createState() => _CustEditState();
// }

// class _CustEditState extends State<CustEdit> {
//   @override
//   Widget build(BuildContext context) {
//   //   docRef.get().then(
//   //     (DocumentSnapshot doc) async {
//   //       data = await doc.data() as Map<String, dynamic>;
//   //     },
//   //     onError: (e) => print("Error getting document: $e"),
//   //   );

//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CustEdit(),
//     );
//   }
// }

class CustEdit extends StatefulWidget {
  const CustEdit({super.key});

  @override
  _CustEditState createState() => _CustEditState();
}

class _CustEditState extends State<CustEdit> {
  final kpass = TextEditingController();
  final cpass = TextEditingController();
  final kname = TextEditingController();
  final kcname = TextEditingController();
  final kemail = TextEditingController();
  final kphone = TextEditingController();
  final kaddress = TextEditingController();
  final kpincode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        title: Text(
          "Edit Profile",
          style: greetingTextStyle.copyWith(fontSize: 20),
        ),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: db.collection("Users").doc(user!.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }
            return Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // const Text(
                    //   "Edit Profile",
                    //   style:
                    //       TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100)),
                            // decoration: BoxDecoration(
                            //     border: Border.all(
                            //         width: 4,
                            //         color: Theme.of(context)
                            //             .scaffoldBackgroundColor),
                            //     boxShadow: [
                            //       BoxShadow(
                            //           spreadRadius: 2,
                            //           blurRadius: 10,
                            //           color: Colors.black.withOpacity(0.1),
                            //           offset: const Offset(0, 10))
                            //     ],
                            //     shape: BoxShape.circle,
                            //     image: const DecorationImage(
                            //         fit: BoxFit.cover,
                            //         image: AssetImage(
                            //             'assets/images/seller.jpg'))),
                            child: Icon(Icons.edit_note_rounded, size: 60),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    buildTextField(
                        "Full Name", snapshot.data!['name'], 2, kname),
                    buildTextField(
                        "Phone Number", snapshot.data!['phone'], 3, kphone),
                    buildTextField(
                        "PIN code", snapshot.data!['pincode'], 4, kpincode),
                    buildTextField(
                        "Address", snapshot.data!['address'], 5, kaddress),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                          onPressed: () {},
                          child: Text("CANCEL",
                              style: buttonTextStyle.copyWith(color: Colors.black)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            try {
                              final user = FirebaseAuth.instance.currentUser;
                              final store = FirebaseFirestore.instance;
                              final db = FirebaseFirestore.instance;
                              final docRef =
                                  db.collection("Users").doc(user!.uid);
                              var data;
                              docRef.get().then(
                                (DocumentSnapshot doc) async {
                                  data =
                                      await doc.data() as Map<String, dynamic>;
                                },
                                onError: (e) =>
                                    print("Error getting document: $e"),
                              );
                              if (user != null) {
                                store.collection("Users").doc(user.uid).set({
                                  'email' : snapshot.data!['email'],
                                  'password': snapshot.data!['password'],
                                  // 'email': kemail.text,
                                  // 'password': kpass.text,
                                  'name': (kname.text.isNotEmpty)
                                      ? kname.text
                                      : snapshot.data!['name'],
                                  'phone': (kphone.text.isNotEmpty)
                                      ? kphone.text
                                      : snapshot.data!['phone'],
                                  'address': (kaddress.text.isNotEmpty)
                                      ? kaddress.text
                                      : snapshot.data!['address'],
                                  'pincode': (kpincode.text.isNotEmpty)
                                      ? kpincode.text
                                      : snapshot.data!['pincode'],
                                  'userType': 'c',
                                  'change_datetime': DateTime.now()
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: customsnackbar(
                                      errortext:
                                          'Your changes will be updated after reviewing',
                                      errorcolor: Colors.yellow,
                                    ),
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                  ),
                                );
                              }
                            } catch (e) {
                              print(e);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: customsnackbar(
                                    errortext: 'An Error Occured : $e',
                                    errorcolor: Colors.yellow,
                                  ),
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                ),
                              );
                            }
                          },
                          child: Text(
                            " SAVE ",
                            style: buttonTextStyle.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, int type, TextEditingController t) {
    // 0=password
    // 1=email
    // 2=name
    // 3=phone
    // 4=pin
    // 5=address/undefined
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          style: facilityTextStyle,
          controller: t,
          validator: (value) {
            switch (type) {
              case 0:
                break;
              case 1:
                {
                  if (value!.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return "Enter Correct Email Address";
                  } else {
                    return null;
                  }
                }
                break;
              case 2:
                {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    //allow upper and lower case alphabets and space
                    return "Enter Correct Name";
                  } else {
                    return null;
                  }
                }
                break;
              case 3:
                {
                  if (value!.isNotEmpty ||
                      !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                          .hasMatch(value)) {
                    //  r'^[0-9]{10}$' pattern plain match number with length 10
                    return "Enter Correct Phone Number";
                  } else {
                    return null;
                  }
                }
                break;
              case 4:
                {
                  if (value!.isEmpty ||
                      !RegExp(r'^[6][0-9]{5}$').hasMatch(value)) {
                    //  r'^[0-9]{10}$' pattern plain match number with length 10
                    return "Enter a valid PIN code";
                  } else {
                    return null;
                  }
                }
                break;

              default:
                return null;
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: 3),
              labelText: labelText,
              labelStyle: subTitleTextStyle,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: facilityTextStyle),
        ),
      ),
    );
  }
}
