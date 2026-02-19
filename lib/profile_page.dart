import 'package:flutter/material.dart';
import 'user_repository.dart';

class ProfilePage extends StatefulWidget {
  final String loginName;
  const ProfilePage({super.key, required this.loginName});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final repo = UserRepository.instance;

  late TextEditingController firstController;
  late TextEditingController lastController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    firstController = TextEditingController(text: repo.firstName);
    lastController = TextEditingController(text: repo.lastName);
    phoneController = TextEditingController(text: repo.phoneNumber);
    emailController = TextEditingController(text: repo.emailAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Page")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Welcome Back ${widget.loginName}"),
            const SizedBox(height: 20),

            TextField(controller: firstController, decoration: const InputDecoration(labelText: "First Name")),
            TextField(controller: lastController, decoration: const InputDecoration(labelText: "Last Name")),
            TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Phone Number")),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email address")),
          ],
        ),
      ),
    );
  }
}
