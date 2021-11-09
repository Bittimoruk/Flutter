import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbhelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductAdd extends StatefulWidget{
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
   return ProductAddState();
  }

}

class ProductAddState extends State{
  var dbHelper = DbHelper();

  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni ürün ekle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Ürün adı"),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Ürün açıklaması"),
      controller: txtDescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: const InputDecoration(labelText: "Ürün fiyatı"),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    return ElevatedButton(
      child: const Text("Ekle"),
      onPressed: (){
        addProduct();
        },
    );
  }

  addProduct() async {
    var result = await dbHelper.insert(Product(name: txtName.text.toString(), description: txtDescription.text.toString(), unitPrice: int.tryParse(txtUnitPrice.text)));
    Navigator.pop(context, result);
  }
}