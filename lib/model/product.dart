import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  int id;
  String title;
  double price;
  String image;
  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.image});
  factory Product.fromJson(Map<String, dynamic> json) {
    print('json$json');
    return _$ProductFromJson(json);
  }
  //convert json to dart
  Map<String, dynamic> toJson() => _$ProductToJson(this);
//convert dart to json
}
