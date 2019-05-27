import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:money/money.dart';
import 'package:pdp/src/data/shop.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String brand;
  final String description;
  final String color;
  final Shop shop;
  final Money price;
  bool _isSaved;

  Product({
    @required this.id,
    @required this.imageUrl,
    this.name = '',
    this.category = '',
    this.brand = '',
    this.description = '',
    this.color = '',
    this.shop,
    this.price,
    bool isSaved = false,
  })  : assert(id != null),
        assert(imageUrl != null),
        this._isSaved = isSaved,
        super([id]);

  bool get isSaved => _isSaved;

  void save() {
    this._isSaved = true;
  }

  void unsave() {
    this._isSaved = false;
  }

  @override
  String toString() {
    return 'Product { $category, $brand }';
  }
}
