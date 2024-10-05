import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double? scrolledUnderElevation;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('TeX'),
          scrolledUnderElevation: scrolledUnderElevation,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 5.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  // Different Padding For All Sides
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 60.0,
                    alignment: Alignment.centerLeft,
                    child: const Row(
                      children: <Widget>[
                        FittedBox(
                          child: FlutterLogo(),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'John Doe',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              'Hello world',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
