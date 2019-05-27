import 'package:meta/meta.dart';

class Shop {
  final String name;
  final String url;

  Shop({@required this.name, this.url}) : assert(name != null);

  bool get hasUrl => url != null;
}
