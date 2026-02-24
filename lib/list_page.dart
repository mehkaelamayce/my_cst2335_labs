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
        Row(
          children: [
            Expanded(
              flex: 5,
              child: TextField(
                controller: itemController,
                decoration: const InputDecoration(
                  hintText: "Type the item here",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: TextField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Type the quantity here",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: addItem,
              child: const Text("Click here"),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: items.isEmpty
              ? const Center(child: Text("There are no items in the list"))
              : buildListView(),
        ),
      ],
    );
  }

}