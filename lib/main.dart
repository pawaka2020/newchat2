import 'package:flutter/material.dart';
import 'package:newchat2/model/chatuser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'model/chatmessage.dart';

void initSupabase() async{
  var url = 'https://kttzwdcfclugnhfytrtc.supabase.co';
  var anonkey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt0dHp3ZGNmY2x1Z25oZnl0cnRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzU5OTgxNjMsImV4cCI6MTk5MTU3NDE2M30.0HIg2MGl2h_fvfDyYd5JkfvpgANHJ2gxF-sMUOBIKCI';
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: url,
    anonKey: anonkey,
  );
  debugPrint("database connected");
}

void testConnection()async {
  //await ChatUserService().testInsert();
  //await ChatUserService().fromSupabase(true);
  //ChatUserService().getStream2();
  //ChatUserService().getStream(true);
  //ChatMessageService().testInsert();
  //ChatMessageService().fromSupabase(true);

  // UID of User 'Alpha'
  var alpha = 'd529d88d-32e6-4eed-9802-0b13fb1b19a6';
  // UID of User 'Beta'
  var beta = '180cfcbe-ee1a-4c69-9abe-1efb6e38dd3c';
  // UID of User 'Gamma'
  var gamma = '1bd7c365-ada9-45a5-b391-a819fd3bc67b';

  ChatMessageService().loadConvo(
      beta,
      gamma,
      true);
  //ChatMessageService().getStream(true);
}

void main() {
  initSupabase();
  testConnection();
  //runApp(const MyApp());
}


