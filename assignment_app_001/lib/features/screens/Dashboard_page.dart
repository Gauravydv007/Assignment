import 'package:assignment_app_001/features/auth/view/Login_page.dart';
import 'package:assignment_app_001/features/screens/update_page.dart';
import 'package:assignment_app_001/features/screens/user_detail_page.dart';
import 'package:assignment_app_001/features/user/user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum MenuAction {
  signUserOut,
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DatabaseReference = FirebaseDatabase.instance.reference();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController searchController = TextEditingController();
  String search = "";

  late String myEmail = '';
  late String username = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    _fetchUserDetails();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserDetails() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(firebaseUser.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          myEmail = userDoc.data()?['email'] ?? '';
          username = userDoc.data()?['username'] ?? '';

          imageUrl = userDoc.data()?['image'] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showExitConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          backgroundColor: const Color.fromARGB(255, 180, 237, 116),
          actions: [
            GestureDetector(
              onLongPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserPage()));
              },
              child: CircleAvatar(
                backgroundImage: imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl) as ImageProvider<Object>?
                    : AssetImage('assets/images/icons8-camera.png'),
              ),
            ),
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.signUserOut:
                    final shouldLogout = await showSignOutDialog(context);

                    if (shouldLogout) {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    }
                }
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<MenuAction>>[
                  PopupMenuItem<MenuAction>(
                    child: Text('Sign Out'),
                    value: MenuAction.signUserOut,
                  ),
                ];
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    search = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Search with blog title',
                  labelText: " Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: DatabaseReference,
                itemBuilder: (context, snapshot, index, animation) {
                  String name =
                      snapshot.child("name").value.toString().toLowerCase();

                  if (name.contains(search)) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          snapshot.child("name").value.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        subtitle:
                            Text(snapshot.child("mobile").value.toString()),
                        // Text(snapshot.child("address").value.toString()),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text(
                                    snapshot.child("name").value.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pincode: ${snapshot.child("pincode").value.toString()}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "Mobile: ${snapshot.child("mobile").value.toString()}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "Address: ${snapshot.child("address").value.toString()}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },

                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);

                                  updateBottomSheet(
                                    context,
                                    snapshot.child("name").value.toString(),
                                    snapshot.child("id").value.toString(),
                                    snapshot.child("mobile").value.toString(),
                                    snapshot.child("address").value.toString(),
                                    snapshot.child("pincode").value.toString(),
                                  );
                                },
                                leading: const Icon(Icons.edit),
                                title: const Text("Edit"),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  DatabaseReference.child(
                                          snapshot.child('id').value.toString())
                                      .remove();
                                },
                                leading: const Icon(Icons.delete),
                                title: const Text("Delete"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserDetailPage()),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}

Future<bool> showSignOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Sign Out'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}

Future<bool> showExitConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
