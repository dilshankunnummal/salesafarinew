import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/presentation/authentication/login.dart';

class EditSeller extends StatefulWidget {
  const EditSeller({super.key});

  @override
  _EditSellerState createState() => _EditSellerState();
}

class _EditSellerState extends State<EditSeller> {
  final kpass = TextEditingController();
  final cpass = TextEditingController();
  final kname = TextEditingController();
  final kcname = TextEditingController();
  final kemail = TextEditingController();
  final kphone = TextEditingController();
  final kaddress = TextEditingController();
  final kpincode = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  // List<String> cnames=[]; 
  //   @override
  // void initState() {
  //   // TODO: implement initState

  //   super.initState();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        automaticallyImplyLeading: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(user!.uid)
              .snapshots(),
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
                    const SizedBox(
                      height: 5,
                    ),
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
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(100)),
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
                    buildTextField("Company Name",
                        snapshot.data!['companyname'], 2, kcname),
                    buildTextField("Company Address", snapshot.data!['address'],
                        5, kaddress),
                    buildTextField(
                        "PinCode", snapshot.data!['pincode'], 4, kpincode),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {},
                          child: const Text("CANCEL",
                              style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 2.2,
                                  color: Colors.black)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () async {
                            try {
                              final user = FirebaseAuth.instance.currentUser;
                              final store = FirebaseFirestore.instance;
                              final db = FirebaseFirestore.instance;
                              final docRef =
                                  db.collection("Users").doc(user!.uid);
                              var data;
                              await docRef.get().then(
                                (DocumentSnapshot doc) async {
                                  data =
                                      await doc.data() as Map<String, dynamic>;
                                },
                                onError: (e) =>
                                    print("Error getting document: $e"),
                              );
                              if (user != null) {
                                store.collection("Changes").doc(user.uid).set({
                                  // 'email': kemail.text,
                                  // 'password': kpass.text,
                                  'name': (kname.text.isNotEmpty)
                                      ? kname.text
                                      : snapshot.data!['name'],
                                  'phone': (kphone.text.isNotEmpty)
                                      ? kphone.text
                                      : snapshot.data!['phone'],
                                  'companyname': (kcname.text.isNotEmpty)
                                      ? kcname.text
                                      : snapshot.data!['companyname'],
                                  // 'phone': (kphone.text.isNotEmpty)
                                  //     ? kphone.text
                                  //     : data['phone'],
                                  'address': (kaddress.text.isNotEmpty)
                                      ? kaddress.text
                                      : snapshot.data!['address'],
                                  'pincode': (kpincode.text.isNotEmpty)
                                      ? kpincode.text
                                      : snapshot.data!['pincode'],
                                  'userType': 'p',
                                  'status': 'a',
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
                          child: const Text(
                            " SAVE ",
                            style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 2.2,
                                color: Colors.white),
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
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
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
                if (value!.isEmpty ||
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
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            )),
      ),
    );
  }
}
