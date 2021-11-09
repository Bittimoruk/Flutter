class Product{
  int? id;
  String? name;
  String? description;
  int? unitPrice;

  Product({required this.name, required this.description, required this.unitPrice});
  Product.withId({this.id, this.name, this.description, this.unitPrice});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["name"] = name.toString();
    map["description"] = description.toString();
    map["unitPrice"] = int.tryParse(unitPrice.toString());
    if(id != null) {
      map["id"] = int.tryParse(id.toString());
    }
    return map;
  }

  Product.fromObject(dynamic o) {
    id = int.tryParse(o["id"].toString());
    name = o["name"].toString();
    description = o["description"].toString();
    unitPrice = int.tryParse(o["unitPrice"].toString());
  }

}