import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/components/my_drawer.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/User_tile.dart';
import 'package:chatapp/pages/chatpage.dart';

class Homepage extends StatelessWidget {
  // get the auth and the chat services
  AuthService _authService = AuthService();
  ChatService _chatService = ChatService();

  new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Text(
              "HOME",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // handeling error
        if (snapshot.hasError) {
          return Text("Error");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loasding...");
        }

        //return list view

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _builduserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // build individual tile list for user
  Widget _builduserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chatpage(
                recieverEmail: userData["email"],
                recieverId: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
