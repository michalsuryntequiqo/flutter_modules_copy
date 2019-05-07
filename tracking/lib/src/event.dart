import 'package:meta/meta.dart';
import 'package:tracking/src/parameter.dart';

@immutable
abstract class Event {
  List<Type> get types;

  List<Parameter> get parameters;
}
