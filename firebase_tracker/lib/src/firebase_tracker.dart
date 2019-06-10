import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:tracking/tracking.dart';


class FirebaseTracker extends EventTracker<Event> {

  FirebaseAnalytics _analytics;

  FirebaseTracker() {
    _analytics = FirebaseAnalytics();
  }

  @override
  void send(Event event) {
    final name = _eventName(event)
    final Map<String, dynamic> parameters = _convertParameters(_extractParameters(event));
    
    _analytics.logEvent(name: name, parameters: parameters);
  }
  
  String _eventName(Event event) => event.runtimeType.toString();

  Iterable<Parameter> _extractParameters(Event event) =>
      event.parameters.where((parameter) => !parameter.key.contains('adjust_token'));
  
  Map<String, dynamic> _convertParameters(Iterable<Parameter> parameters) {
    Map<String, dynamic> parametersMap;
    parameters.forEach( (param) {
      parametersMap.putIfAbsent(param.key, param.value);
    });
    return parametersMap;
  }
}
