import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 2',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lab 2'),
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
  late TextEditingController loginController;
  late TextEditingController passwordController;

String imageSource = "images/question-mark.png";


  @override
  void initState() {
    super.initState();
    loginController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Padding(
                padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: loginController,
                    decoration: const InputDecoration(
                        labelText: "Login",
                        border: OutlineInputBorder()
                 ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder()
                  ),
                ),
            ),

            ElevatedButton(
                onPressed: onLoginPressed,
                child: const Text("Login"),
            ),


          ],
        ),
      ),
    );
  }
}
