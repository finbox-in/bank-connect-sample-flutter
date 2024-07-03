import 'dart:convert';

import 'package:finbox_bc_plugin/enums/aa_journey_mode.dart';
import 'package:finbox_bc_plugin/enums/aa_recurring_frequency_unit.dart';
import 'package:finbox_bc_plugin/enums/journey_mode.dart';
import 'package:finbox_bc_plugin/enums/mode.dart';
import 'package:finbox_bc_plugin/finbox_bc_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'FinBoxJourneyResult.dart';

void main() {
  runApp(const MyApp());
}

TextEditingController apiKeyController =
    TextEditingController(text: "");
TextEditingController fromDateController =
TextEditingController(text: "01/02/2024");
TextEditingController toDateController =
TextEditingController(text: "01/07/2024");
TextEditingController bankController = new TextEditingController(text: "");
TextEditingController resultController = new TextEditingController(text: "");
TextEditingController journeyModeController = TextEditingController(text: null);
TextEditingController modeController = TextEditingController(text: null);
TextEditingController mobileController = TextEditingController(text: null);
TextEditingController aaJourneyModeController = TextEditingController(text: null);
TextEditingController aaRecurringTenureMonthCountController = TextEditingController(text: null);
TextEditingController aaRecurringFrequencyUnitController = TextEditingController(text: null);
TextEditingController aaRecurringFrequencyValueController = TextEditingController(text: null);

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
  final List<String> _modeDropdownItems = [
    "Select Mode",
    "aa",
    "online",
    "pdf"
  ];
  final Map<String, Mode?> _modeDropdownMap = {
    "Select Mode": null,
    "aa": Mode.AA,
    "online": Mode.ONLINE,
    "pdf": Mode.PDF
  };
  String? _selectedMode;

  final List<String> _AAFrequencyUnitDropdownItems = [
    "Select AA Recurring Frequency Unit",
    "day",
    "month",
    "year"
  ];
  final Map<String, AARecurringFrequencyUnit?> _AAFrequencyUnitDropdownMap = {
    "Select AA Recurring Frequency Unit": null,
    "day": AARecurringFrequencyUnit.DAY,
    "month": AARecurringFrequencyUnit.MONTH,
    "year": AARecurringFrequencyUnit.YEAR
  };
  String? _selectedAAFrequencyUnit;

  final List<String> _journeyModeDropdownItems = [
    "Select Journey Mode",
    "Normal",
    "multi_pdf"
  ];
  final Map<String, JourneyMode?> _journeyModeDropdownMap = {
    "Select Journey Mode": null,
    "Normal": null,
    "multi_pdf": JourneyMode.MULTI_PDF
  };
  String? _selectedJourneyMode;

  final List<String> _AAJourneyModeDropdownItems = [
    "Select AA Journey Mode",
    "only_once",
    "only_recurring"
  ];
  final Map<String, AAJourneyMode?> _AAJourneyModeDropdownMap = {
    "Select AA Journey Mode": null,
    "only_once": AAJourneyMode.ONLY_ONCE,
    "only_recurring": AAJourneyMode.ONLY_RECURRING
  };
  String? _selectedAAJourneyMode;

  _initSdk() {
    // Get the selected Mode
    Mode? mode = _modeDropdownMap[_selectedMode];

    JourneyMode? journeyMode = _journeyModeDropdownMap[_selectedJourneyMode];

    AAJourneyMode? aaJourneyMode =
    _AAJourneyModeDropdownMap[_selectedAAJourneyMode];

    AARecurringFrequencyUnit? frequencyUnit =
    _AAFrequencyUnitDropdownMap[_selectedAAFrequencyUnit];

    var tenureMonthCount;
    if (aaRecurringTenureMonthCountController.text != null &&
        aaRecurringTenureMonthCountController.text.isNotEmpty) {
      tenureMonthCount = int.parse(aaRecurringTenureMonthCountController.text);
    }

    var frequencyValue;
    if (aaRecurringFrequencyValueController.text != null &&
        aaRecurringFrequencyValueController.text.isNotEmpty) {
      frequencyValue = int.parse(aaRecurringFrequencyValueController.text);
    }

    FinBoxBcPlugin.initSdk(
        apiKeyController.text,
        "demo_bank_connect_user_1",
        fromDateController.text,
        toDateController.text,
        bankController.text,
        journeyMode,
        mode,
        mobileController.text,
        aaJourneyMode,
        tenureMonthCount,
        frequencyUnit,
        frequencyValue);
  }

  static Future<void> _getJourneyResult(MethodCall call) async {
    if (call.method != 'getJourneyResult') return;

    print("Call Arguments ${call.arguments}");
    Map<String, dynamic> arguments = jsonDecode(call.arguments);
    FinBoxJourneyResult result = FinBoxJourneyResult.fromJson(arguments);
    print("Entity Id ${result.entityId}");
    print("Session Id ${result.sessionId}");
    print("Message ${result.message}");

    if (result.sessionId != null) {
      resultController.text = result.sessionId!;
    } else if (result.entityId != null) {
      resultController.text = result.entityId!;
    } else if (resultController.text != null) {
      resultController.text = result.message!;
    }
  }

  @override
  initState() {
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
            DropdownButton<String>(
              hint: Text('Journey Mode'),
              value: _selectedJourneyMode,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedJourneyMode = newValue;
                });
              },
              items: _journeyModeDropdownItems
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              hint: Text('Mode'),
              value: _selectedMode,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMode = newValue;
                });
              },
              items: _modeDropdownItems.map<DropdownMenuItem<String>>((
                  String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Mobile Number',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0)),
            ),
            DropdownButton<String>(
              hint: Text('AA Journey Mode'),
              value: _selectedAAJourneyMode,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAAJourneyMode = newValue;
                });
              },
              items: _AAJourneyModeDropdownItems.map<DropdownMenuItem<String>>((
                  String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: aaRecurringTenureMonthCountController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'AA Recurring Tenure Month Count',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0)),
            ),
            DropdownButton<String>(
              hint: Text('AA Recurring Frequency Unit'),
              value: _selectedAAFrequencyUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAAFrequencyUnit = newValue;
                });
              },
              items: _AAFrequencyUnitDropdownItems.map<
                  DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: aaRecurringFrequencyValueController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'AA Recurring Frequency Value',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0)),
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
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
