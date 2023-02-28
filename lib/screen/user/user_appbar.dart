import 'package:flutter/material.dart';

/// AppBar that has text 'Users' but may include other buttons in the future.
AppBar userAppBar(){

  /// button for conducting searches of words/phrases within chat messages.
  IconButton searchbtn = IconButton(
    onPressed: () {
      // Add your search logic here
    },
    icon: const Icon(Icons.search),
  );

  return AppBar(
    title: const Text('Users'),
    actions: [
      searchbtn,
    ],
  );
}