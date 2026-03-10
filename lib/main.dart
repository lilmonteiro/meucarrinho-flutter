// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'dart:convert';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  // List<Product> products = [
  //   Product(name: 'Alface', quantity: 1, isChecked: false),
  //   Product(name: 'Maionese', quantity: 2, isChecked: false),
  //   Product(name: 'Papel Higienico', quantity: 2, isChecked: false),
  // ];
  
  @override
  void initState() {
    super.initState();
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
        children: [
          ListItem(product: Product(name: 'Alface', quantity: 1, isChecked: false)),
          ListItem(product: Product(name: 'Maionese', quantity: 2, isChecked: false)),
          ListItem(
            product: Product(
              name: 'Papel Higienico',
              quantity: 2,
              isChecked: false,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
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
}

class ListItem extends StatefulWidget {
  final Product product;

  const ListItem({
    super.key,
    required this.product
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        onPressed: () {},
      ),
    );
  }
}
