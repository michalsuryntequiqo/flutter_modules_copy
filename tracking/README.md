# tracking


## Getting Started

This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

Tracking layer allowing sending event to multiple tracking providers.

## Usage
1. Define specific event type implementing `Event`, for example:

`
abstract class AdjustEvent extends Event {
    @override
    List<Type> get types => [AdjustEventType];
}
`
    
2. Create tracker that implements `Tracker`:

`
class AdjustTracker extends EventTracker<Event> {
  @override
  Future<void> send(Event event) {
    // TODO: Send your event here
  }
}
`

3. Init `EventDispatcher` and add linked Event type and Tracker:

`
dispatcher.addTracker(AdjustEvent, adjustTracker);
`

4. Create any event, implementing `AdjustEvent`, for example `LoginEvent`:

`
class LoginEvent extends AdjustEvent {
    @override
    List<Parameter> parameters = [Parameter('loggedin': true)];
}
`

5. User `Dispatcher` to send the event. Dispatcher will send the specific event where needed.
` 
dispatcher.send(loginEvent);
`
