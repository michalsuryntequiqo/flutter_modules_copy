abstract class EventTracker<Event> {
  Future<void> send(Event event);
}