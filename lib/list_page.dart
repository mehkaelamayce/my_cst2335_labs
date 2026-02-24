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

  void addItem() {
    final name = itemController.text.trim();
    final qtyText = qtyController.text.trim();

    if (name.isEmpty || qtyText.isEmpty) return;

    final qty = int.tryParse(qtyText);
    if (qty == null) return;

    setState(() {
      items.add(ShoppingItem(name: name, qty: qty));
      itemController.clear();
      qtyController.clear();
    });
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return GestureDetector(
          onLongPress: () => confirmDelete(index),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${index + 1}: ${item.name}"),
                Text("quantity: ${item.qty}"),
              ],
            ),
          ),
        );
      },
    );
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