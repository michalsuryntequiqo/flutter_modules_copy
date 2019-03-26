# tracking


## Getting Started

This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

Tracking layer allowing sending event to multiple tracking providers.

##Usage
1. Define specific event type implementing `Event`, for example:

    `abstract class AdjustEvent extends Event {}`
    
2. Create tracker that implements `Tracker`:

`
class FirebaseTracker extends EventTracker<FirebaseEvent> {
  @override
  Future<void> send(Event event) {
    print('Firebase Tracker: send event.');
  }
}
`

3. Init `EventDispatcher` and add lineked Event type and Tracker:

`    dispatcher.addTracker(FirebaseEvent, firebaseTracker);
`

4. Create any event, implementing `Event`, for example `LoginEvent`:

class LoginEvent implements Event {}
  LoginEvent({
    @required this.eventTypes
  }) : assert(eventTypes.length > 0);

  @override
  List<Type> types;

  @override
  List<Map<String, dynamic>> parameters = [{'loggedin': true}];
}

5. User `Dispatcher` to send the event. Dispatcher will send the specific event where needed.
`    dispatcher.send(loginEvent);
`


    
