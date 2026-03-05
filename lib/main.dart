// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> products = [
    Product(name: 'Alface', quantity: 1, isChecked: false),
    Product(name: 'Maionese', quantity: 2, isChecked: false),
    Product(name: 'Papel Higienico', quantity: 2, isChecked: false),
  ];

  _addProduct() {
    final nameController = TextEditingController();
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Produto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Nome do Produto'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(hintText: 'Quantidade'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text;
              final quantity = int.tryParse(quantityController.text) ?? 1;
              final product = Product(
                name: name,
                quantity: quantity,
                isChecked: false,
              );

              if (name.isNotEmpty) {
                setState(() {
                  products.add(product);
                });
                Navigator.of(context).pop();
              }
              final db = FirebaseFirestore.instance;
              await db.collection('products').add(product.toJson());
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  _editProduct(Product product) {
    final nameController = TextEditingController(text: product.name);
    final quantityController = TextEditingController(
      text: product.quantity.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Editar Produto"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Nome do Produto'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(hintText: 'Quantidade'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text;
              final quantity = int.tryParse(quantityController.text) ?? 1;

              if (name.isNotEmpty) {
                setState(() {
                  product.name = name;
                  product.quantity = quantity;
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  _deleteProduct(Product product) {
    setState(() {
      products.remove(product);
    });
  }

  _saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final json = products.map((p) => jsonEncode(p.toJson())).toList();

    prefs.setStringList('products', json);
  }

  _loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = prefs.getStringList('products');

    final decodedList = encodedList
        ?.map((p) => Product.fromJson(jsonDecode(p)))
        .toList();

    setState(() {
      products = decodedList ?? products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Meu Carrinho'),
        titleSpacing: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
        leading: Icon(
          Icons.shopping_cart,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: products
            .map(
              (product) => ListItem(
                product: product,
                onDelete: () => _deleteProduct(product),
                onEdit: () => _editProduct(product),
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProduct(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Product {
  String name;
  int quantity;
  bool isChecked;

  Product({
    required this.name,
    required this.quantity,
    required this.isChecked,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'quantity': quantity, 'isChecked': isChecked};
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      quantity: json['quantity'],
      isChecked: json['isChecked'],
    );
  }
}

class ListItem extends StatefulWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ListItem({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => widget.onEdit(),
      leading: Checkbox(
        value: widget.product.isChecked,
        onChanged: (value) {
          setState(() {
            widget.product.isChecked = value ?? false;
          });
        },
      ),
      title: Text(
        widget.product.name,
        style: TextStyle(
          decoration: widget.product.isChecked
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          decorationColor: Theme.of(context).colorScheme.outlineVariant,
          color: widget.product.isChecked
              ? Theme.of(context).colorScheme.outlineVariant
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        '${widget.product.quantity} und',
        style: TextStyle(
          color: widget.product.isChecked
              ? Theme.of(context).colorScheme.outlineVariant
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: IconButton(
        style: ButtonStyle(
          iconColor: widget.product.isChecked
              ? WidgetStateProperty.all(
                  Theme.of(context).colorScheme.outlineVariant,
                )
              : WidgetStateProperty.all(Colors.black),
        ),
        icon: const Icon(Icons.delete),
        onPressed: () {
          widget.onDelete();
        },
      ),
    );
  }
}
