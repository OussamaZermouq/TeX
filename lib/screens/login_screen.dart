import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tex/app/data/service/user_service.dart';
import 'package:tex/screens/home_screen.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginForm();
}

class _LoginForm extends State<LoginScreen>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  Future<void> login() async{
    final userService = UserService();
    print(email);
    print(password);

    final statusCode = await userService.login(email, password);
    if( statusCode == 200){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
            const HomeScreen()),
      );
    }
    else {
      const snackBar = SnackBar(
        content: Text("An error has occurred. Please try again",
            style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold)),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Login to your account",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 80),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter your email',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                email = value.toString();
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter your password',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              obscureText: true,
                              onSaved: (value) {
                                password = value.toString();
                              },
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState?.save();
                                    if (password!.isEmpty || email!.isEmpty) {
                                      const snackBar = SnackBar(
                                        content: Text("Please fill out all the fields",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      login();
                                    }
                                  }
                                },
                                child: const Text('Login'),
                              ),
                            ),
                          ],
                        ),
                      ))
                ])));

  }
}