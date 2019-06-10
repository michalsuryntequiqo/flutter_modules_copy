import 'package:tracking/tracking.dart';

abstract class FirebaseEventType extends Event {
  @override
  List<Type> get types => [FirebaseEventType];
}
