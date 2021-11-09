import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbhelper.dart';
import 'package:sqflite_demo/models/product.dart';

//ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductDetailState(product);
  }

enum Options { delete, update }

class _ProductDetailState extends State {
  Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    txtName.text = product.name.toString();
    txtDescription.text = product.description.toString();
    txtUnitPrice.text = product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün detayı : ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
              onSelected: selectProcess,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
                    const PopupMenuItem<Options>(
                      value: Options.delete,
                      child: Text("Sil"),
                    ),
                    const PopupMenuItem<Options>(
                      value: Options.update,
                      child: Text("Güncelle"),
                    )
                  ])
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
        ],
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

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product.withId(
            id: int.tryParse(product.id.toString()),
            name: txtName.text.toString(),
            description: txtDescription.text.toString(),
            unitPrice: int.tryParse(txtUnitPrice.text)));
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}
