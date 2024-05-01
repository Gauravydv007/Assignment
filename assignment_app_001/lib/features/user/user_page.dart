// // import 'dart:io';
// // import 'dart:ui';

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_storage/firebase_storage.dart' as fStorage;


// // class UserPage extends StatefulWidget {
// //   const UserPage({super.key});

// //   @override
// //   State<UserPage> createState() => _UserPageState();
// // }

// // class _UserPageState extends State<UserPage> {
// //   late String myEmail;
// //   late String username;
// //   late String imageUrl;
// //   String? userImageUrl;





// // File? imageXFile;
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetch(); // Call the fetch method to get the user data and image URL
// //   }

// //   @override
// //   void setState(VoidCallback fn) {
// //     _updateImageInFirestore();
// //     super.setState(fn);
// //   }


// //  void _updateImageInFirestore() async {
// //   String fileName = DateTime.now().microsecondsSinceEpoch.toString();
// //   fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref()
// //   .child("images").child(fileName);
// //   fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
// //   fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
// //   await taskSnapshot.ref.getDownloadURL().then((url) async{
// //     userImageUrl = url;
     
// //   });

// //   await FirebaseFirestore.instance.collection("user")
// //   .doc(FirebaseAuth.instance.currentUser!.uid)
// //   .update(
// //     {
// //       'image' : userImageUrl,
// //     }
// //   );

// //  }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('User'),

// //       ),
// //       body: Center(
// //         child: FutureBuilder(
// //             future: _fetch(),
// //             builder: (context, snapshot) {
// //               if (snapshot.connectionState != ConnectionState.done)
// //                 return Text('Loading data....');
// //               return Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [

// //                      Center(
// //                 child: GestureDetector(
// //                   onTap: (){
// //                     showDialog(context: context, builder: (context) {
// //                       return Container(
// //                         child: CircleAvatar(backgroundImage: NetworkImage(imageUrl),radius: 50,),
// //                       );
// //                     },);
// //                   },
// //                   child: Container(
// //                     height: 130,
// //                     width: 130,
// //                     decoration: BoxDecoration(
// //                       shape: BoxShape.circle,
// //                       border: Border.all(
// //                         color: Colors.black,
// //                       )
// //                     ),
// //                     child: ClipRRect(
// //                       borderRadius: BorderRadius.circular(100),
// //                       child: imageUrl.isNotEmpty
// //                        ? Image.network(imageUrl ,
// //                         fit: BoxFit.cover,
                        
// //                         loadingBuilder: (context, child , loadingProgress){
// //                           if(loadingProgress == null) return child ;
// //                           return Center(child: CircularProgressIndicator(),);
// //                         },
// //                         errorBuilder: (context ,Object, Stack){
// //                           return Container(
// //                             child: Icon(Icons.error_outline, color: Colors.amber,),
// //                           );
// //                         }
// //                                    ): Center(child: CircularProgressIndicator(),)
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 20,),


// //                   SizedBox(
// //                     child: Card(
// //                       elevation: 12,
// //                       shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(16.0)),
// //                       child: ClipRRect(
// //                           borderRadius: BorderRadius.circular(16),
// //                           child: BackdropFilter(
// //                               filter: ImageFilter.blur(
// //                                 sigmaX: 10,
// //                                 sigmaY: 10,
// //                               ),
// //                               child: Padding(
// //                                 padding: EdgeInsets.all(16.0),
// //                                 child: Text('Username : $username',
// //                                 style: TextStyle(fontSize: 20),
// //                                 )
// //                                 ))),
// //                     ),
// //                   ),

// //                      SizedBox(
// //                     child: Card(
// //                       elevation: 12,
// //                       shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(16.0)),
// //                       child: ClipRRect(
// //                           borderRadius: BorderRadius.circular(16),
// //                           child: BackdropFilter(
// //                               filter: ImageFilter.blur(
// //                                 sigmaX: 10,
// //                                 sigmaY: 10,
// //                               ),
// //                               child: Padding(
// //                                 padding: EdgeInsets.all(16.0),
// //                                 child: Text(
// //                                   'Email : $myEmail', style: TextStyle(fontSize: 19),
// //                                 ),
// //                                 ),
// //                                 )),
// //                     ),
// //                   ),

// //                   // SizedBox(height: 20),
// //                   // Card(child: Text('Email : $myEmail')),
// //                 ],
// //               );
// //             }),
// //       ),
// //     );
// //   }

// // //   _fetch() async {

// // //     final firebaseUser = await FirebaseAuth.instance.currentUser();
// // //     if(firebaseUser!=null)
// // //     await Firestore.instance.collection('user').document(firebaseUser.uid).get().then((ds){
// // //       myEmail =ds.data['email'];;
// // //     });
// // //   }
// // // }

// //   _fetch() async {
// //     final firebaseUser = FirebaseAuth.instance.currentUser;
// //     if (firebaseUser != null) {
// //       final userDoc = await FirebaseFirestore.instance
// //           .collection('user')
// //           .doc(firebaseUser.uid)
// //           .get();
// //       if (userDoc.exists) {
// //         myEmail = userDoc.data()?['email'] ?? '';
// //         username = userDoc.data()?['username'] ?? "";
// //          imageUrl = userDoc.data()?['image'] ?? ''; // Get the image URL from Firestore
// //         print(myEmail);
// //         final usernameFromFirestore = userDoc.data()?['username'];
// //         print(
// //             'Username stored in Firestore: $usernameFromFirestore'); // Print the username
// //       }
// //     }
// //   }
// // }










// import 'dart:io';
// import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class UserPage extends StatefulWidget {
//   const UserPage({Key? key}) : super(key: key);

