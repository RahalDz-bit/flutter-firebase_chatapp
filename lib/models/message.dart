import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Message {

  final String senderId ;
  final String senderEmail ;
  final String recieverId ;
  final String message ;
  final Timestamp timestamp ;
  Message ({
    required this.senderId,
    required this.senderEmail,
    required this.recieverId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap (){
    return {
      'senderId' : senderId,
      'senderemail' : senderEmail,
      'recieverid' : recieverId,
      'message' : message,
      'timestamp' : timestamp,
    };
  }

}