import 'dart:async';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rusty_flutter_lib/rusty_flutter_lib.dart';
import 'package:rusty_flutter_lib_example/greeter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await RustyFlutterLib.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    } on MissingPluginException {
      platformVersion = 'Missing plugin';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    var resultStr = rustGreeting(Utf8.toUtf8("Scott Wang"));
    platformVersion = Utf8.fromUtf8(resultStr);

    cstringFree(resultStr);
    print("rust string cleaned up.");

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Powered by Flutter & Rust'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
