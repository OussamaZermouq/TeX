import 'package:flutter/material.dart';

import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:tex/app/data/CustomWidgets/ChatWidget.dart';
import 'package:tex/app/data/model/Chat.dart';
import 'package:tex/app/data/service/chat_service.dart';
import 'package:tex/screens/contact_list_screen.dart';

import 'introduce_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  final chatService = ChatService();
  List<Chat>? chats;
  @override
  void initState() {
    super.initState();

    getChats();
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

  Future<List<Chat>?> getChats() async{
    List<Chat>? chats_ = await chatService.getChats();
    chats = chats_;
    return chats_;

  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert!!"),
          content: Text("You are awesome!"),
          actions: [
            MaterialButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void navigate(String screen){
    switch(screen){
      case 'contact':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const ContactListScreen()),
        );
    }
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
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                // PopupMenuItem 1
                const PopupMenuItem(
                  value: 1,
                  // row with 2 children
                  child: Row(
                    children: [
                      Icon(Icons.ice_skating),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Profile")
                    ],
                  ),
                ),
                // PopupMenuItem 2
                const PopupMenuItem(
                  value: 2,
                  // row with two children
                  child: Row(
                    children: [
                      Icon(Icons.chrome_reader_mode),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Contacts")
                    ],
                  ),

                ),
                const PopupMenuItem(
                  value: 2,
                  // row with two children
                  child: Row(
                    children: [
                      Icon(Icons.chrome_reader_mode),
                      SizedBox(
                        width: 10,
                      ),
                      Text("About")
                    ],
                  ),
                ),
              ],
              offset: const Offset(0, 50),
              color: Colors.grey,
              elevation: 2,
              // on selected we show the dialog box
              onSelected: (value) {
                // if value 1 show dialog
                if (value == 1) {
                  _showDialog(context);
                  // if value 2 show dialog
                } else if (value == 2) {
                  _showDialog(context);
                }
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
            BubbleMenu(
              title: 'Chat',
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.chat,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              onPressed: () {},
            ),
            // Floating action menu item
            BubbleMenu(
              title: 'Contact',
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.person_add_alt_1,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const ContactListScreen()),
                );
              },
            ),
            //Floating action menu item
            BubbleMenu(
              title: 'Group',
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.groups,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Coming soon')));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 5.0,
            ),
            child: FutureBuilder(
              future: getChats(),
              builder: (context, snapshot){
                if (snapshot.hasData){
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: chats!.length,
                      itemBuilder: (context, index){
                        return ChatWidget(chat: chats![index]);
                    }
                  );
                }
                else if (snapshot.hasError){
                  print(snapshot.error);
                  return const Text("ERROR LOADING DATA");
                }
                else{
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ),
        ));
  }
}
