import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('http://127.0.0.1:8090');

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _username = '';
  String _password = '';

  Future<void> _signIn() async {
    final authData = await pb
        .collection('users')
        .authWithPassword(_username, _password);
    print(authData);
  }

  void _setUsername(newText) {
    setState(() {
      _username = newText;
    });
  }

  void _setPassword(newText) {
    setState(() {
      _password = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Sign In'),
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter username',
                    ),
                    onChanged: (text) {
                      _setUsername(text);
                      print('First username field: $text');
                    },
                  )
                ),
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your password',
                    ),
                    onChanged: (text) {
                      _setPassword(text);
                      print('First password field: $text');
                    },
                  )
                ),
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ElevatedButton(
                    child: Text(
                      "Sign In".toUpperCase(),
                      style: TextStyle(fontSize: 14)
                    ),
                    onPressed: () => {
                      _signIn()
                    }
                  )
                ),
              ]
            )
        ),
      ),
    );
  }
}