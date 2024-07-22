import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/components/signup.dart';
import 'package:flutter_application_1/components/signin.dart';
import 'package:flutter_application_1/providers/AuthProvider.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final pb = PocketBase('http://127.0.0.1:8090');

void main() async {
  try{
    await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    );
  }catch(e){
    print('error $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IsLoggedInProvider()),
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page', testProp: 'test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, this.testProp = "test default"});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String testProp;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _word = 'word test';

  Future<void> _signUp() async {
    final body = <String, dynamic>{
      "username": "Bob",
      "email": "bob@example.com",
      "password": "12345678",
      "passwordConfirm": "12345678",
      "name": "Bob Smith"
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

  void _incrementCounter() async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    // final newRecord = await pb.collection('example').create(body: {
    //       'title': 'Lorem ipsum dolor sit amet',
    //   });
    // print('newRecord $newRecord');
    final recievedRecord = await pb.collection('example').getList();
    print('recieved records ${recievedRecord.items[1]}');
    // _signUp();
    await _signIn();
    print('is logged in ${pb.authStore.isValid}');
  }

  void _addAToWord(newText) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _word = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
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
            const Text(
              'You have pushed the button this many times:',
            ),
            const SignUp(),
            const SignIn(),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text('Is signed in? ${pb.authStore.isValid}'),
            Text('Counter state ${context.read<IsLoggedInProvider>().count}'),
            Text(
              _word,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    int currentCount = context.read<IsLoggedInProvider>().count;
                    context.read<IsLoggedInProvider>().incrementCount(currentCount+2);
                    _incrementCounter();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ), // This trailing comma makes auto-formatting nicer for build methods.
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
