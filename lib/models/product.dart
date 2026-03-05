class Product {
  String id;
  String name;
  int quantity;
  bool isChecked;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.isChecked,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'quantity': quantity, 'isChecked': isChecked};
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: '',
      name: json['name'],
      quantity: json['quantity'],
      isChecked: json['isChecked'],
    );
  }
}
