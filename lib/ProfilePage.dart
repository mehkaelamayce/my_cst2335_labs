import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String loginName;

  const ProfilePage({super.key, required this.loginName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Page")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Welcome Back $loginName"),
            const SizedBox(height: 20),

            const TextField(decoration: InputDecoration(labelText: "First Name")),
            const TextField(decoration: InputDecoration(labelText: "Last Name")),
            const TextField(decoration: InputDecoration(labelText: "Phone Number")),
            const TextField(decoration: InputDecoration(labelText: "Email address")),
          ],
        ),
      ),
    );
  }
}
