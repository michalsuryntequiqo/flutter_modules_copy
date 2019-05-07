import 'package:tracking/event.dart';

abstract class AdjustEventType extends Event {
  @override
  List<Type> get types => [AdjustEventType];
}
