import 'package:flutter/material.dart';

void main() {
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

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
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
  var myFontSize = 30.0;
  var _counter = 30.0;
  var isChecked = false;
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    controller.dispose();
  }

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  
  void setNewValue(double newValue) {
    setState(() {
      myFontSize = newValue;
      _counter = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: .center,
          children: <Widget> [
            ElevatedButton(onPressed: () {}, child: Text("Button 1")),
            ElevatedButton(onPressed: () {}, child: Text("Button 2")),
            ElevatedButton(onPressed: () {}, child: Text("Button 3")),
            FilledButton(onPressed: () {}, child: Text("Button 4")),
            ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }


}
