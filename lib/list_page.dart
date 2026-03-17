import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
import 'database.dart';
import 'shopping_dao.dart';

@entity
class ShoppingItem {

  @primaryKey
  final int id;

  final String name;
  final int qty;

  static int idCounter = 1;

  ShoppingItem(this.id, this.name, this.qty) {
    if (id >= idCounter) {
      idCounter = id + 1;
    }
  }
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

  late AppDatabase database;
  late ShoppingDao dao;
  bool isDatabaseReady = false;

  @override
  void initState() {
    super.initState();
    loadDatabase();
  }

    Future<void> loadDatabase() async {
      database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      dao = database.shoppingDao;

      final list = await dao.findAllItems();

      setState(() {
        items.clear();
        items.addAll(list);
        isDatabaseReady = true;
      });
    }


  @override
  void dispose() {
    itemController.dispose();
    qtyController.dispose();
    super.dispose();
  }

  Future<void> addItem() async {
    if (!isDatabaseReady) return;

    final name = itemController.text.trim();
    final qtyText = qtyController.text.trim();

    if (name.isEmpty || qtyText.isEmpty) return;

    final qty = int.tryParse(qtyText);
    if (qty == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid quantity")),
      );
      return;
    }

    final item = ShoppingItem(ShoppingItem.idCounter++, name, qty);

    await dao.insertItem(item);

    setState(() {
      items.add(item);
      itemController.clear();
      qtyController.clear();
    });
  }


    void confirmDelete(int index) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete item?"),
            content: const Text("Do you want to delete this item?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  final item = items[index];
                  Navigator.pop(context);

                  await dao.deleteItem(item);

                  if (!mounted) return;

                  setState(() {
                    items.remove(item);
                  });
                },
                child: const Text("Yes"),
              ),
            ],
          );
        },
      );
    }

    Widget listPage() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    controller: itemController,
                    decoration: const InputDecoration(
                      hintText: "Type the item here",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 6,
                  child: TextField(
                    controller: qtyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Type the quantity here",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: addItem,
                    child: const Text("Add"),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Expanded(
            child: items.isEmpty
                ? const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(child: Text("There are no items in the list")),
            )
                : Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 320,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return GestureDetector(
                      onLongPress: () => confirmDelete(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "${index + 1}: ${item.name}   quantity: ${item.qty}",
                          textAlign: TextAlign
                              .center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Shopping List"),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: isDatabaseReady
            ? listPage()
            : const Center(child: CircularProgressIndicator()),
        ),
      );
    }
  }