//   @override
//   State<UserPage> createState() => _UserPageState();
// }

// class _UserPageState extends State<UserPage> {
//   late String myEmail;
//   late String username;
//   late String imageUrl = '';
//   late String userImageUrl; // Declare userImageUrl here

//   File? imageXFile;

//   @override
//   void initState() {
//     super.initState();
//     _fetch(); // Call the fetch method to get the user data and image URL
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: GestureDetector(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return Container(
//                         child: CircleAvatar(
//                           backgroundImage: NetworkImage(imageUrl),
//                           radius: 50,
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 child: Container(
//                   height: 130,
//                   width: 130,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: Colors.black,
//                     ),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(100),
//                     child: imageUrl.isNotEmpty
//                         ? Image.network(
//                             imageUrl,
//                             fit: BoxFit.cover,
//                             loadingBuilder: (context, child, loadingProgress) {
//                               if (loadingProgress == null) return child;
//                               return Center(child: CircularProgressIndicator());
//                             },
//                             errorBuilder: (context, Object, Stack) {
//                               return Container(
//                                 child: Icon(Icons.error_outline, color: Colors.amber),
//                               );
//                             },
//                           )
//                         : Center(child: CircularProgressIndicator()),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             SizedBox(
//               child: Card(
//                 elevation: 12,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(
//                       sigmaX: 10,
//                       sigmaY: 10,
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Text(
//                         'Username : $username',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               child: Card(
//                 elevation: 12,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(
//                       sigmaX: 10,
//                       sigmaY: 10,
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Text(
//                         'Email : $myEmail',
//                         style: TextStyle(fontSize: 19),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Edit Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _pickImage() async {
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         imageXFile = File(pickedImage.path);
//       });
//       _updateImageInFirestore();
//     }
//   }

//   void _updateImageInFirestore() async {
//     if (imageXFile != null) {
//       String fileName = DateTime.now().microsecondsSinceEpoch.toString();
//       Reference reference = FirebaseStorage.instance.ref().child("images").child(fileName);
//       UploadTask uploadTask = reference.putFile(imageXFile!);
//       TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
//       userImageUrl = await taskSnapshot.ref.getDownloadURL();

//       await FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser!.uid).update({
//         'image': userImageUrl,
//       });
//       setState(() {
//         imageUrl = userImageUrl;
//       });
//     }
//   }

//   Future<void> _fetch() async {
//     final firebaseUser = FirebaseAuth.instance.currentUser;
//     if (firebaseUser != null) {
//       final userDoc = await FirebaseFirestore.instance.collection('user').doc(firebaseUser.uid).get();
//       if (userDoc.exists) {
//         setState(() {
//           myEmail = userDoc.data()?['email'] ?? '';
//           username = userDoc.data()?['username'] ?? '';
//           imageUrl = userDoc.data()?['image'] ?? '';
//         });
//       }
//     }
//   }
// }




import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductQuantity {
  final String name;
  final int quantity;

  ProductQuantity(this.name, this.quantity);
}

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final usernameController = TextEditingController();
  final mobilenumberController = TextEditingController();
  final addressController = TextEditingController();
  final pincodeController = TextEditingController();

  final TextEditingController product1Controller = TextEditingController();
  final TextEditingController product2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserDetails"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'UserName',
                      labelText: "UserName",
                    ),
                  ),
                  TextFormField(
                    controller: mobilenumberController,
                    decoration: InputDecoration(
                      hintText: 'MobileNumber',
                      labelText: "MobileNumber",
                    ),
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      labelText: "Address",
                    ),
                  ),
                  TextFormField(
                    controller: pincodeController,
                    decoration: InputDecoration(
                      hintText: 'Pincode',
                      labelText: "Pincode",
                    ),
                  ),
                  TextFormField(
                    controller: product1Controller,
                    decoration: InputDecoration(
                      hintText: 'Product 1 Quantity',
                      labelText: "Product 1 Quantity",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: product2Controller,
                    decoration: InputDecoration(
                      hintText: 'Product 2 Quantity',
                      labelText: "Product 2 Quantity",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    // Get input values
    String username = usernameController.text;
    String mobileNumber = mobilenumberController.text;
    String address = addressController.text;
    String pincode = pincodeController.text;

    // Store product quantities in Hive
    await Hive.box<ProductQuantity>('product_quantities').put('product1', ProductQuantity('product1', int.parse(product1Controller.text)));
    await Hive.box<ProductQuantity>('product_quantities').put('product2', ProductQuantity('product2', int.parse(product2Controller.text)));

    // Navigate to the third page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ThirdPage(
          username: username,
          mobileNumber: mobileNumber,
          address: address,
          pincode: pincode,
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  final String username;
  final String mobileNumber;
  final String address;
  final String pincode;

  ThirdPage({
    required this.username,
    required this.mobileNumber,
    required this.address,
    required this.pincode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Username: $username"),
          Text("Mobile Number: $mobileNumber"),
          Text("Address: $address"),
          Text("Pincode: $pincode"),
          SizedBox(height: 20),
          Text("Product Quantities:"),
          SizedBox(height: 10),
          ValueListenableBuilder<Box<ProductQuantity>>(
            valueListenable: Hive.box<ProductQuantity>('product_quantities').listenable(),
            builder: (context, box, _) {
              List<ProductQuantity> productQuantities = box.values.toList();
              return DataTable(
                columns: [
                  DataColumn(label: Text('Product')),
                  DataColumn(label: Text('Quantity')),
                ],
                rows: productQuantities
                    .map((productQuantity) => DataRow(cells: [
                          DataCell(Text(productQuantity.name)),
                          DataCell(Text(productQuantity.quantity.toString())),
                        ]))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

