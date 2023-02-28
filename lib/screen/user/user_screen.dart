import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  //declare variables here
  // late final Stream<List<User>> _userStream;
  // late final Map<String, User> _users = {};
  // late final Map<String, MessageTile> _messageTile = {};

  @override void initState() {
    /// we initiate _userStream here, but it want this to be from UserSerivce.
    /// We will code this later.
    /// _userStream = UserService().getStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      drawer: null,
      body: null,
      floatingActionButton: null,
    );
  }
}
