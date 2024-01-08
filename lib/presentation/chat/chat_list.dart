import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:salesafari/presentation/chat/chat_message_page.dart';

import '../../core/colors/importedTheme.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;

    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(

        elevation: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Recent Chats', style: greetingTextStyle.copyWith(fontSize: 20),),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage('https://img.freepik.com/premium-vector/abstract-grunge-surface-texture-background_54178-1887.jpg?w=2000'),fit: BoxFit.fill)
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Messages')
                .where('fromId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, fromSnapshot) {
              if (fromSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Messages')
                      .where('toId',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, toSnapshot) {
                    if (toSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (toSnapshot.hasError) {
                      return Text('Error:${toSnapshot.error}');
                    }
                    if (fromSnapshot.hasError) {
                      return Text('Error:${fromSnapshot.error}');
                    }
                    List<String> chattedUsers = [];
                    if (toSnapshot.data == null && fromSnapshot.data == null) {
                      chattedUsers = [];
                    } else if (fromSnapshot.data == null) {
                      toSnapshot.data!.docs.forEach((doc) {
                        if (!chattedUsers.contains(doc['fromId'])) {
                          chattedUsers.add(doc['fromId']);
                        }
                      });
                    } else if (toSnapshot.data == null) {
                      fromSnapshot.data!.docs.forEach((doc) {
                        if (!chattedUsers.contains(doc['toId'])) {
                          chattedUsers.add(doc['toId']);
                        }
                      });
                    } else {
                      toSnapshot.data!.docs.forEach((doc) {
                        if (!chattedUsers.contains(doc['fromId'])) {
                          chattedUsers.add(doc['fromId']);
                        }
                      });
                      fromSnapshot.data!.docs.forEach((doc) {
                        if (!chattedUsers.contains(doc['toId'])) {
                          chattedUsers.add(doc['toId']);
                        }
                      });
                    }

                    if (chattedUsers.isEmpty) {
                      return Center(
                          child: Lottie.asset('assets/lottie/empty_box.json',
                              width: size.width * .75));
                    }

                    return ListView.builder(
                      itemCount: chattedUsers.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(chattedUsers[index])
                              .snapshots(),
                          builder: (context, userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            String name = userSnapshot.data!['name'];
                            //String img = userSnapshot.data!['proof_image'];
                            // if(userSnapshot.data!['profileImage']!=''){
                            //       img=userSnapshot.data!['profileImage'];
                            // }
                            DocumentSnapshot? document = userSnapshot.data;
                            // String profileImage =
                            //     userSnapshot.data?['profileImage'];

                            return StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Messages')
                                  .where('fromId', isEqualTo: chattedUsers[index])
                                  .where('toId', isEqualTo: user!.uid)
                                  .orderBy('time', descending: true)
                                  .limit(1)
                                  .snapshots(),
                              builder: (context, lastMessageSnapshot) {
                                if (lastMessageSnapshot.hasError) {
                                  print(lastMessageSnapshot.error);
                                }
                                if (lastMessageSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                String lastMessage = '';
                                // String time='';
                                // String img=''
                                if (lastMessageSnapshot.data!.docs.isNotEmpty) {
                                  lastMessage = lastMessageSnapshot
                                      .data!.docs.first['messageText'];
                                }


                                return Padding(
                                  padding: const EdgeInsets.only(right: 16, left: 16, bottom: 10, top: 20),
                                  child: Card(
                                    elevation: 10,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatMessagePage(
                                                  id: chattedUsers[index],
                                                  passingdocument: document!),
                                            ));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        width: width/1.5,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0), color: colorWhite),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(borderRadiusSize),
                                              child: CircleAvatar(
                                                child: Icon(Icons.person_outline_rounded),
                                              ),
                                            ),
                                            const SizedBox(width: 8,),
                                            Flexible(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    name,
                                                    maxLines: 1,
                                                    style: subTitleTextStyle,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 8,),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      const SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          lastMessage,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: addressTextStyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );

                                // return ListTile(
                                //   title: Text(name),
                                //   leading: CircleAvatar(
                                //     child: Icon(
                                //       Icons.person,
                                //       size: 25,
                                //     ),
                                //   ),
                                //   subtitle: Text(lastMessage),
                                //   onTap: () {
                                //
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => ChatMessagePage(
                                //               id: chattedUsers[index],
                                //               passingdocument: document!),
                                //         ));
                                //     // navigate to chat screen for the selected user
                                //   },
                                // );
                              },
                            );
                          },
                        );
                      },
                    );
                  });
            }),
      ),
    );
  }
}
