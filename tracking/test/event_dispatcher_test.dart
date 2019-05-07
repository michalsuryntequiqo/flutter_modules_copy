import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking/src/event.dart';
import 'package:tracking/src/event_dispatcher.dart';
import 'package:tracking/src/tracker.dart';
import 'package:tracking/src/parameter.dart';

main() {
  EventTracker<Event> firebaseTracker;
  EventTracker<Event> adjustTracker;
  EventDispatcher dispatcher;

  setUp(() {
    firebaseTracker = _FirebaseTrackerMock();
    adjustTracker = _AdjustTrackerMock();

    dispatcher = EventDispatcher.withTrackers([
      TrackerEntry(_FirebaseEvent, firebaseTracker),
      TrackerEntry(_AdjustEvent, adjustTracker)
    ]);
  });

  test('should NOT send event when NO tracker is assigned', () async {
    // When:
    dispatcher.send(_AdjustEvent());

    // Then:
    verifyNever(firebaseTracker.send(any));
  });

  test('should send event when tracker is assigned', () async {
    // Given:
    final event = _FirebaseEvent();

    // When:
    dispatcher.send(event);

    // Then:
    verify(firebaseTracker.send(event));
  });

  test('should send multiple type event when tracker is assigned', () async {
    // Given:
    final event = _AdjustFirebaseEvent();

    // When:
    dispatcher.send(event);

    // Then:
    verify(firebaseTracker.send(event));
    verify(adjustTracker.send(event));
  });

  test('should send single type event using dispatcher ', () async {
    // Given:
    final event = _FirebaseEvent();

    // When:
    dispatcher.send(event);

    // Then:
    verify(firebaseTracker.send(event));
  });
}

class _FirebaseEvent implements Event {
  @override
  List<Parameter> get parameters => [];

  @override
  List<Type> get types => [_FirebaseEvent];
}

class _AdjustEvent implements Event {
  @override
  List<Parameter> get parameters => [];

  @override
  List<Type> get types => [_AdjustEvent];
}

class _AdjustFirebaseEvent implements Event {
  @override
  List<Parameter> get parameters => [];

  @override
  List<Type> get types => [_AdjustEvent, _FirebaseEvent];
}

class _FirebaseTrackerMock<FirebaseEvent> extends Mock
    implements EventTracker<FirebaseEvent> {
}

class _AdjustTrackerMock<AdjustEvent> extends Mock
    implements EventTracker<AdjustEvent> {
}
