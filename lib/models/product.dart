class Product{
  int? id;
  String? name;
  String? description;
  int? unitPrice;

  Product({required this.name, required this.description, required this.unitPrice});
  Product.withId({required this.id, required this.name, required this.description, required this.unitPrice});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if(id != null) {
      map["id"] = int.tryParse(id.toString());
    }
    map["name"] = name.toString();
    map["description"] = description.toString();
    map["unitPrice"] = int.tryParse(unitPrice.toString());

    return map;
  }

  Product.fromObject(dynamic o) {
    id = int.tryParse(o["id"].toString());
    name = o["name"].toString();
    description = o["description"].toString();
    unitPrice = int.tryParse(o["unitPrice"].toString());
  }

}