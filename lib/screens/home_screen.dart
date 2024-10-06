import 'package:flutter/material.dart';

import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

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
         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //Init Floating Action Bubble
      floatingActionButton: FloatingActionBubble(
        // animation controller
        animation: _animation,
        // On pressed change animation state
        onPressed: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),
        // Floating Action button Icon color
        iconColor: Colors.blue,
        // Flaoting Action button Icon
        iconData: Icons.add,
        backgroundColor: Colors.white,
        // Menu items
        items: <Widget>[
          // Floating action menu item
          BubbleMenu(
            title: 'Contact',
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.person_add_alt_1,
            style: const TextStyle(fontSize: 16 , color: Colors.white),
            onPressed: () {
            },
          ),
          // Floating action menu item
          BubbleMenu(
            title: 'Chat',
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.people,
            style: const TextStyle(fontSize: 16 , color: Colors.white),
            onPressed: () {
            },
          ),
          //Floating action menu item
          BubbleMenu(
            title: 'Group',
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.groups,
            style: const TextStyle(fontSize: 16 , color: Colors.white),
            onPressed: () {
               ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming soon')));
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
                    child: Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: const Image(
                                  image: AssetImage(
                                      'assets/images/userimage.jpg')),
                            )),
                        const Column(
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
