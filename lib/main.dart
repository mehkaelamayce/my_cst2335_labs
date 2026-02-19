import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'UserRepository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserRepository.instance.loadData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lab 4'),
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

  final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

  static const String usernameKey = "saved_username";
  static const String passwordKey = "saved_password";

  var imageSource = "images/question-mark.png";


  @override
  void initState() {
    super.initState();
    loginController = TextEditingController();
    passwordController = TextEditingController();

    loadSavedCredentials();
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loadSavedCredentials() async {
    try {
      final username = await prefs.getString(usernameKey);
      final password = await prefs.getString(passwordKey);

      if (username.isNotEmpty && password.isNotEmpty) {
        loginController.text = username;
        passwordController.text = password;


        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Previous login name and password loaded."),
              duration: Duration(seconds: 3),
            ),
          );
        });
      }
    } catch (_) {
    }
  }

  Future<void> saveCredentials() async {
    await prefs.setString(usernameKey, loginController.text);
    await prefs.setString(passwordKey, passwordController.text);
  }

  Future<void> clearCredentials() async {
    await prefs.remove(usernameKey);
    await prefs.remove(passwordKey);
  }

  Future<void> onLoginPressed() async {
    final typedPassword = passwordController.text;

    final bool? shouldSave = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Save login?"),
        content: const Text(
          "Do you want to save your username and password for next time?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Yes"),
          ),
        ],
      ),
    );

    if (shouldSave == true) {
      await saveCredentials();
    } else {
      await clearCredentials(); // next app start will be empty
    }

    setState(() {
      imageSource = (typedPassword == "ASDF")
          ? "images/idea.png"
          : "images/stop.png";
    });
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
          mainAxisAlignment: MainAxisAlignment.center,
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

            const SizedBox(height: 20),

            Semantics(
              label: "Login result image",
              child: Image.asset(
                imageSource,
                height: 300,
                width: 300,
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}