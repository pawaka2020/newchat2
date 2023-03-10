
import 'package:flutter/cupertino.dart';
import '../singletons.dart';
import 'chatmessage.dart';
//import 'chatmessage.dart';

///this class is actually an intentional carbon copy of ChatMessage.
class ChatLast
{
  /// Uid generated by Supabase. Only value is ''.
  final String uid;
  /// ChatUser(uid) of sender.
  final String senderUid;
  /// ChatUser(uid) of recipient.
  final String recipientUid;
  /// Text message, including emoji.
  final String message;
  /// URL file to store files.
  final String fileUrl;
  /// Date sent.
  final DateTime dateSent;

  /// The last message, to be shown in a Listview of all the
  /// last messages posted to a logged in loser.
  ChatLast({
    required this.uid,
    required this.senderUid,
    required this.recipientUid,
    required this.message,
    required this.fileUrl,
    required this.dateSent
  });

  /// Converts a ChatMessage object to a Map.
  Map<String, dynamic> toMap()  {
    return {
      //'uid': uid,
      'sender_uid': senderUid,
      'recipient_uid': recipientUid,
      'message': message,
      'file_url': fileUrl,
      'date_sent': dateSent.toIso8601String(),
    };
  }

  /// Creates a ChatMessage from Map.
  static ChatLast fromMap(Map<String, dynamic> map) {
    return ChatLast(
      uid: map['uid'],
      senderUid: map['sender_uid'],
      recipientUid: map['recipient_uid'],
      message: map['message'],
      fileUrl: map['file_url'] ?? '',
      dateSent: DateTime.parse(map['date_sent']),
    );
  }
}

class ChatLastService
{
  Future<void> toSupabase(ChatLast last) async {
    await supabaseClient.from('chat_last').insert(last.toMap());
    debugPrint("ChatMessage object inserted");
  }

  ChatLast create(ChatMessage message)
  {
    return ChatLast(
        uid: '',
        senderUid: message.senderUid,
        recipientUid: message.recipientUid,
        message: message.message,
        fileUrl: message.fileUrl,
        dateSent: message.dateSent
    );
  }

  /// Writes or updates a row.
  Future<void> updateLast(ChatLast last) async {
    // Check if there is an existing row with the matching `senderUid`
    final response = await supabaseClient
        .from('chat_last')
        .select()
        .eq('sender_uid', last.senderUid)
        .eq('recipient_uid', last.recipientUid);

    // If there is an existing row, update it
    //if (response.data.length > 0)
    if (response.length > 0){
      final existingRow = response[0];
      await supabaseClient
          .from('chat_last')
          .update(last.toMap())
          .eq('uid', existingRow['uid']);
    } else {
      // If there is no existing row, insert a new row
      await supabaseClient
          .from('chat_last')
          .insert(last.toMap());
    }


    debugPrint("ChatLast object updated or inserted");
  }

}