library adjust_tracker;

import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:tracking/tracker.dart';
import 'package:tracking/event.dart';

export 'package:adjust_sdk/adjust_config.dart';


class AdjustTracker extends EventTracker<Event> {

  AdjustTracker({String adjustToken, AdjustEnvironment adjustConfigEnvironment})
      : assert(adjustToken != null && !adjustToken.isEmpty),
        assert(adjustConfigEnvironment != null) {
    _setupAdjust(adjustToken, adjustConfigEnvironment);
  }

  void _setupAdjust(String adjustToken, AdjustEnvironment environment) {
    AdjustConfig config = AdjustConfig(adjustToken, environment);
    config.logLevel = AdjustLogLevel.verbose;
    Adjust.start(config);
  }

  @override
  void send(Event event) {
    AdjustEvent adjustEvent = AdjustEvent(event.parameters.firstWhere((parameter) => parameter.key.contains("token")).value);
    var params = event.parameters.where((parameter) => !parameter.key.contains("token"));
    params.forEach((p) => adjustEvent.addCallbackParameter(p.key, p.value.toString()));
    Adjust.trackEvent(adjustEvent);
  }

  void onResume() {
    Adjust.onResume();
  }

  void onPaused() {
    Adjust.onPause();
  }
}