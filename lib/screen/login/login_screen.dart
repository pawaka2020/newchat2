import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../../common.dart';
import '../../main.dart';
// import 'package:newchat/common.dart';
// import 'package:newchat/screen/helloworld.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWelcomeText(),
            const SizedBox(height: 20.0),
            _buildUsernameField(),
            const SizedBox(height: 20.0),
            _buildPasswordField(),
            const SizedBox(height: 20.0),
            _buildLoginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Text(
      'Welcome to MyChatApp',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        navigateTo(const HelloWorldScreen(), context, true);
      },
      child: const Text('Login'),
    );
  }
}
