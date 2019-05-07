import 'dart:collection';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:tracking/tracking.dart';

class EventDispatcher extends EventTracker<Event> {
  final Map<Type, EventTracker> eventTrackers =
      LinkedHashMap<Type, EventTracker>();

  EventDispatcher();

  EventDispatcher.withTrackers(Iterable<TrackerEntry> entries) {
    entries.forEach((tracker) => addTrackerEntry(tracker));
  }

  void addTrackerEntry(TrackerEntry trackerEntry) =>
      addTracker(trackerEntry.eventType, trackerEntry.tracker);

  void addTracker(Type eventType, EventTracker tracker) =>
      eventTrackers[eventType] = tracker;

  @override
  void send(Event event) {
    for (final eventType in eventTrackers.keys) {
      if (event.types.contains(eventType)) {
        eventTrackers[eventType].send(event);
      }
    }
  }
}

@immutable
class TrackerEntry {
  final Type eventType;
  final EventTracker tracker;

  TrackerEntry(this.eventType, this.tracker);
}
