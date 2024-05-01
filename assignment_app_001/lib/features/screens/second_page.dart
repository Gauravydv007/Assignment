// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class Product {
//   String name;
//   int price;
//   int quantity;
  
//   Product({required this.name, required this.price, required this.quantity});
// }

// class SecondPage extends StatefulWidget {
//   final String userId;
//   final String orderId;
//   final String userName;
//   final String address;
//   final String pincode;
//   final int orderTotal;

//   SecondPage({
//     required this.userId,
//     required this.orderId,
//     required this.userName,
//     required this.address,
//     required this.pincode,
//     required this.orderTotal,
//   });

//   @override
//   _SecondPageState createState() => _SecondPageState();
// }

// class _SecondPageState extends State<SecondPage> {
//   final List<Product> products = [
//     Product(name: 'Product 1', price: 1300, quantity: 0),
//     Product(name: 'Product 2', price: 1100, quantity: 0),

//   ];

//   DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

//   void _submitOrder() {
//     Map<String, dynamic> orderData = {
//       'Order_id': widget.orderId,
//       'User_id': widget.userId,
//       'name': widget.userName,
//       'Address': widget.address,
//       'Pincode': widget.pincode,
//       'Order total': widget.orderTotal,
//       'Order details': products.map((product) {
//         return {
//           'name': product.name,
//           'Price': product.price,
//           'quantity': product.quantity,
//           'Total': product.price * product.quantity,
//         };
//       }).toList(),
//     };

//     _databaseReference.child('orders').push().set(orderData).then((value) {
//       // Handle success
//       print('Order submitted successfully');
//     }).catchError((error) {
//       // Handle error
//       print('Failed to submit order: $error');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Quantities'),
//       ),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(products[index].name),
//             subtitle: Text('Price: \$${products[index].price}'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.remove),
//                   onPressed: () {
//                     setState(() {
//                       if (products[index].quantity > 0) {
//                         products[index].quantity--;
//                       }
//                     });
//                   },
//                 ),
//                 Text('${products[index].quantity}'),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     setState(() {
//                       products[index].quantity++;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _submitOrder,
//         child: Icon(Icons.check),
//       ),
//     );
//   }
// }
