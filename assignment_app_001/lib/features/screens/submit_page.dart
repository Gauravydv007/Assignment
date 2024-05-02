import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assignment_app_001/features/screens/Dashboard_page.dart';

class Test extends StatefulWidget {
  final DatabaseReference = FirebaseDatabase.instance.reference();
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String? username;
  String? mobile;
  String? address;
  String? pincode;
  String? product1Quantity;
  String? product2Quantity;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  _getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      mobile = prefs.getString('mobile');
      address = prefs.getString('address');
      pincode = prefs.getString('pincode');
      product1Quantity = prefs.getString('quantity1');
      product2Quantity = prefs.getString('quantity2');
    });
  }

  _deleteSharedPreferencesData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    final H = MediaQuery.sizeOf(context).height;
    final W = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 10),
                  child: Center(
                    child: Text(
                      "SUMMARY",
                      style: GoogleFonts.eczar(
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 33)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      Container(
                        height: H * 0.2,
                        width: W * 0.42,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 20.0,
                                offset: Offset(10, 7)),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.person_rounded,
                                        color: Colors.blue,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        "Username",
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        '${username ?? 'Username not available'}',
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: H * 0.2,
                        width: W * 0.42,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 20.0,
                                offset: Offset(10, 7)),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.phone_android,
                                        color: const Color.fromARGB(
                                            255, 241, 107, 98),
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        "Mobile",
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        '${mobile ?? 'Mobile not available'}',
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      Container(
                        height: H * 0.2,
                        width: W * 0.42,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 20.0,
                                offset: Offset(10, 7)),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.home,
                                        color: Colors.blue,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        "Address",
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        'Address: ${address ?? 'Address not available'}',
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: H * 0.2,
                        width: W * 0.42,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 20.0,
                                offset: Offset(10, 7)),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.numbers,
                                        color: const Color.fromARGB(
                                            255, 241, 107, 98),
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        "Pincode",
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        'Pincode: ${pincode ?? 'Pincode not available'}',
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      Container(
                        height: H * 0.2,
                        width: W * 0.42,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 20.0,
                                offset: Offset(10, 7)),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.card_giftcard,
                                        color: Colors.green,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        "Product-1",
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        'Quantity: ${product1Quantity ?? 'Quantity not available'}',
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: H * 0.2,
                        width: W * 0.42,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 20.0,
                                offset: Offset(10, 7)),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 2,
                                  sigmaY: 2,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.card_giftcard,
                                        color: const Color.fromARGB(
                                            255, 241, 107, 98),
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        "Product-2",
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16)),
                                      ),
                                      SizedBox(
                                        height: H * 0.005,
                                      ),
                                      Text(
                                        'Quantity: ${product2Quantity ?? 'Quantity not available'}',
                                        style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      final DatabaseReference =
                          FirebaseDatabase.instance.reference();
                      final id = DateTime.now().microsecond.toString();

                      DatabaseReference.child(id).set({
                        'name': username ?? 'Username not available',
                        'mobile': mobile ?? 'Mobile not available',
                        'address': address ?? 'Address not available',
                        'pincode': pincode ?? 'Pincode not available',
                        'id': id,
                        'product1Quantity':
                            product1Quantity ?? 'Quantity not available',
                        'product2Quantity':
                            product2Quantity ?? 'Quantity not available',
                      }).then((_) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                          (Route<dynamic> route) => false,
                        );
                      }).catchError((error) {
                        print("Failed to add user: $error");
                      });

                      await _deleteSharedPreferencesData();
                    },
                    child: Container(
                      height: H * 0.06,
                      width: W * 0.8,
                      decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                                color: Color.fromARGB(255, 179, 183, 186),
                                blurRadius: 20.0,
                                offset: Offset(10, 10)),
                          ],
                          color: const Color.fromARGB(255, 167, 245, 169),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text('SUBMIT',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
