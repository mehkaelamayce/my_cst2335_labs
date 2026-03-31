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

  ///Constructor for creating a shopping item
  ///Updates idCounter so it stays ahead of existing IDs
  ShoppingItem(this.id, this.name, this.qty) {
    if (id >= idCounter) {
      idCounter = id + 1;
    }
  }
}

  ///Main page of my shopping list application
  class ShoppingListPage extends StatefulWidget {
    const ShoppingListPage({super.key});

    @override
    State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  ///Controller for item name and quantity text field
  final TextEditingController itemController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  ///List used to store shoppin items currently displayed on screen
  final List<ShoppingItem> items = [];

  ///Database instance
  late AppDatabase database;

  ///DAO object used to access database methods
  late ShoppingDao dao;

  @override
  void initState() {
    super.initState();

    ///Load the database and any saved items when page starts
    loadDatabase();
  }

    ///Opens the Floor database and loads all saved shopping items
    Future<void> loadDatabase() async {
      database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      dao = database.shoppingDao;

      final list = await dao.findAllItems();

      setState(() {
        items.clear();
        items.addAll(list);
      });
    }


  @override
  void dispose() {
    ///Dispose controllers to free memory when page is closed
    itemController.dispose();
    qtyController.dispose();
    super.dispose();
  }

  ///Adds a new shopping item to database and list on screen
  Future<void> addItem() async {
    ///Do nothing if either field is empty
    if (itemController.text.isEmpty || qtyController.text.isEmpty) {
      return;
    }

    final item = ShoppingItem(
      ShoppingItem.idCounter++,
      itemController.text,
      int.parse(qtyController.text),
    );

    ///Insert item into the database
    await dao.insertItem(item);

    ///Updates the screen and clear text fields
    setState(() {
      items.add(item);
      itemController.clear();
      qtyController.clear();
    });
  }

    ///Shows a dialog before deleting an item
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

                  ///Delete the item from the database
                  await dao.deleteItem(item);

                  ///Remove the item from the screen
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
    ///Builds main page layout
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
                          textAlign: TextAlign.center,
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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: listPage(),
        ),
      );
    }
  }
