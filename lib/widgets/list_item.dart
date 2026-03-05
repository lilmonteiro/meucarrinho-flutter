import 'package:flutter/material.dart';
import '../models/product.dart';

class ListItem extends StatefulWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onCheck;

  const ListItem({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onEdit,
    required this.onCheck
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
          widget.onCheck();
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
