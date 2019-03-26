import 'package:tracking/parameter.dart';

abstract class Event {
  List<Type> get types;
  List<Parameter> get parameters;
}

