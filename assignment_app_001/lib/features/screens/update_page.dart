import 'package:assignment_app_001/features/screens/Dashboard_page.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

final TextEditingController usernameController = TextEditingController();
final TextEditingController mobileController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final TextEditingController pincodeController = TextEditingController();

final DatabaseReference = FirebaseDatabase.instance.reference();

void updateBottomSheet(
    BuildContext context, name, id, mobile, address, pincode) {
  usernameController.text = name;
  mobileController.text = mobile;
  addressController.text = address;
  pincodeController.text = pincode;
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
                  labelText: "Mobile",
                  hintText: "mobile",
                ),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  hintText: "address",
                ),
              ),
              TextField(
                controller: pincodeController,
                decoration: const InputDecoration(
                  labelText: "Pincode",
                  hintText: "pincode",
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
                      'pincode': pincodeController.text.toString(),
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("Update"))
            ],
          ),
        );
      });
}
