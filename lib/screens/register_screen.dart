import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var loading = false;
  final userNameController =
      TextEditingController(text: "barry.allen@example.com");

  final passwordController =
      TextEditingController(text: "SuperSecretPassword!");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
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
            loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      User? user = await AuthService().register(
                          userNameController.text, passwordController.text);
                      if (user == null) {
                        print("user not registred");
                      } else {
                        print(user.email);
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                    child: Text('Register'),
                  ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('Already have account? Login'))
          ],
        ),
      ),
    );
  }
}
