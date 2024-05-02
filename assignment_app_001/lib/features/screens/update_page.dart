import 'package:assignment_app_001/features/screens/Dashboard_page.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

final TextEditingController usernameController = TextEditingController();
final TextEditingController mobileController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final DatabaseReference = FirebaseDatabase.instance.reference();

void updateBottomSheet(BuildContext context, name, id, mobile, address) {
  usernameController.text = name;
  mobileController.text = mobile;
  addressController.text = address;
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.blue[100],
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Create your items",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "eg.Elon",
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: mobileController,
                decoration: const InputDecoration(
                  labelText: "S.N",
                  hintText: "eg.1",
                ),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  hintText: "eg.UK",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    DatabaseReference.child(id).update({
                      'name': usernameController.text.toString(),
                      'mobile': mobileController.text.toString(),
                      'address': addressController.text.toString(),
                    });


                    Navigator.pop(context);

                    //          Navigator.push(
                    // context,
                    // MaterialPageRoute(builder: (context) => SecondPage(userId: '', pincode: '', userName: '', address: '', orderId: '', orderTotal:int.fromEnvironment(name) )));
                  },
                  child: const Text("Update"))
            ],
          ),
        );
      });
}
