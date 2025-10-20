import 'dart:developer';

import 'package:http/http.dart' as http;

class LatencyModel {
  int? latency;
  bool? state;
  LatencyModel({this.latency, this.state});
}

class HttpLatency {
  static Future<LatencyModel> checkLatency() async {
    final url = Uri.parse('https://www.google.com');
    int? latency = 3000;
    bool state = false;
    final stopwatch = Stopwatch()..start();

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        latency = stopwatch.elapsedMilliseconds;
        log('Latência: $latency ms');

        if (latency > 10000) {
          state = true;
        } else {
          state = true;
        }
      }
    } catch (e) {
      latency = stopwatch.elapsedMilliseconds;
      state = true;
    }
    return LatencyModel(latency: latency, state: state);
  }
}
