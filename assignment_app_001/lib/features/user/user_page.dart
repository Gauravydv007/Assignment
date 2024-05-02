import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late String myEmail = '';
  late String username = '';
  late String imageUrl = '';
  late String userImageUrl;

  File? imageXFile;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    final H = MediaQuery.sizeOf(context).height;
    final W = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl),
                              radius: 50,
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 165,
                      width: 165,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                      child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, Object, Stack) {
                                  return Container(
                                    child: Icon(Icons.error_outline,
                                        color: Colors.amber),
                                  );
                                },
                              )
                            : Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -12,
                  right: 100,
                  child: IconButton(
                    onPressed: _pickImage,
                    icon: Icon(Icons.edit),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                height: H * 0.07,
                width: W * 0.92,
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                          color: Color.fromARGB(255, 179, 183, 186),
                          blurRadius: 20.0,
                          offset: Offset(10, 10)),
                    ],
                    color: Color.fromARGB(255, 240, 213, 245),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Username : $username',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: H * 0.07,
                  width: W * 0.92,
                  decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                            color: Color.fromARGB(255, 179, 183, 186),
                            blurRadius: 20.0,
                            offset: Offset(10, 10)),
                      ],
                      color: Color.fromARGB(255, 240, 213, 245),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Email : $myEmail',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageXFile = File(pickedImage.path);
      });
      _updateImageInFirestore();
    }
  }

  void _updateImageInFirestore() async {
    if (imageXFile != null) {
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child("images").child(fileName);
      UploadTask uploadTask = reference.putFile(imageXFile!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      userImageUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'image': userImageUrl,
      });
      setState(() {
        imageUrl = userImageUrl;
      });
    }
  }

  Future<void> _fetch() async {
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
}
