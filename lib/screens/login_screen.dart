import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth_service.dart';
import 'register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatelessWidget {
  final userNameController =
      TextEditingController(text: "emb.ahmed@example.com");
  final passwordController =
      TextEditingController(text: "SuperSecretPassword!");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                    label: Text('User Name'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    label: Text('Password'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    User? user = await AuthService()
                        .login(userNameController.text, passwordController.text)
                        .catchError((error) {
                      var snackBar = SnackBar(content: Text(error));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                    if (user == null) {
                      print("user not registred");
                    } else {
                      print(user.email);
                    }
                  } catch (e) {
                    print("error: $e");
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text('Dont have account? Register')),
              Divider(),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: () async {
                  try {
                    User? user =
                        await AuthService().googleSignup().catchError((error) {
                      var snackBar = SnackBar(content: Text('Hello World'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                    if (user == null) {
                      print("user not registred");
                    } else {
                      print(user.email);
                    }
                  } catch (e) {
                    print("error: $e");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
