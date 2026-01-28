import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


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
          children: [
            Padding(
                padding: EdgeInsetsGeometry.fromLTRB(0, 20, 0, 20),
            child:
              Semantics(
                label: "a counter of the number of times that the button was pressed",
            child: Text(controller.value.text,
                style: TextStyle(fontSize: myFontSize),
            )
            )
            ),

            Semantics(child:
            Image.asset("images/algonquin.jpg", width: 300.0, height: 300.0),
              label:"An image of the library at Algonquin College"),

            ElevatedButton(onPressed: ( ) {
              var typed = controller.value.text;
              setState(() {

            }); myFontSize=20.0; },
                child:Image.asset("images/algonquin.jpg", width: 60.0, height: 60.0)),

            Text(
              '$_counter',
              style: TextStyle(fontSize: myFontSize),
            ),
            
            Checkbox(value: isChecked,
                onChanged: (newChecked) {
                  if(newChecked != null) {
                    controller.text = "You checked the checkbox";

                    setState(() {
                      isChecked = newChecked;
                    });

                  }
                } ),

            Switch(value:isChecked,
              activeThumbColor: Colors.yellow,

              onChanged: ( newChecked){
                  setState(() {
                    isChecked = newChecked;
                  });

              },),

          TextField(controller: controller,
          decoration:InputDecoration(
            hintText: "Type in here",
            labelText: "your text",
            border: OutlineInputBorder(),
          )

          )
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

  void buttonPressed() {
  }

}
