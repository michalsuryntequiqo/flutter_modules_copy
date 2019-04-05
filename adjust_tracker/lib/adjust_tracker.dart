library adjust_tracker;

import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:adjust_tracker/adjust_event_type.dart';
import 'package:tracking/tracker.dart';

export 'package:adjust_sdk/adjust_config.dart';


class AdjustTracker extends EventTracker<AdjustEventType> {

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
  void send(AdjustEventType event) {
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