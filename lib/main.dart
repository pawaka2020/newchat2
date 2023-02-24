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
  //ChatMessageService().getStream(true);
}

void main() {
  initSupabase();
  testConnection();
  //runApp(const MyApp());
}


