import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shidts/get_shifts.dart';
import 'package:shidts/login.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controller = TextEditingController();

  bool signingUp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Username input field
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      signingUp = true;
                    });
                  },
                  child: const Text("Sign Up")),
              if (signingUp)
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Google login button
              ElevatedButton(
                onPressed: () async {
                  if (controller.text.isEmpty && signingUp) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        "Please enter a name",
                      ),
                    ));
                    return;
                  }
                  final user = await FirebaseAuth.instance
                      .signInWithPopup(GoogleAuthProvider());
                  try {
                    if (signingUp) {
                      login(user.user!.uid, controller.text);
                    }
                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ShiftFetchWidget(
                            authKey: user.user!.uid,
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Failed logging in: $e",
                        ),
                      ));
                    }
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 16),
                    Text('Sign in with Google'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
