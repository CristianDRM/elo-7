import 'package:meta/meta.dart';

class ProductViewModel {
  const ProductViewModel({
    @required this.title,
    @required this.price,
    @required this.priceWithDiscount,
    @required this.installment,
    @required this.hasDiscount,
    @required this.hasInstallment,
    @required this.picture,
    @required this.detailUrl,
  })  : assert(title != null),
        assert(price != null),
        assert(detailUrl != null),
        assert(hasDiscount != null),
        assert(picture != null),
        assert(hasInstallment != null);

  final String title;
  final String installment;
  final String price;
  final String picture;
  final String priceWithDiscount;
  final String detailUrl;
  final bool hasDiscount;
  final bool hasInstallment;
}
