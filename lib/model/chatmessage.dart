// Future<List<ChatMessage>> getLastMessages(String loggedInUserUid) async {
//   final response = await supabase.from('messages').select().execute();
//   if (response.error != null) {
//     throw response.error!;
//   }
//   final List<dynamic> jsonArray = jsonDecode(jsonEncode(response.data));
//   final List<ChatMessage> result = jsonArray.map((e) => ChatMessage.fromMap(e)).toList();
//   return result;
// }

// Future<List<ChatMessage>> getMessagesInRoom(String roomUid) async {
//   final supabase = SupabaseClient('<YOUR_SUPABASE_URL>', '<YOUR_SUPABASE_ANON_KEY>');
//
//   final response = await supabase
//       .from('messages')
//       .select('uid, sender_uid, recipient_uid, room_uid, message, date_sent')
//       .eq('room_uid', roomUid)
//       .order('date_sent', ascending: true)
//       .execute();
//
//   if (response.error != null) {
//     throw response.error!;
//   }
//
//   final List<dynamic> data = response.data ?? [];
//
//   return data.map((item) => ChatMessage(
//     uid: item['uid'],
//     senderUid: item['sender_uid'],
//     recipientUid: item['recipient_uid'],
//     roomUid: item['room_uid'],
//     message: item['message'],
//     dateSent: DateTime.parse(item['date_sent']),
//   )).toList();
// }
import 'dart:async';
import 'dart:convert';
import 'package:postgrest/postgrest.dart';
import 'package:flutter/cupertino.dart';
import 'package:newchat2/model/stringcrypt.dart';
import 'package:encrypt/encrypt.dart' as xx;

import '../singletons.dart';
import 'chatlast.dart';


class ChatMessage {
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

  /// Message posted by a User.
  ChatMessage({
    required this.uid,
    required this.senderUid,
    required this.recipientUid,
    required this.message,
    required this.fileUrl,
    required this.dateSent
  });

  /// Class for encrypting a string to a string, and decrypting it back to a string.

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
  static ChatMessage fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      uid: map['uid'],
      senderUid: map['sender_uid'],
      recipientUid: map['recipient_uid'],
      message: map['message'],
      fileUrl: map['file_url'] ?? '',
      dateSent: DateTime.parse(map['date_sent']),
    );
  }
}

class ChatMessageService{

  Future<void> toSupabase(ChatMessage message) async {
    await supabaseClient.from('chat_messages').insert(message.toMap());
    debugPrint("ChatMessage object inserted");
    ChatLast last = ChatLastService().create(message);
    ChatLastService().updateLast(last);
  }

  Stream<List<ChatMessage>> getStream(bool test) {
    final response = supabaseClient
        .from('chat_messages')
        .stream(primaryKey: ['uid'])
    //.order('datecreated')
        .map((maps) =>
        List<Map<String, dynamic>>.from(maps).map((map) =>
            ChatMessage.fromMap(map)).toList());
    if (test == true){
      response.listen((data) {
        for (var message in data) {
          debugPrint(message.senderUid);
          debugPrint(message.message);
          debugPrint(message.fileUrl);
        }
      });
    }
    return response;
  }

  ChatMessage create(
      String senderUid,
      String recipientUid,
      String message,
      String fileUrl) {
    return ChatMessage(
        uid: '',
        senderUid: senderUid,
        recipientUid: recipientUid,
        message: message,
        fileUrl: fileUrl,
        dateSent: DateTime.now()
    );
  }
  Future<void> testInsert() async {
    var alpha = '0f144230-5d26-4134-a706-c5a3f48f00c0';
    var beta = '01c5bd00-cc53-4bcd-ae22-5fd9f5785f1e';
    var gamma = 'cd0d8407-63ce-43b2-b554-354f6ab51b3b';

    // Messages between Alpha and Beta
    var message1 = create(alpha, beta, 'Hello', '');
    await toSupabase(message1);

    var message2 = create(beta, alpha, 'Hey how are you?', '');
    await toSupabase(message2);

    var message3 = create(alpha, beta, "I'm good, thank you. I love you.", '');
    await toSupabase(message3);

    var message4 = create(beta, alpha, 'I love you too.', '');
    await toSupabase(message4);

    // Messages between Gamma and Beta
    var message5 = create(gamma, beta, 'Hello', '');
    await toSupabase(message5);

    var message6 = create(gamma, beta, 'You there?', '');
    await toSupabase(message6);

    var message7 = create(gamma, beta, '', 'present.png');
    await toSupabase(message7);

    var message8 = create(gamma, beta, "Fine, stop talking to me. :(", '');
    await toSupabase(message8);

    debugPrint("All messages inserted");
  }

  Future<List> fromSupabase(bool test) async {
    final response = await supabaseClient.from('chat_messages').select();
    List<dynamic> jsonArray = jsonDecode(jsonEncode(response));
    List<ChatMessage> result = jsonArray.map((e) =>
        ChatMessage.fromMap(e)).toList();
    if (test == true) {
      for (var chat in result) {
        debugPrint(chat.senderUid);
        debugPrint(chat.message);
        debugPrint(chat.fileUrl);
      }
    }
    return result;
  }

  /// loads a conversation.
  /// for now we use the deprecated execute(). I can try to change it later.
  Future<List<ChatMessage>> loadConvo(String uid1, String uid2, bool test) async {
    final query1 = supabaseClient
        .from('chat_messages')
        .select()
        .eq('sender_uid', uid1)
        .eq('recipient_uid', uid2);
        //.order('date_sent');

    final query2 = supabaseClient
        .from('chat_messages')
        .select()
        .eq('sender_uid', uid2)
        .eq('recipient_uid', uid1);
        //.order('date_sent');

    //final response = await Future.wait([query1.execute(), query2.execute()]);
    final response = await Future.wait([query1.execute(), query2.execute()]);
    final jsonArray = response.expand((res) => res.data).toList();
    jsonArray.sort((a, b) => a['date_sent'].compareTo(b['date_sent']));

    final result = jsonArray.map((e) => ChatMessage.fromMap(e)).toList();

    if (test == true) {
      for (var chat in result) {
        debugPrint(chat.senderUid);
        debugPrint(chat.message);
        debugPrint(chat.fileUrl);
      }
    }

    return result;
  }



}

class PMService{

}
