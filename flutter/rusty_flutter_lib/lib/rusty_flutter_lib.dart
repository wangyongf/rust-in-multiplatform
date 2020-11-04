
import 'dart:async';

import 'package:flutter/services.dart';

class RustyFlutterLib {
  static const MethodChannel _channel =
      const MethodChannel('rusty_flutter_lib');

  static Future<String> get platformVersion async {
    // final String version = await _channel.invokeMethod('getPlatformVersion');
    final String helloMsg = await _channel.invokeMethod('hello');
    return helloMsg;
  }
}
