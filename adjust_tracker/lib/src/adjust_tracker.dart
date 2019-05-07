library adjust_tracker;

import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:tracking/event.dart';
import 'package:tracking/parameter.dart';
import 'package:tracking/tracker.dart';

export 'package:adjust_sdk/adjust_config.dart';

class AdjustTracker extends EventTracker<Event> {
  AdjustTracker(AdjustConfig config) {
    Adjust.start(config);
  }

  @override
  void send(Event event) {
    final token = _extractTokenFromParameters(event);
    if (token != null) {
      final params = _extractParameters(event);
      AdjustEvent adjustEvent = _createAdjustEvent(token, params);
      Adjust.trackEvent(adjustEvent);
    }
  }

  Parameter _extractTokenFromParameters(Event event) =>
      event.parameters.firstWhere(
        (parameter) => parameter.key.contains('token'),
        orElse: () => null,
      );

  Iterable<Parameter> _extractParameters(Event event) =>
      event.parameters.where((parameter) => !parameter.key.contains('token'));

  AdjustEvent _createAdjustEvent(Parameter token, Iterable<Parameter> params) {
    final adjustEvent = AdjustEvent(token.value);
    params.forEach(
      (p) => adjustEvent.addCallbackParameter(p.key, p.value.toString()),
    );
    return adjustEvent;
  }

  void onResume() {
    Adjust.onResume();
  }

  void onPaused() {
    Adjust.onPause();
  }
}
