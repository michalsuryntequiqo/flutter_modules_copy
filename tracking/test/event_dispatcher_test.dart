import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking/event.dart';
import 'package:tracking/event_dispatcher.dart';
import 'package:tracking/tracker.dart';
import 'package:tracking/parameter.dart';

main() {
  EventTracker<FirebaseEvent> firebaseTracker;
  EventTracker<AdjustEvent> adjustTracker;
  EventDispatcher dispatcher;

  setUp(() {
    firebaseTracker = _FirebaseTrackerMock();
    adjustTracker = _AdjustTrackerMock();

    dispatcher = EventDispatcher();
    dispatcher.addTracker(FirebaseEvent, firebaseTracker);
    dispatcher.addTracker(AdjustEvent, adjustTracker);
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

abstract class FirebaseEvent extends Event {}
abstract class AdjustEvent extends Event {}

class _FirebaseEvent implements FirebaseEvent {
  @override
  List<Parameter> get parameters => [];

  @override
  List<Type> get types => [FirebaseEvent];
}

class _AdjustEvent implements AdjustEvent {
  @override
  List<Parameter> get parameters => [];

  @override
  List<Type> get types => [AdjustEvent];
}

class _AdjustFirebaseEvent implements AdjustEvent, FirebaseEvent {
  @override
  List<Parameter> get parameters => [];

  @override
  List<Type> get types => [AdjustEvent, FirebaseEvent];
}

class _FirebaseTrackerMock<FirebaseEvent> extends Mock
    implements EventTracker<FirebaseEvent> {
}

class _AdjustTrackerMock<AdjustEvent> extends Mock
    implements EventTracker<AdjustEvent> {
}
