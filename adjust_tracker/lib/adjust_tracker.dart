library adjust_tracker;

import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:tracking/tracker.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:tracking/event.dart';

export 'package:adjust_sdk/adjust_config.dart';

class AdjustTracker extends EventTracker<Event> {

  AdjustTracker(String adjustToken, AdjustEnvironment adjustConfigEnvironment) {
    _setupAdjust(adjustToken);
  }

  @override
  Future<void> send(Event event) {
    AdjustEvent adjustEvent = AdjustEvent(event.parameters.firstWhere((parameter) => parameter.key == "adjust_token").value);
    var params = event.parameters.where((parameter) => parameter.key != "adjust_token");
    params.forEach((p) => adjustEvent.addCallbackParameter(p.key, p.value.toString()));
    Adjust.trackEvent(adjustEvent);
  }

  void _setupAdjust(String adjustToken) {
    AdjustConfig config = AdjustConfig(adjustToken,
        _isDebugMode ? AdjustEnvironment.sandbox : AdjustEnvironment.production);
    config.logLevel = AdjustLogLevel.verbose;
    Adjust.start(config);
  }

  bool get _isDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }
}