import 'package:flutter/material.dart';
import 'database.dart';
import 'shopping_item.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: const ShoppingListPage(title: 'Shopping List'),
    );
  }
}

///Main page of my shopping list application
class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key, required this.title});

  final String title;

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<ShoppingItem> items = [];
  ShoppingItem? selectedItem;

  ///Controller for item name and quantity text field
  final TextEditingController itemController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  late var dao;

  ///List used to store shoppin items currently displayed on screen

  @override
  void initState() {
    super.initState();

    ///Load the database and any saved items when page starts
    loadDatabase();
  }

  ///Opens the Floor database and loads all saved shopping items
  void loadDatabase() async {
    AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    dao = database.shoppingDao;

    final list = await dao.findAllItems();

    setState(() {
      items = list;
    });
  }

  @override
  void dispose() {
    super.dispose();
    itemController.dispose();
    qtyController.dispose();
  }

  ///Adds a new shopping item to database and list on screen
  void addItem() async {
    ///Do nothing if either field is empty
    if (itemController.text.isEmpty || qtyController.text.isEmpty) {
      return;
    }

    final newItem = ShoppingItem(
      ShoppingItem.idCounter++,
      itemController.text,
      int.parse(qtyController.text),
    );

    ///Insert item into the database
    await dao.insertItem(newItem);

    ///Updates the screen and clear text fields
    setState(() {
      items.add(newItem);
    });

    itemController.clear();
    qtyController.clear();
  }

  Widget reactiveLayout() {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    if ((width > height) && (width > 720)) {
      return Row(children: [
        Expanded(flex: 2, child: listPage(),),
        Expanded(flex: 3, child: detailsPage(),),
        ],
      );
    } else {
      if (selectedItem == null) {
        return listPage();
      } else {
        return detailsPage();
      }
    }
  }

  Widget detailsPage() {
    if (selectedItem != null) {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Name: ${selectedItem!.name}",
          style: const TextStyle(fontSize: 20.0),
          ),
          Text("Quantity: ${selectedItem!.qty}",
          style: const TextStyle(fontSize: 20.0),
          ),
          Text("DatabaseID: ${selectedItem!.id}",
          style: const TextStyle(fontSize: 20.0),
          ),
          ElevatedButton(
            onPressed: () async {
              await dao.deleteItem(selectedItem!);
              setState(() {
                items.remove(selectedItem);
                selectedItem = null;
              });
            },
            child: const Text("Delete"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedItem = null;
              });
            },
            child: const Text("Close"),
          )
        ],)
      );
    } else {
      return const Center (
        child: Text(
          "Please select an item from the list",
          style: TextStyle(fontSize: 20.0),
        )
      );
    }
  }

  ///Builds main page layout
  Widget listPage() {
    return Column(
      children: [
        Row(children: [
          Expanded(flex: 6,
            child: TextField(
              controller: itemController,
              decoration: const InputDecoration(
                hintText: "Type the item here", border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 12),
            Expanded(flex: 6,
              child: TextField(
                controller: qtyController, keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Type the quantity here", border: OutlineInputBorder(),
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
          const SizedBox(height: 20),
          Expanded(
          child: items.isEmpty
              ? const Center(
                child: Text("There are no items in the list"),
          )
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final currentItem = items[index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedItem = currentItem;
                  });
                },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${index +1}. "),
                          Text(currentItem.name),
                          Text(" quantity: ${currentItem.qty}"),
                        ],
                      ),
                    ),
                  );
                },
              ),

        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: reactiveLayout(),
      ),
    );
  }
}
