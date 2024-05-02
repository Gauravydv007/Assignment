import 'package:flutter/material.dart';
import 'package:assignment_app_001/features/screens/Quantity_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController pincodeController = TextEditingController();

  final GlobalKey<FormState> _formKey =   GlobalKey<FormState>(); 
   

  Map<String, String> productQuantities = {};

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
                key: _formKey, 
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: mobilenumberController,
                      keyboardType: TextInputType.number,
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
                        hintText: 'Mobile number',
                        labelText: "Mobile",
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: pincodeController,
                      keyboardType: TextInputType.number,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your pincode';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final Map<String, String>? quantities =
                              await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                            return const ProductQuantityPage();
                          }));


                          if (quantities != null) {
                            setState(() async {
                              productQuantities = quantities;

                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('quantity1',
                                  quantities['product1Quantity'] ?? '');
                              prefs.setString('quantity2',
                                  quantities['product2Quantity'] ?? '');

                              prefs.setString('username',
                                  usernameController.text.toString());
                              prefs.setString('mobile',
                                  mobilenumberController.text.toString());
                              prefs.setString(
                                  'address', addressController.text.toString());
                              prefs.setString(
                                  'pincode', pincodeController.text.toString());
                            });
                          }
                        }
                      },
                      child: const Text('Add Product Quantity'),
                    ),
                    const SizedBox(height: 25),
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
