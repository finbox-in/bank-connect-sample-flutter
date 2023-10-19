import 'dart:convert';

// import 'package:finbox_bc_plugin/bcflutter.dart';


import 'package:finbox_bc_plugin/finbox_bc_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'FinBoxJourneyResult.dart';

void main() {
  runApp(const MyApp());
}

TextEditingController apiKeyController =
    TextEditingController(text: "ClYkH4mb872LfVty3K61M5GgwkPcZzJf88SXLAb4");
TextEditingController fromDateController =
    TextEditingController(text: "01/01/2022");
TextEditingController toDateController =
    TextEditingController(text: "01/05/2022");
TextEditingController bankController = new TextEditingController(text: "HDFC");
TextEditingController resultController = new TextEditingController(text: "Demo");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Bank Connect Hybrid'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // final resultController = new TextEditingController(text: "Demo");

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  // @override
  // void dispose() {
  //   resultController.dispose();
  //   super.dispose();
  // }

  // void printLatestValue() {
  //   print('Second text field: ${resultController.text}');
  // }
  //
  // @override
  // void initState() {
  //   resultController.addListener(_printLatestValue);
  //   super.initState();
  // }

  _initSdk() {
    FinBoxBcPlugin.initSdk(apiKeyController.text, fromDateController.text,
        toDateController.text, bankController.text);
  }

  static Future<void> _getJourneyResult(MethodCall call) async {
    if (call.method != 'getJourneyResult') "";

    print("Call Arguments ${call.arguments}");
    Map<String, dynamic> arguments = jsonDecode(call.arguments);
    FinBoxJourneyResult result = FinBoxJourneyResult.fromJson(arguments);
    print("Entity Id ${result.entityId}");
    print("Message ${result.message}");
  }

  @override
  initState() {
    _initSdk();
    FinBoxBcPlugin.platform.setMethodCallHandler(_getJourneyResult);
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            TextField(
              controller: apiKeyController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Api Key',
              ),
            ),
            TextField(
              controller: fromDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'From Date',
              ),
            ),
            TextField(
              controller: toDateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'To Date',
              ),
            ),
            TextField(
              controller: bankController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Bank Name',
              ),
            ),
            TextField(
                controller: resultController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Result',
                ),
               ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: _initSdk,
              child: Text('Start'),
            )
          ],
          // mainAxisAlignment: MainAxisAlignment.center,
          // children: <Widget>[
          //   const Text(
          //     'You have pushed the button this many times:',
          //   ),
          //   Text(
          //     '$_counter',
          //     style: Theme.of(context).textTheme.headline4,
          //   ),
          // ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _initSdk,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
