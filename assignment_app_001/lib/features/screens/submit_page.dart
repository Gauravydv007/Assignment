import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${username ?? 'Username not available'}'),
            Text('Mobile: ${mobile ?? 'Mobile not available'}'),
            Text('Address: ${address ?? 'Address not available'}'),
            Text('Pincode: ${pincode ?? 'Pincode not available'}'),
            Text(
                'Product 1 Quantity: ${product1Quantity ?? 'Quantity not available'}'),
            Text(
                'Product 2 Quantity: ${product2Quantity ?? 'Quantity not available'}'),
            // ElevatedButton(
            //   onPressed: () async {
            //     await _deleteSharedPreferencesData();
            //     // Other actions you want to perform after deleting SharedPreferences data
            //   },
            //   child: const Text('Delete SharedPreferences Data'),
            // ),
            ElevatedButton(
              onPressed: () async {
                final DatabaseReference = FirebaseDatabase.instance.reference();
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
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
