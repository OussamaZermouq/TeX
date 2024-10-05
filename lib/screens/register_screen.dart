import 'package:flutter/material.dart';
import 'package:tex/app/data/service/user_service.dart';
import 'package:tex/screens/introduce_screen.dart';
import 'screens.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegistrationForm();
}

class _RegistrationForm extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username;
  String? email;
  String? password;
  String? passwordConf;
  int? statusCode;

  Future<void> addUser() async {
    final userService = UserService();
    statusCode = await userService.createUser(username, email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Register your account",
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
                                hintText: 'Enter your username',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                username = value.toString();
                              },
                            ),
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
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Confirm your password',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }

                                return null;
                              },
                              obscureText: true,
                              onSaved: (value) {
                                passwordConf = value.toString();
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState?.save();
                                    if (password != passwordConf) {
                                      const snackBar = SnackBar(
                                        content: Text("Password don't match",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      addUser();
                                      debugPrint(statusCode.toString());
                                      if (statusCode == 202) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const IntroductionScreen()),
                                        );
                                      } else {
                                        const snackBar = SnackBar(
                                          content: Text("An error has occrued. Please try again",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold)),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }
                                  }
                                },
                                child: const Text('Next'),
                              ),
                            ),
                          ],
                        ),
                      ))
                ])));
  }
}
