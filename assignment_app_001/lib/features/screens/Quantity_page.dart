
import 'package:assignment_app_001/features/screens/submit_page.dart';
import 'package:flutter/material.dart';

class ProductQuantityPage extends StatefulWidget {
  const ProductQuantityPage({Key? key}) : super(key: key);

  @override
  _ProductQuantityPageState createState() => _ProductQuantityPageState();
}

class _ProductQuantityPageState extends State<ProductQuantityPage> {
  final TextEditingController product1Controller = TextEditingController();
  final TextEditingController product2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Quantity"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            DataTable(
              border: TableBorder.all(width:1
              
              ),
              columns: const < DataColumn>[
                DataColumn(
                  
                   label: Text(
                'Name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
                  
                  ),




                    DataColumn(
                  
                   label: Text(
                'Price',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
                  
                  ),

                   DataColumn(
                  
                   label: Text(
                'Qantity',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
                  
                  ),

              ],
               rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Hankerchief')),
                    DataCell(Text('1300')),
                    DataCell(
                       TextField(
              controller: product1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Pro..' ),
            ),

                    ),

            //           DataCell(
            //            TextField(
            //   controller: product2Controller,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(labelText: 'Product 2 Quantity'),
            // ),

            //         ),
                  ]
                ),

                DataRow(
                  cells: <DataCell>[

                     DataCell(Text('Apple')),
                    DataCell(Text('1400')),
                    DataCell(
                       TextField(
              controller: product2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Pro..'),
            ),

                    ),

                  ]
                  )

               ]
               
               ),

            // TextField(
            //   controller: product1Controller,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(labelText: 'Product 1 Quantity'),
            // ),
            // const SizedBox(height: 20),
            // TextField(
            //   controller: product2Controller,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(labelText: 'Product 2 Quantity'),
            // ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //Pass back the quantities to the previous screen
                Navigator.pop(context, {
                  'product1Quantity': product1Controller.text,
                  'product2Quantity': product2Controller.text,

                });

                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Test()));
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
