import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbhelper.dart';
import 'package:sqflite_demo/models/product.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State{
  var dbHelper = DbHelper();
  late List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        child: const Icon(Icons.add),
        tooltip: "Yeni ürün ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.cyan,
          elevation: 2.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.black12,
              child: Text("P"),
            ),
            title: Text((products[position].name).toString()),
            subtitle: Text((products[position].description).toString()),
            onTap: (){
              goToDetail(products[position]);
              },
          ),
        );
      },
    );
  }

  void goToProductAdd() async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProductAdd()));
    if(result != 0 && result != null) {
      getProducts();
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data){
      setState(() {
        products = data;
        productCount = data.length;
      });
    });
  }

  void goToDetail(Product product) async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product)));
    if(result != 0 && result != null) {
      getProducts();
    }
  }

}