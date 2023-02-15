import 'package:flutter/services.dart';

class CustomPlatformChannel {
  final _batteryChannel = const MethodChannel('br.com.platform.channel/battery');
  final _palindromeChannel = const MethodChannel('br.com.platform.channel/palindrome');

  final _timerEvent = const EventChannel('br.com.platform.channel/timer');
  final _randomNameEvent = const EventChannel('br.com.platform.channel/randomName');

  Future<String> callBatteryMethodChannel() async {
    try {
      final batteryLevel = await _batteryChannel.invokeMethod('getBatteryLevel');
      return batteryLevel.toString();
    } on PlatformException catch (e) {
      return "Failed to invoke method -> '${e.message}'.";
    }
  }

  Future<String> callPalindromeMethodChannel({required String word}) async {
    try {
      return await _palindromeChannel.invokeMethod('isPalindrome', {'word': word});
    } on PlatformException catch (e) {
      return "Failed to invoke method -> '${e.message}'.";
    }
  }

  Stream<DateTime> callTimerEventChannel() {
    return _timerEvent.receiveBroadcastStream().map((event) => DateTime.parse(event));
  }

  Stream<String> callRandomNameEventChannel() {
    return _randomNameEvent.receiveBroadcastStream().map((event) => event.toString());
  }
}
