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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                    ),
                    onChanged: (text) {
                      print('First text field: $text (${text.characters.length})');
                      _addAToWord(text);
                    },
                  )
                ),
              ]
            )
          ],
        ),
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: <Widget>[
      //     FloatingActionButton(
      //       onPressed: _incrementCounter,
      //       tooltip: 'Increment',
      //       child: const Icon(Icons.add),
      //     ), // This trailing comma makes auto-formatting nicer for build methods.
      //      Padding(
      //         padding: const EdgeInsets.all(0.0),
      //         child: TextField(
      //         decoration: const InputDecoration(
      //           border: OutlineInputBorder(),
      //           hintText: 'Enter a search term',
      //         ),
      //         onChanged: (text) {
      //           print('First text field: $text (${text.characters.length})');
      //           _addAToWord(text);
      //         },
      //       )
      //     ),
      //   ]
      // )
    );
  }
}