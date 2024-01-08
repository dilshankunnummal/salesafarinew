import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salesafari/core/fetchData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  List<String> emails = [];

  final formKey = GlobalKey<FormState>();
  TextEditingController kemail = TextEditingController();
  TextEditingController kpass = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const sizedBox = SizedBox(
      height: 20,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(children: [
                          SizedBox(
                            height: size.width * .2,
                          ),
                          Center(
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.lightBlue,
                              child: Icon(
                                Icons.login_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ]),
                        sizedBox,
                        Form(
                          key: formKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                return "Enter a valid Email Address";
                              } else {
                                return null;
                              }
                            },
                            controller: kemail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon:
                              const Icon(Icons.email, color: Colors.black),
                              label: const Text('Email'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        sizedBox,
                        TextFormField(
                          controller: kpass,
                          obscureText: true,
                          // validator: (value){
                          //   if(!kemail.text.contains('@'))
                          //   {
                          //     return 'Type a valid e-mail!';
                          //   }
                          // },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock_rounded,
                              color: Colors.black,
                            ),
                            label: const Text('Password'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        sizedBox,
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.lightBlue),
                          width: double.infinity,
                          height: 60.0,
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('Rejected')
                                  .get()
                                  .then((value) {
                                value.docs.forEach((element) {
                                  emails.add(element['email']);
                                  print(element['email']);
                                });
                              });

                              if (formKey.currentState!.validate()) {
                                if (kemail.text.isEmpty || kpass.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: customsnackbar(
                                        errortext:
                                        'Please Enter Your Email/Password',
                                        errorcolor: Colors.red,
                                      ),
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  );
                                } else {
                                  SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                                  if (kemail.text.isNotEmpty &&
                                      kpass.text.isNotEmpty) {
                                    try {
                                      await auth.signInWithEmailAndPassword(
                                          email: kemail.text,
                                          password: kpass.text);
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      if (user != null) {
                                        String userType =
                                        await getCurrentUserData(
                                            user, 'userType');
                                        // String status =
                                        //     await getCurrentUserData(
                                        //         user, 'status');

                                        // pref.setString('email', kemail.text);
                                        // if (status == 'a') {
                                        //account active
                                        if (userType == 'c') {
                                          pref.setString('type', 'customer');
                                          Navigator.popAndPushNamed(
                                              context, 'home');
                                        } else if (userType == 's') {
                                          pref.setString('type', 'seller');
                                          Navigator.popAndPushNamed(
                                              context, 'sellerhome');
                                        } else if (userType == 'a') {
                                          pref.setString('type', 'admin');
                                          Navigator.popAndPushNamed(
                                              context, 'adminhome');
                                        } else if (userType == 'p') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: customsnackbar(
                                                errortext:
                                                'Application Under Review\n Try Again Later',
                                                errorcolor: Colors.yellow,
                                              ),
                                              elevation: 0,
                                              behavior:
                                              SnackBarBehavior.floating,
                                              backgroundColor:
                                              Colors.transparent,
                                            ),
                                          );
                                        }
                                      }
                                    } catch (e) {
                                      print(e.toString());
                                      if (emails.contains(kemail.text)) {
                                        await FirebaseFirestore.instance
                                            .collection('Rejected')
                                            .get()
                                            .then((value) {
                                          value.docs.forEach((element) {
                                            emails.add(element['email']);
                                            print(element['email']);
                                          });
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: customsnackbar(
                                              errortext:
                                              'Your Appliation has been Rejected\nYou may reapply in future.',
                                              errorcolor: Colors.yellow,
                                            ),
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: customsnackbar(
                                              errortext: 'Wrong Email/Password',
                                              errorcolor: Colors.red,
                                            ),
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                          ),
                                        );
                                      }
                                    }
                                  }
                                }
                              }
                            },
                            child: const Text(
                              'Login',
                              style:
                              TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Not a User?'),
                            const SizedBox(
                              width: 1,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(context, 'custreg');
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.indigo, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NewSnackbar extends StatelessWidget {
  const NewSnackbar({
    Key? key,
    required this.errortext,
    required this.errorcolor,
  }) : super(key: key);

  final String errortext;
  final Color errorcolor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 90,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: errorcolor),
          child: Row(
            children: [
              const SizedBox(
                width: 48,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      errortext.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // const Spacer(),
                    // Text(
                    //   errortext,
                    //   style: const TextStyle(
                    //     fontSize: 12,
                    //     color: Colors.white,
                    //   ),
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: -20,
            left: -20,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
                child: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    },
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30,
                        ),
                        Icon(
                          Icons.cancel,
                          color: errorcolor,
                          size: 30,
                        ),
                      ],
                    )))),
      ],
    );
  }
}

class customsnackbar extends StatelessWidget {
  const customsnackbar({
    Key? key,
    required this.errortext,
    required this.errorcolor,
  }) : super(key: key);

  final String errortext;
  final Color errorcolor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 90,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: errorcolor),
          child: Row(
            children: [
              const SizedBox(
                width: 48,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Warning!'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    const Spacer(),
                    Text(
                      errortext,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: -20,
            left: -20,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
                child: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    },
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30,
                        ),
                        Icon(
                          Icons.cancel,
                          color: errorcolor,
                          size: 30,
                        ),
                      ],
                    )))),
      ],
    );
  }
}
