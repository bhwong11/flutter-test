import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('http://127.0.0.1:8090');

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _name = '';

  Future<void> _signUp() async {
    final body = <String, dynamic>{
      "username": _username,
      "email": _email,
      "password": _password,
      "passwordConfirm": _confirmPassword,
      "name": _name
    };
    // final body = <String, dynamic>{
    //   "username": "Bob",
    //   "email": "bob@example.com",
    //   "password": "12345678",
    //   "passwordConfirm": "12345678",
    //   "name": "Bob Smith"
    // };

    final record = await pb.collection('users').create(body: body);
    print(record);
  }

  Future<void> _signIn() async {
    final authData = await pb
        .collection('users')
        .authWithPassword('bob@example.com', '12345678');
    print(authData);
  }

  void _setUsername(newText) {
    setState(() {
      _username = newText;
    });
  }

  void _setEmail(newText) {
    setState(() {
      _email = newText;
    });
  }

  void _setPassword(newText) {
    setState(() {
      _password = newText;
    });
  }

  void _setConfirmPassword(newText) {
    setState(() {
      _confirmPassword = newText;
    });
  }

  void _setName(newText) {
    setState(() {
      _name = newText;
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
                Text('Sign Up'),
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
                      hintText: 'Enter your email',
                    ),
                    onChanged: (text) {
                      _setEmail(text);
                      print('First email field: $text');
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
                    child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Confirm your password',
                    ),
                    onChanged: (text) {
                      _setConfirmPassword(text);
                      print('First confirm password field: $text');
                    },
                  )
                ),
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your name',
                    ),
                    onChanged: (text) {
                      _setName(text);
                      print('First name password field: $text');
                    },
                  )
                ),
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ElevatedButton(
                    child: Text(
                      "Sign Up".toUpperCase(),
                      style: TextStyle(fontSize: 14)
                    ),
                    onPressed: () => {
                      _signUp()
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