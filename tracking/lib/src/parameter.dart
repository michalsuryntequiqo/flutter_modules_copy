import 'package:meta/meta.dart';

@immutable
class Parameter {
  final String key;
  final dynamic value;

  Parameter(this.key, this.value);
}
