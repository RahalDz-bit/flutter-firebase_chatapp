import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // stream all the users
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendmessage(String recieverId, message) async {
    // get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUseremail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUseremail,
      recieverId: recieverId,
      message: message,
      timestamp: timestamp,
    );
    // construct chatroom
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // add the new message to the database

    _firestore
        .collection("Chat_Rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get the messages

  Stream<QuerySnapshot> getMessages(String UserId, otherUserId) {
    List<String> ids = [UserId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('Chat_Rooms')
        .doc(chatRoomId)
        .collection('messages').orderBy('timestamp', descending: false)
        .snapshots();
  }
}
