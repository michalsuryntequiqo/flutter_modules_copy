import 'package:tracking/tracking.dart';

abstract class AdjustEventType extends Event {
  @override
  List<Type> get types => [AdjustEventType];
}
