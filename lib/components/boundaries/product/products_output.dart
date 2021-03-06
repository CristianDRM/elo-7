import 'package:meta/meta.dart';

class ProductOutput {
  const ProductOutput({
    @required this.price,
    @required this.title,
    @required this.id,
    @required this.link,
    @required this.picture,
  })  : assert(price != null),
        assert(title != null),
        assert(id != null),
        assert(link != null),
        assert(picture != null);

  final ProductPrice price;
  final String title;
  final String id;
  final String link;
  final String picture;

  factory ProductOutput.fromJson(Map<String, dynamic> json) => ProductOutput(
        price: ProductPrice.fromJson(json['price']),
        title: json['title'],
        id: json['id'],
        link: json['_link'],
        picture: json['picture'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductOutput &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          title == other.title &&
          id == other.id &&
          link == other.link &&
          picture == other.picture;

  @override
  int get hashCode =>
      price.hashCode ^
      title.hashCode ^
      id.hashCode ^
      link.hashCode ^
      picture.hashCode;
}

class ProductPrice {
  const ProductPrice({
    @required this.current,
    this.promotional,
    this.installment,
  }) : assert(current != null);
  final String current;
  final String promotional;
  final String installment;

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
        current: json['current'],
        promotional: json['nonPromotional'],
        installment: json['installment'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductPrice &&
          runtimeType == other.runtimeType &&
          current == other.current &&
          promotional == other.promotional &&
          installment == other.installment;

  @override
  int get hashCode =>
      current.hashCode ^ promotional.hashCode ^ installment.hashCode;
}
