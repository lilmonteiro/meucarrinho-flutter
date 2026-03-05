import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService {
  final _collection = FirebaseFirestore.instance.collection('products');

  checkProduct(Product product) {
    _collection.doc(product.id).update({'isChecked': product.isChecked});
  }

  updateProduct(Product product, String name, int quantity) {
    _collection.doc(product.id).update({'name': name, 'quantity': quantity});
  }

  deleteProduct(Product product) {
    _collection.doc(product.id).delete();
  }

  addProduct(String name, int quantity) {
    final product = Product(
      id: '',
      name: name,
      quantity: quantity,
      isChecked: false,
    );

    _collection.add(product.toJson());
  }

  Stream<List<Product>> getProducts() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Product.fromJson(doc.data())..id = doc.id)
          .toList(),
    );
  }
}
