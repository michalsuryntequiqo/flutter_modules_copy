import 'dart:collection';
import 'dart:core';

import 'package:tracking/event.dart';
import 'package:tracking/tracker.dart';

class EventDispatcher extends EventTracker<Event> {
  final Map<Type, EventTracker> eventTrackers =
      LinkedHashMap<Type, EventTracker>();

  void addTracker(Type eventType, EventTracker tracker) {
    eventTrackers[eventType] = tracker;
  }

  @override
  void send(Event event) {
    for (final key in eventTrackers.keys) {
      for (final eventType in event.types) {
        if (eventType == key) {
          eventTrackers[key].send(event);
        }
      }
    }
  }
}
