import 'package:assignment_app_001/features/screens/Quantity_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assignment_app_001/features/screens/submit_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:assignment_app_001/features/screens/update_page.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final DatabaseReference = FirebaseDatabase.instance.reference();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController mobilenumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  // final TextEditingController pincodeController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  Map<String, String> productQuantities = {};

  Future<void> saveOrderToFirestore(
      String orderId, Map<String, String> productQuantities) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId =
          prefs.getString('userId') ?? ''; // get this from shared prefernce

      await firestore.collection('orders').doc(orderId).set({
        'Order_id': orderId,
        'User_id': userId,
        'name': usernameController.text.toString(),
        'Address': addressController.text.toString(),
        'Pincode': pincodeController.text.toString(),
        'Order_total': calculateOrderTotal(productQuantities),
        'Order_details': [
          {
            'name': 'product1',
            'Price': 1300,
            'quality': int.parse(productQuantities['product1Quantity'] ?? '0'),
            'Total':
                1300 * int.parse(productQuantities['product1Quantity'] ?? '0'),
          },
          {
            'name': 'product2',
            'Price': 1100,
            'quality': int.parse(productQuantities['product2Quantity'] ?? '0'),
            'Total':
                1100 * int.parse(productQuantities['product2Quantity'] ?? '0'),
          },
        ],
      });
    } catch (e) {
      print('Error saving order to Firestore: $e');
    }
  }

  int calculateOrderTotal(Map<String, String> productQuantities) {
    final int product1Quantity =
        int.parse(productQuantities['product1Quantity'] ?? '0');
    final int product2Quantity =
        int.parse(productQuantities['product2Quantity'] ?? '0');

    return (1300 * product1Quantity) + (1100 * product2Quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UserDetails"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 250,
                width: 250,
                child: Lottie.asset(
                    'assets/images/Animation - 1706423759302.json'),
              ),
              SizedBox(
                height: 25,
              ),
              Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Username',
                        labelText: "Name",
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: mobilenumberController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'mobile number',
                        labelText: "Mobile",
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Address',
                        labelText: "Address",
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: pincodeController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurpleAccent),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Pincode',
                        labelText: "Pincode",
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () async {
                        final Map<String, String>? quantities =
                            await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                          return const ProductQuantityPage();
                        }));

                        // Update product quantities if returned from the product quantity page
                        if (quantities != null) {
                          setState(() async {
                            productQuantities = quantities;

                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString('quantity1',
                                quantities['product1Quantity'] ?? '');
                            prefs.setString('quantity2',
                                quantities['product2Quantity'] ?? '');

                            prefs.setString(
                                'username', usernameController.text.toString());
                            prefs.setString('mobile',
                                mobilenumberController.text.toString());
                            prefs.setString(
                                'address', addressController.text.toString());
                            prefs.setString(
                                'pincode', pincodeController.text.toString());
                          });
                        }
                      },
                      child: const Text('Add Product Quantity'),
                    ),
                    const SizedBox(height: 25),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     final id = DateTime.now().microsecond.toString();
                    //     DatabaseReference.child(id).set({
                    //       'name': usernameController.text.toString(),
                    //       'mobile': mobilenumberController.text.toString(),
                    //       'address': addressController.text.toString(),
                    //       'pincode': pincodeController.text.toString(),
                    //       'id': id,
                    //       'product1Quantity':
                    //           productQuantities['product1Quantity'],
                    //       'product2Quantity':
                    //           productQuantities['product2Quantity'],
                    //     }).catchError((error) {
                    //       print("Failed to add user: $error");
                    //     });

                    //     final prefs = await SharedPreferences.getInstance();
                    //     prefs.setString(
                    //         'username', usernameController.text.toString());
                    //     prefs.setString(
                    //         'mobile', mobilenumberController.text.toString());
                    //     prefs.setString(
                    //         'address', addressController.text.toString());
                    //     prefs.setString(
                    //         'pincode', pincodeController.text.toString());

                    //     await saveOrderToFirestore(id, productQuantities);

                    //     usernameController.clear();
                    //     mobilenumberController.clear();
                    //     addressController.clear();
                    //     pincodeController.clear();

                    //     // Navigator.push(
                    //     //     context,
                    //     //     MaterialPageRoute(
                    //     //         builder: (context) => const Test()));
                    //   },
                    //   child: ,
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
