import 'package:chatapp/components/my_textfield.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chatapp/themes/light_mode.dart';

class Chatpage extends StatelessWidget {
  final String recieverEmail;
  final String recieverId;
  // text controller for messages

  new({super.key, required this.recieverEmail, required this.recieverId});
  TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendmessage(recieverId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recieverEmail)),
      body: Column(
        children: [
          //list of messages
          Expanded(child: _buildMessagesList()),

          // Input message
          _buildUserinput(context),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderId, recieverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error !");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(QueryDocumentSnapshot doc , BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    

    return Row(
      mainAxisAlignment:  isCurrentUser?MainAxisAlignment.end:MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        Container(
          
        
          
        
          decoration: BoxDecoration(
             color: isCurrentUser?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.secondary ,
             borderRadius: BorderRadius.circular(12),
             
          ),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(vertical: 12),
          child: 
              
           
                  Text(data['message']),),
      ],
    );
          
  }

  Widget _buildUserinput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom :8.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              hintText: "Type a message ...",
              isObscure: false,
              controller: _messageController,
            ),
          ),
      
          // icon to send the message
          Container(
            decoration: BoxDecoration(

              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle
            ),
            child: IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_downward))),
        ],
      ),
    );
  }
}
