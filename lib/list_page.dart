import 'package:flutter/material.dart';

class ShoppingItem {
  final String name;
  final int qty;

  ShoppingItem({required this.name, required this.qty});
}

  class ShoppingListPage extends StatefulWidget {
    const ShoppingListPage({super.key});

    @override
    State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  final List<ShoppingItem> items = [];

  @override
  void dispose() {
    itemController.dispose();
    qtyController.dispose();
    super.dispose();
  }

  Widget ListPage() {
    return Column(
      children: [

      ],
    );
  }

}